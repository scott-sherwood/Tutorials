//
//  CustomTabBarViewController.m
//  CustomTabBarExample
//
//  Created by Scott Sherwood on 02/04/2012.
//  Copyright (c) 2012 Scott Sherwood. All rights reserved.
//

#import "SSCustomTabBarViewController.h"

@interface SSCustomTabBarViewController ()

@property (weak, nonatomic) IBOutlet UIView *buttons;

@end

@implementation SSCustomTabBarViewController

@synthesize currentViewController;
@synthesize placeholder;
@synthesize buttons;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSegueWithIdentifier:@"HomeSegue" sender:[self.buttons.subviews objectAtIndex:0]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"HomeSegue"] 
       || [segue.identifier isEqualToString:@"DeveloperSegue"]
       || [segue.identifier isEqualToString:@"DesignerSegue"]){
        
        for (int i=0; i<[self.buttons.subviews count];i++) {
            UIButton *button = (UIButton *)[self.buttons.subviews objectAtIndex:i];
            [button setSelected:NO];
        }
        
        UIButton *button = (UIButton *)sender;
        [button setSelected:YES];
    }
}


@end
