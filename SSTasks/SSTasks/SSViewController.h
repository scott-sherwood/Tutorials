//
//  SSViewController.h
//  MyTasks
//
//  Created by Scott Sherwood on 17/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h" 
#import "NewTaskViewController.h"

@interface SSViewController : UITableViewController <NewTaskDelegate>
{
    NSArray *pendingTasks;
}

@property(strong,nonatomic) NSArray *pendingTasks;


-(void)addTask:(Task *)task;
-(void)refreshPendingTasks;
-(void)setTaskCompleted:(Task *)task;

@end
