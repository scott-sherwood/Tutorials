//
//  DraggableTableViewDelegate.h
//  test
//
//  Created by Scott Sherwood on 06/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSDragAndDropTableViewController.h"


@protocol SSDraggableTableViewDelegate <NSObject>

-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureWillBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell;
-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureDidBegin:(UIGestureRecognizer *)gesture forCell:(UITableViewCell *)cell;
-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureDidMove:(UIGestureRecognizer *)gesture;
-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc draggingGestureDidEnd:(UIGestureRecognizer *)gesture;

-(UIView *)dragAndDropTableViewControllerView:(SSDragAndDropTableViewController *)ddtvc;
-(id)dragAndDropTableViewControllerSelectedItem:(SSDragAndDropTableViewController *)ddtvc;

@end  
