//
//  DropableDelegate.h
//  test
//
//  Created by Scott Sherwood on 06/11/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSDropableTableViewDelegate <NSObject>

-(void)dragAndDropTableViewController:(SSDragAndDropTableViewController *)ddtvc droppedGesture:(UIGestureRecognizer *)gesture;

@end  
