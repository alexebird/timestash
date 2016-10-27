//
//  TextFieldViewController.h
//  TimeStash
//
//  Created by Alex Bird on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplicationData.h"

@protocol DatePickerVCDelegate <NSObject>

@required
- (void)dateUpdated:(NSDate *)date forFieldName:(NSString *)fieldName;

@end


@interface DatePickerViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate> {
	IBOutlet UITextField *textField;
	IBOutlet UIDatePicker *datePicker;
	IBOutlet UIBarButtonItem *doneB, *cancelB;
	id <DatePickerVCDelegate> *delegate;
	NSDate *initialValue_;
	NSString *fieldName_;
}

@property(nonatomic, retain) id <DatePickerVCDelegate> *delegate;

- (id)initWithInitialValue:(NSDate *)initialValue andFieldName:(NSString *)fieldName;
- (IBAction)doneAction;
- (IBAction)cancelAction;
- (IBAction)valueChanged;

@end
