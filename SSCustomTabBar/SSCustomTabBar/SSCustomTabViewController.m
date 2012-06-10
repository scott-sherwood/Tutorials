//
//  CustomTabViewController.m
//  CustomTabBarExample
//
//  Created by Scott Sherwood on 02/04/2012.
//  Copyright (c) 2012 Scott Sherwood. All rights reserved.
//

#import "SSCustomTabViewController.h"

@interface SSCustomTabViewController ()



@end

@implementation SSCustomTabViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;//UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


@end
