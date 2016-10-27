//
//  ApplicationData.m
//  TimeStash
//
//  Created by Alexander Bird on 4/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ApplicationData.h"

@implementation ApplicationData

@synthesize shortDateFormatter;
@synthesize longDateFormatter;
@synthesize weekOfYearDateFormatter;
@synthesize activityHistory;
@synthesize managedObjectContext;

static ApplicationData *applicationDataSingleton = nil;

+ (ApplicationData *)instance {
	if (applicationDataSingleton == nil) {
		applicationDataSingleton = [[ApplicationData alloc] init];
		
		applicationDataSingleton.shortDateFormatter = [[NSDateFormatter alloc] init];
		[applicationDataSingleton.shortDateFormatter setDateFormat:@"M/d h:mma"];
		
		applicationDataSingleton.longDateFormatter = [[NSDateFormatter alloc] init];
		[applicationDataSingleton.longDateFormatter setDateFormat:@"M/d h:mma"];
		
		applicationDataSingleton.weekOfYearDateFormatter = [[NSDateFormatter alloc] init];
		[applicationDataSingleton.weekOfYearDateFormatter setDateFormat:@"w"];
	}
	
	return applicationDataSingleton;
}

- (int)currentWeekNumber {
	return [[weekOfYearDateFormatter stringFromDate:[NSDate date]] intValue];
}

@end
