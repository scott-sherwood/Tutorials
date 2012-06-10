//
//  SSViewController.h
//  DragAndDropTutorial
//
//  Created by Scott Sherwood on 06/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSDragAndDropTableViewController.h"
#import "ChoicesTableViewController.h"
#import "SelectedChoicesTableViewController.h"

@interface SSViewController : UIViewController<SSDropableTableViewDelegate>
{
}

@property(strong,nonatomic) IBOutlet SelectedChoicesTableViewController *selectedChoicesViewController;
@property(strong,nonatomic) IBOutlet ChoicesTableViewController *choicesViewController;

@end
