//
//  EntryViewController.m
//  TimeStash
//
//  Created by Alex Bird on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EntryViewController.h"


@implementation EntryViewController

@synthesize activity;

- (IBAction)saveAction {
	NSError *error;
	if (![[ApplicationData instance].managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelAction {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.title = @"Edit";
    self.navigationItem.rightBarButtonItem = saveB;
	self.navigationItem.leftBarButtonItem = cancelB;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		if (indexPath.section == 3) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleGray;
		}
		else {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		}
    }
    
	if (indexPath.section == 0) {
		cell.textLabel.text = @"Name";
		cell.detailTextLabel.text = activity.name;
	}
	else if (indexPath.section == 1) {
		cell.textLabel.text = @"Start Time";
		cell.detailTextLabel.text = [[ApplicationData instance].longDateFormatter stringFromDate:activity.startTime];
	}
	else if (indexPath.section == 2) {
		cell.textLabel.text = @"End Time";
		
		if (activity.endTime != nil) {
			cell.detailTextLabel.text = [[ApplicationData instance].longDateFormatter stringFromDate:activity.endTime];
			cell.userInteractionEnabled = YES;
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		}
		else {
			cell.detailTextLabel.text = @"now";
			cell.userInteractionEnabled = NO;
			[cell setAccessoryType:UITableViewCellAccessoryNone];
		}

	}
	else if (indexPath.section == 3) {
		cell.textLabel.text = @"Delete";
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		[cell setAccessoryType:UITableViewCellAccessoryNone];
		cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"button_red-150x45.png"]];
		cell.textLabel.textColor = [UIColor whiteColor];
	}
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (activity.endTime == nil && section == 2) {
		return [NSString stringWithFormat:@"You are doing \"%@\" right now.", activity.name];
	}
	return nil;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		TextFieldViewController *nameVC = [[TextFieldViewController alloc] initWithInitialValue:activity.name andFieldName:@"Name"];
		nameVC.delegate = self;
		[self.navigationController pushViewController:nameVC animated:YES];
		[nameVC release];
	}
	else if (indexPath.section == 1) {
		DatePickerViewController *startTimeVC = [[DatePickerViewController alloc] initWithInitialValue:activity.startTime andFieldName:@"Start Time"];
		startTimeVC.delegate = self;
		[self.navigationController pushViewController:startTimeVC animated:YES];
		[startTimeVC release];
	}
	else if (indexPath.section == 2) {
		if (activity.endTime != nil) {
			DatePickerViewController *startTimeVC = [[DatePickerViewController alloc] initWithInitialValue:activity.endTime andFieldName:@"End Time"];
			startTimeVC.delegate = self;
			[self.navigationController pushViewController:startTimeVC animated:YES];
			[startTimeVC release];
		}
	}
	else if (indexPath.section == 3) {
		[[ApplicationData instance].activityHistory deleteActivity:activity];
		[self.parentViewController dismissModalViewControllerAnimated:YES];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Reusable View Controller Methods

- (void)valueUpdated:(NSString *)value {
	NSString *trimmed = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if (![trimmed isEqualToString:@""]) {
		activity.name = value;
		self.navigationItem.prompt = nil;
	}
	else {
		self.navigationItem.prompt = @"Name cannot be blank.";
	}

}

- (void)dateUpdated:(NSDate *)date forFieldName:(NSString *)fieldName {
	if ([fieldName isEqualToString:@"Start Time"]) {
		if (activity.endTime != nil) {
			if([date compare:activity.endTime] == NSOrderedAscending) {
				activity.startTime = date;
				self.navigationItem.prompt = nil;
			}
			else {
				self.navigationItem.prompt = @"Start Time must be before end time.";
			}
		}
		else {
			if([date compare:[NSDate date]] == NSOrderedAscending) {
				activity.startTime = date;
				self.navigationItem.prompt = nil;
			}
			else {
				self.navigationItem.prompt = @"Start Time must be before current time.";
			}
		}
	}
	else if ([fieldName isEqualToString:@"End Time"]) {
		if ([date compare:activity.startTime] == NSOrderedDescending) {
			activity.endTime = date;
			self.navigationItem.prompt = nil;
		}
		else {
			self.navigationItem.prompt = @"End Time must be after start time.";
		}

	}
}


@end

