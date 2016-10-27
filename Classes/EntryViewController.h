//
//  EntryViewController.h
//  TimeStash
//
//  Created by Alex Bird on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationData.h"
#import "Activity.h"
#import "ActivityHistory.h"
#import "TextFieldViewController.h"
#import "DatePickerViewController.h"


@interface EntryViewController : UITableViewController <TextFieldVCDelegate, DatePickerVCDelegate> {
	Activity *activity;
	IBOutlet UIBarButtonItem *saveB, *cancelB;
}

@property(nonatomic, retain) Activity *activity;

- (IBAction)saveAction;
- (IBAction)cancelAction;

@end
