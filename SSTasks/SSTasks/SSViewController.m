//
//  SSViewController.m
//  MyTasks
//
//  Created by Scott Sherwood on 17/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "SSViewController.h"
#import "SimplePost.h"


@implementation SSViewController

@synthesize pendingTasks;

static NSString *kPendingTasks = @"http://localhost/~scott/my_tasks/pending_tasks.php";
static NSString *kSetTaskCompleted = @"http://localhost/~scott/my_tasks/set_task_completed.php";
static NSString *kAddTask = @"http://localhost/~scott/my_tasks/add_task.php";

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - NewTaskDelegate

-(void)newTaskViewController:(NewTaskViewController *)ntvc didCreateNewTask:(Task *)task{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [self addTask:task];
}

-(void)cancelNewTaskViewController:(NewTaskViewController *)ntvc{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - NSURLConnectionDelegate

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
        NSArray *array = (NSArray *)[NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:0 errorDescription:nil];
        NSMutableArray *ma = [NSMutableArray array];
        for(int i=0;i<[array count];i++){
            NSDictionary *d = (NSDictionary *)[array objectAtIndex:i];
            Task *task = [[Task alloc] initWithDictionary:d];
            [ma addObject:task];
        }
        self.pendingTasks = ma;
        [self.tableView reloadData];    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"did fail");
}

#pragma mark -Server Actions

-(void)addTask:(Task *)task{
    NSMutableURLRequest *request = [SimplePost urlencodedRequestWithURL:[NSURL URLWithString:kAddTask] andDataDictionary:[task toDictionary]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)setTaskCompleted:(Task *)task{
    NSMutableURLRequest *request = [SimplePost urlencodedRequestWithURL:[NSURL URLWithString:kSetTaskCompleted] andDataDictionary:[task toDictionary]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


#pragma mark - View lifecycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"NewTask"]){
        UINavigationController *nv = (UINavigationController *)[segue destinationViewController];
        NewTaskViewController *ntvc = (NewTaskViewController *)nv.topViewController;
        ntvc.delegate = self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kPendingTasks]];
    
    
    NSString *params = [[NSString alloc] initWithFormat:@"foo=bar&key=value"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [pendingTasks count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Task *t = [pendingTasks objectAtIndex:indexPath.row];
    cell.textLabel.text = t.name;
    
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
    
    Task *task = [self.pendingTasks objectAtIndex:indexPath.row];
    [self setTaskCompleted:task];
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end
