//
//  SSViewController.h
//  SSGestures
//
//  Created by Scott Sherwood on 19/10/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSMovableViewController.h"
@interface SSViewController : UIViewController
{
    SSMovableViewController *mvc;
}

@property(strong,nonatomic)SSMovableViewController *mvc;
@end
