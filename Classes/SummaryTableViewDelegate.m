//
//  SummaryTableViewDelegate.m
//  TimeStash
//
//  Created by Alex Bird on 9/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SummaryTableViewDelegate.h"


@implementation SummaryTableViewDelegate

- (void)updateActivitySummary {
	//NSLog(@"Updating activity summary...");
	activitySummary = [[ApplicationData instance].activityHistory activitySummary];
	[keysSortedByWeekNumber release];
	keysSortedByWeekNumber = [[activitySummary allKeys] sortedArrayUsingComparator:^(id a, id b)
							  {
								  if ([a intValue] == [b intValue]) return NSOrderedSame;
								  else if ([a intValue] > [b intValue]) return NSOrderedAscending;
								  else return NSOrderedDescending;
							  }];
	[keysSortedByWeekNumber retain];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [keysSortedByWeekNumber count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	int weekNum = [[keysSortedByWeekNumber objectAtIndex:section] intValue];
	int currentWeekNum = [[ApplicationData instance] currentWeekNumber];
	int weekDiff = currentWeekNum - weekNum;
	NSString *weekText;
	switch (weekDiff) {
		case 0:
			weekText = @"This Week";
			break;
		case 1:
			weekText = @"Last Week";
			break;
		default:
			weekText = [NSString stringWithFormat:@"%d Weeks Ago", weekDiff];
			break;
	}
	return weekText;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSMutableDictionary *activityDict = [activitySummary objectForKey:[keysSortedByWeekNumber objectAtIndex:section]];
    return [activityDict count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
	
	//NSLog(@"%d", indexPath.section);
	NSMutableDictionary *activityDict = [activitySummary objectForKey:[keysSortedByWeekNumber objectAtIndex:indexPath.section]];
	NSArray *sortedKeys = [activityDict keysSortedByValueUsingSelector:@selector(compare:)];
	int keysSize = [sortedKeys count];
	NSString *key = [sortedKeys objectAtIndex:(keysSize - 1 - indexPath.row)];
	double seconds = [[activityDict objectForKey:key] doubleValue];
	double hours = seconds / 3600.0;
	int minutes = (hours - (int)hours) * 60;
    cell.textLabel.text = key;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%d:%02d hours", (int) hours, minutes];
	
	if (indexPath.section == 0 && [key isEqualToString:[[ApplicationData instance].activityHistory currentActivity].name]) {
		cell.textLabel.textColor = [[UIColor alloc] initWithRed:0.0 green:133.0/255.0 blue:178.0/255.0 alpha:1.0];
	}
	else {
		cell.textLabel.textColor = [UIColor blackColor];
	}

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


- (void)dealloc {
    [super dealloc];
}


@end

