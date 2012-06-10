//
//  DragAndDropTableViewController.m
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "SSDragAndDropTableViewController.h"
#import "SSDraggableTableViewDelegate.h"
#import "SSDropableTableViewDelegate.h"

@implementation SSDragAndDropTableViewController

@synthesize dragAndDropItem, draggableDelegate, dropableDelegate;



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




#pragma mark - Gesture Recogniser

-(void)longGestureAction:(UILongPressGestureRecognizer *)gesture{
    UITableViewCell *cell= (UITableViewCell *)[gesture view];
   
    
    switch ([gesture state]) {
        case UIGestureRecognizerStateBegan:{
            
            NSIndexPath *ip = [self.tableView indexPathForCell:cell];
            [self.tableView setScrollEnabled:NO];
            if(ip!=nil){
                
            
                [self.draggableDelegate dragAndDropTableViewController:self  draggingGestureWillBegin:gesture forCell:cell];
                
                UIView *draggedView = [self.draggableDelegate dragAndDropTableViewControllerView:self ];
                //switch the view the gesture is associated with this will allow the dragged view to continue on where the cell leaves off from
                [draggedView addGestureRecognizer:[[cell gestureRecognizers]objectAtIndex:0]]; 
                
                [self.draggableDelegate dragAndDropTableViewController:self draggingGestureDidBegin:gesture forCell:cell];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.draggableDelegate dragAndDropTableViewController:self draggingGestureDidMove:gesture];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            UIView *draggedView = [self.draggableDelegate dragAndDropTableViewControllerView:self];
            
            
            if(draggedView==nil)
                return;
           
            //might not be right to have both here but you need two different delegates so different controllers can controll different things
            [self.draggableDelegate dragAndDropTableViewController:self draggingGestureDidEnd:gesture];
            [self.dropableDelegate dragAndDropTableViewController:self droppedGesture:gesture];           
           
            [self.tableView setScrollEnabled:YES];
            [self.tableView reloadData];
        }
            break;
        
//        case UIGestureRecognizerStateCancelled:
//        case UIGestureRecognizerStateFailed:
//        case UIGestureRecognizerStatePossible:
//            [self.dragAndDropDelegate dragAndDropTableViewController:self draggingGesture:gesture endedForItem:nil];
            break;
        default:
            break;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
        [gestureRecognizer addTarget:self action:@selector(longGestureAction:)];
    }
   
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}



@end
