//
//  SummaryTableViewDelegate.h
//  TimeStash
//
//  Created by Alex Bird on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
#import "ActivityHistory.h"
#import "ApplicationData.h"


@interface SummaryTableViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource> {
	NSMutableDictionary *activitySummary;
	NSArray *keysSortedByWeekNumber;
}

- (void)updateActivitySummary;

@end
