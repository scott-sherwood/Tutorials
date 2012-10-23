//
//  SSViewController.h
//  Demo
//
//  Created by Scott on 24/10/2012.
//  Copyright (c) 2012 scott-sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCollectionViewController.h"

@interface SSViewController : UIViewController <SSCollectionViewDelegate, UIPopoverControllerDelegate>

@property(weak) IBOutlet UIImageView *imageView;

@end
