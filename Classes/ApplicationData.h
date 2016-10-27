//
//  ApplicationData.h
//  TimeStash
//
//  Created by Alexander Bird on 4/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//  
//  A singleton class to store top-level application data.
//

#import <Foundation/Foundation.h>


@class ActivityHistory;


@interface ApplicationData : NSObject {
	NSDateFormatter *shortDateFormatter, *longDateFormatter, *weekOfYearDateFormatter;
	ActivityHistory *activityHistory;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSDateFormatter *shortDateFormatter;
@property (nonatomic, retain) NSDateFormatter *longDateFormatter;
@property (nonatomic, retain) NSDateFormatter *weekOfYearDateFormatter;
@property (nonatomic, retain) ActivityHistory *activityHistory;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


+ (ApplicationData *)instance;

- (int)currentWeekNumber;

@end
