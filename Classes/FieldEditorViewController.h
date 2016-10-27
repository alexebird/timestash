//
//  FieldEditorViewController.h
//  TimeLog
//
//  Created by Alex Bird on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FieldEditorVCDelegate <NSObject>

@required
- (void)fieldUpdated:(id)newValue;

@end

@interface FieldEditorViewController : UIViewController {
	IBOutlet UIBarButtonItem *doneB;
	id <DatePickerVCDelegate> *delegate;
	NSDate *initialValue_;
}

@property(nonatomic, retain) id <DatePickerVCDelegate> *delegate;

- (id)initWithInitialValue:(id)initialValue fieldName:(NSString *)fieldName;

@end
