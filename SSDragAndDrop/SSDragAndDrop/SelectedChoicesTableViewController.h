//
//  SelectedChoicesTableViewController.h
//  test
//
//  Created by Scott Sherwood on 05/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSDragAndDropTableViewController.h"
#import "SSDraggableTableViewDelegate.h"
#import "SSDropableTableViewDelegate.h"

@interface SelectedChoicesTableViewController : SSDragAndDropTableViewController <SSDraggableTableViewDelegate>
{
    NSMutableArray *_selectedChoices;
    
    id _selectedChoice;
    
    UIView *_dragAndDropView;
}


@property(strong,nonatomic) UIView *dragAndDropView;
@property(strong,nonatomic) id selectedChoice;
@property(strong,nonatomic)NSMutableArray *selectedChoices;

@end
