//
//  ActivityHistory.h
//  TimeStash
//
//  Created by Alex Bird on 9/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"
#import "ApplicationData.h"


@interface ActivityHistory : NSObject {
	NSMutableArray *activities;
}

@property(nonatomic, retain) NSMutableArray *activities;

- (id)init;

- (Activity *)currentActivity;
- (void)endCurrentActivity;
- (void)startNewActivity:(NSString *)name;
- (void)loadActivitiyHistory;
+ (NSInteger)activityWeek:(Activity *)a;
+ (NSTimeInterval)elapsedActivityTime:(Activity *)a;
- (NSMutableDictionary *)activitySummary;
- (void)deleteActivity:(Activity *)activity;

@end
