//
//  NewTaskViewController.h
//  MyTasks
//
//  Created by Scott Sherwood on 17/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol NewTaskDelegate;

@interface NewTaskViewController : UIViewController <UITextFieldDelegate>
{
    id<NewTaskDelegate>delegate;
    UITextField *taskNameField;
}

@property(strong,nonatomic)id<NewTaskDelegate>delegate;
@property(strong,nonatomic)IBOutlet UITextField *taskNameField;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

@end

@protocol NewTaskDelegate <NSObject>

-(void)newTaskViewController:(NewTaskViewController *)ntvc didCreateNewTask:(Task *)task;
-(void)cancelNewTaskViewController:(NewTaskViewController *)ntvc;

@end