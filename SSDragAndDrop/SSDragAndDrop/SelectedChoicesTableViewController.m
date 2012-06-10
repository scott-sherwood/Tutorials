//
//  SelectedChoicesTableViewController.m
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "SelectedChoicesTableViewController.h"

@implementation SelectedChoicesTableViewController

@synthesize selectedChoices = _selectedChoices, selectedChoice = _selectedChoice, dragAndDropView = _dragAndDropView;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.draggableDelegate = self;
    
    self.selectedChoices = [NSMutableArray array];
    [self.selectedChoices addObject:@"Selected 1"];
    [self.selectedChoices addObject:@"Selected 2"];
    [self.selectedChoices addObject:@"Selected 3"];
    [self.selectedChoices addObject:@"Selected 4"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Drag and Drop Delegate
-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureDidBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell;
{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.selectedChoice =[self.selectedChoices objectAtIndex:indexPath.row];  
    
    [self.selectedChoices removeObjectAtIndex:[self.selectedChoices indexOfObject:self.selectedChoice]];
    
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    
}



-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureWillBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell{
    
    UIGraphicsBeginImageContext(cell.contentView.bounds.size);
    [cell.contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    self.dragAndDropView = [[UIView alloc]initWithFrame:iv.frame];
    [self.dragAndDropView addSubview:iv];
    [self.dragAndDropView setBackgroundColor:[UIColor blueColor]];
    [self.dragAndDropView setCenter:[gesture locationInView:self.view.superview]];
    
    [self.view.superview addSubview:self.dragAndDropView];
}

-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureDidMove:(UIGestureRecognizer *)gesture{
    [self.dragAndDropView setCenter:[gesture locationInView:self.view.superview]];
}


-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureDidEnd:(UIGestureRecognizer *)gesture{
    
    [self.dragAndDropView removeFromSuperview];
    self.dragAndDropView = nil;
}


-(UIView *)dragAndDropTableViewControllerView:(SSDragAndDropTableViewController *)ddtvc{
    return self.dragAndDropView;
}

-(id)dragAndDropTableViewControllerSelectedItem:(SSDragAndDropTableViewController *)ddtvc{
    return _selectedChoice;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 return [self.selectedChoices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:cell action:nil];
    longPress.delegate = self;
    [cell addGestureRecognizer:longPress];
    
    NSString *selectedChoice = [self.selectedChoices objectAtIndex:indexPath.row];
    
    cell.textLabel.text = selectedChoice;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
