//
//  ActivityHistory.m
//  TimeStash
//
//  Created by Alex Bird on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ActivityHistory.h"


@implementation ActivityHistory

@synthesize activities;

- (id)init {
	[self loadActivitiyHistory];
	
    return self;
}

- (Activity *)currentActivity {
	Activity *last = [activities lastObject];

	if (last.endTime == nil) {
		return last;
	}
	else {
		return nil;
	}
}

- (void)endCurrentActivity {
	Activity *current = [self currentActivity];
	if (current != nil) {
		NSDate *now = [NSDate date];
		current.endTime = now;
		
		NSError *error;
		if (![[ApplicationData instance].managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		
	}
}

- (void)startNewActivity:(NSString *)name {
	NSDate *now = [NSDate date];
	
	Activity *activity = (Activity *)[NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:[ApplicationData instance].managedObjectContext];
	activity.name = name;
	activity.startTime = now;
	
	NSError *error;
	if (![[ApplicationData instance].managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	[activities addObject:activity];
}

- (void)loadActivitiyHistory {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Activity" inManagedObjectContext:[ApplicationData instance].managedObjectContext];
	[request setEntity:entity];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	NSError *error;
	NSMutableArray *mutableFetchResults = [[[ApplicationData instance].managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	activities = mutableFetchResults;
	[request release];
	
//	for (int i = 0; i < activities.count; i++) {
//		Activity *a = [activities objectAtIndex:i];
//		NSLog(@"%@ from %@ to %@", a.name, [[ApplicationData instance].shortDateFormatter stringFromDate:a.startTime], [[ApplicationData instance].shortDateFormatter stringFromDate:a.endTime]);
//	}
	
}

+ (NSInteger)activityWeek:(Activity *)a {
	NSString *formattedStr = [[ApplicationData instance].weekOfYearDateFormatter stringFromDate:a.startTime];
	return [formattedStr intValue];
}

+ (NSTimeInterval)elapsedActivityTime:(Activity *)a {
	NSDate *endTime = a.endTime;
	if (a.endTime == nil) {
		endTime = [NSDate date];
	}
	return [endTime timeIntervalSinceDate:a.startTime];
}

- (NSMutableDictionary *)activitySummary {
	NSMutableDictionary *summary = [[NSMutableDictionary alloc] initWithCapacity:1000];
	
	for (int i = 0; i < [activities count]; i++) {
		Activity *a = [activities objectAtIndex:i];
		NSNumber *weekNum = [NSNumber numberWithInt:[ActivityHistory activityWeek:a]];
		
		if ([summary objectForKey:weekNum] == nil) {
			[summary setObject:[[NSMutableDictionary alloc] initWithCapacity:10] forKey:weekNum];
		}
		
		NSMutableDictionary *activityBucket = [summary objectForKey:weekNum];
		
		if ([activityBucket objectForKey:a.name] == nil) {
			[activityBucket setObject:[NSNumber numberWithDouble:0.0] forKey:a.name];
		}
		
		double oldElapsedTime = [[activityBucket objectForKey:a.name] doubleValue];
		NSNumber *elapsedTime = [NSNumber numberWithDouble:(oldElapsedTime + [ActivityHistory elapsedActivityTime:a])];
		[activityBucket setObject:elapsedTime forKey:a.name];
	}
	
	return summary;
}

- (void)deleteActivity:(Activity *)activity {
	[activities removeObject:activity];
	[[ApplicationData instance].managedObjectContext deleteObject:activity];
	NSError *error;
	if (![[ApplicationData instance].managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

@end
