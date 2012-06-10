//
//  NewTaskViewController.m
//  MyTasks
//
//  Created by Scott Sherwood on 17/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "NewTaskViewController.h"

@implementation NewTaskViewController

@synthesize delegate,taskNameField;



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Actions

-(IBAction)cancel:(id)sender{
    [self.delegate cancelNewTaskViewController:self];
}

-(IBAction)done:(id)sender{
    if([self.taskNameField.text length]<=0)
    {
        NSLog(@"You have not entered a name for this task %@",self.taskNameField.text);
        return;
    }
    
    Task *newTask = [[Task alloc] initWithName:taskNameField.text];
    
    [self.delegate newTaskViewController:self didCreateNewTask:newTask];
}

#pragma mark - TextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
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



@end
