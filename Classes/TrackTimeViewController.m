//
//  TrackTimeViewController.m
//  TimeStash
//
//  Created by Alex Bird on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TrackTimeViewController.h"


@implementation TrackTimeViewController

- (IBAction)editAction {
	[self.navigationController pushViewController:entryListVC animated:YES];
}

- (IBAction)stopAction {
	[[ApplicationData instance].activityHistory endCurrentActivity];
	[self update];
}

- (void)startActivity {
	NSString *name = [entryTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	entryTF.text = @"";
	[entryTF resignFirstResponder];
	if (![name isEqualToString:@""]) {
		[[ApplicationData instance].activityHistory endCurrentActivity];
		[[ApplicationData instance].activityHistory startNewActivity:name];
	}
	[self update];
}

- (void)updateStatusLabel {
	Activity *curr = [[ApplicationData instance].activityHistory currentActivity];
	
	if (curr == nil) {
		statusL.text = @"Not doing anything";
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}
	else {
		statusL.text = [NSString stringWithFormat:@"Currently doing \"%@\".", curr.name];
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
}

- (void)update {
	[summaryTVDelegate updateActivitySummary];
	[tableView reloadData];
	[self updateStatusLabel];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self startActivity];
	return YES;
}

/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// Custom initialization goes here...
	}
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	summaryTVDelegate = [[SummaryTableViewDelegate alloc] init];
	entryListVC = [[EntryListViewController alloc] initWithNibName:@"EntryListViewController" bundle:nil];

	[tableView setAllowsSelection:NO];
	[tableView setDelegate:summaryTVDelegate];
	[tableView setDataSource:summaryTVDelegate];
}

- (void)viewWillAppear:(BOOL)animated {
	[self update];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
