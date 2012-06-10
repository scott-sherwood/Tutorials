//
//  SSMovableViewController.h
//  SSGestures
//
//  Created by Scott Sherwood on 19/10/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSMovableViewController : UIViewController <UIGestureRecognizerDelegate>
{
    CGPoint prevPanPoint;
    float prevPinchScale;
    float prevRotation;
}
@end
