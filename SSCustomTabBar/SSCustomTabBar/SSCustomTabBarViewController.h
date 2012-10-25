//
//  CustomTabBarViewController.h
//  CustomTabBarExample
//
//  Created by Scott Sherwood on 02/04/2012.
//  Copyright (c) 2012 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSCustomTabBarViewController : UIViewController

@property(weak,nonatomic)UIViewController *currentViewController;
@property(weak,nonatomic)IBOutlet UIView *placeholder;



@end
