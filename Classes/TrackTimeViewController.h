//
//  TrackTimeViewController.h
//  TimeStash
//
//  Created by Alex Bird on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationData.h"
#import "Activity.h"
#import "ActivityHistory.h"
#import "SummaryTableViewDelegate.h"
#import "EntryListViewController.h"

@interface TrackTimeViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *entryTF;
	IBOutlet UITableView *tableView;
	IBOutlet UILabel *statusL;
	SummaryTableViewDelegate *summaryTVDelegate;
	EntryListViewController *entryListVC;
}

- (IBAction)editAction;
- (IBAction)stopAction;
- (void)startActivity;
- (void)updateStatusLabel;
- (void)update;

@end
