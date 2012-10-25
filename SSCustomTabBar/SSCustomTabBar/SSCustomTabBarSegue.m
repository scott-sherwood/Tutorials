//
//  CustomTabBarSegue.m
//  CustomTabBarExample
//
//  Created by Scott Sherwood on 03/04/2012.
//  Copyright (c) 2012 Scott Sherwood. All rights reserved.
//

#import "SSCustomTabBarSegue.h"
#import "SSCustomTabBarViewController.h"

@implementation SSCustomTabBarSegue
- (void) perform {
    
    SSCustomTabBarViewController *ctbcv = (SSCustomTabBarViewController *)self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    for(UIView *view in ctbcv.placeholder.subviews){
        [view removeFromSuperview];
    }
    
        
    ctbcv.currentViewController = dst;
    [ctbcv addChildViewController:dst];
    [ctbcv.placeholder addSubview:dst.view];
}

@end
