//
//  TextFieldViewController.h
//  TimeStash
//
//  Created by Alex Bird on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextFieldVCDelegate <NSObject>

@required
- (void)valueUpdated:(NSString *)value;

@end


@interface TextFieldViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *textField;
	IBOutlet UIBarButtonItem *doneB, *cancelB;
	id <TextFieldVCDelegate> *delegate;
	NSString *fieldName_;
	NSString *initialValue_;
}

@property(nonatomic, retain, readonly) IBOutlet UITextField *textField;
@property(nonatomic, retain) id <TextFieldVCDelegate> *delegate;

- (id)initWithInitialValue:(NSString *)initialValue andFieldName:(NSString *)fieldName;
- (IBAction)doneAction;
- (IBAction)cancelAction;

@end
