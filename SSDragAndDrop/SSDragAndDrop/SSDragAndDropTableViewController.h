//
//  DragAndDropTableViewController.h
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSDraggableTableViewDelegate;
@protocol SSDropableTableViewDelegate;

@interface SSDragAndDropTableViewController : UITableViewController <UIGestureRecognizerDelegate>{
   
    id<SSDraggableTableViewDelegate> draggableDelegate;
    id<SSDropableTableViewDelegate> dropableDelegate;
    id dragAndDropItem;
  
}

@property(strong,nonatomic) id<SSDropableTableViewDelegate> dropableDelegate;
@property(strong,nonatomic) id<SSDraggableTableViewDelegate> draggableDelegate;
@property(strong,nonatomic) id dragAndDropItem;

@end

