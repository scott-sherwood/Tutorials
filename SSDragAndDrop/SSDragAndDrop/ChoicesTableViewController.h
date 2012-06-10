//
//  ChoicesTableViewController.h
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSDragAndDropTableViewController.h"
#import "SSDraggableTableViewDelegate.h"
#import "SSDropableTableViewDelegate.h"

@interface ChoicesTableViewController : SSDragAndDropTableViewController <SSDraggableTableViewDelegate>
{
    NSMutableArray *_choices;
    id _selectedChoice;
    UIView *_dragAndDropView;
}


@property(strong,nonatomic) UIView *dragAndDropView;
@property(strong,nonatomic) id selectedChoice;
@property(strong,nonatomic) NSMutableArray *choices;

@end
