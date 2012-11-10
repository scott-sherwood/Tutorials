//
//  SSViewController.m
//  PhotoLibrary
//
//  Created by Scott on 26/10/2012.
//  Copyright (c) 2012 scott-sherwood. All rights reserved.
//

#import "SSViewController.h"


@interface SSViewController ()

@property(weak) IBOutlet UIImageView *displayImage;
@property(strong) UIPopoverController *popover;

@end

@implementation SSViewController

@synthesize displayImage, popover;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"LibrarySegue"]){
        LibraryCollectionViewController *lcvc = segue.destinationViewController;
        lcvc.delegate = self;
        
        UIStoryboardPopoverSegue *s = (UIStoryboardPopoverSegue *)segue;
        self.popover = s.popoverController;
    }
}

-(void)shouldShowImageWithName:(NSString *)name{
    self.displayImage.image = [UIImage imageNamed:name];
    [self.popover dismissPopoverAnimated:YES];
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.popover = nil;
}

@end
