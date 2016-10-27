//
//  EntryListViewController.h
//  TimeStash
//
//  Created by Alex Bird on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationData.h"
#import "ActivityHistory.h"
#import "Activity.h"
#import "EntryViewController.h"


@interface EntryListViewController : UITableViewController {
	EntryViewController *entryVC;
}

@end
