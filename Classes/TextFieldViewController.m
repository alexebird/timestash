//
//  TextFieldViewController.m
//  TimeStash
//
//  Created by Alex Bird on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TextFieldViewController.h"


@implementation TextFieldViewController

@synthesize textField;
@synthesize delegate;

- (IBAction)doneAction {
	[delegate valueUpdated:textField.text];
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)cancelAction {
	[self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithInitialValue:(NSString *)initialValue andFieldName:(NSString *)fieldName {
	if ((self = [super initWithNibName:@"TextFieldViewController" bundle:nil])) {
        fieldName_ = fieldName;
		initialValue_ = initialValue;
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self doneAction];
	return YES;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	textField.placeholder = fieldName_;
	textField.text = initialValue_;
	self.navigationItem.rightBarButtonItem = doneB;
	self.navigationItem.leftBarButtonItem = cancelB;
	self.navigationItem.title = [NSString stringWithFormat:@"Edit %@", fieldName_];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
