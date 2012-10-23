//
//  SSViewController.m
//  Demo
//
//  Created by Scott on 24/10/2012.
//  Copyright (c) 2012 scott-sherwood. All rights reserved.
//

#import "SSViewController.h"

@interface SSViewController ()

@property(strong)UIPopoverController *popover;

@end

@implementation SSViewController

@synthesize imageView, popover;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setToolbarHidden:NO];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ImagePickerSegue"]){
        UIStoryboardPopoverSegue *s = (UIStoryboardPopoverSegue *)segue;
        self.popover = s.popoverController;
        
        SSCollectionViewController *cvc = (SSCollectionViewController *)segue.destinationViewController;
        cvc.delegate = self;
    }
}

#pragma mark SSCollectionViewDelegate

-(void)collectionViewController:(SSCollectionViewController *)cvc didSelectIndexPath:(NSIndexPath *)indexPath{
    
    int imageNumber = indexPath.row % 10;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",imageNumber]];
    
    [self.popover dismissPopoverAnimated:YES];
    
    NSLog(@"update image and remove popover");
}

#pragma mark PopoverDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    self.popover = nil;
}

@end
