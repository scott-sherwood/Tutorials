//
//  SSFirstViewController.m
//  Clock
//
//  Created by Scott on 28/09/2013.
//  Copyright (c) 2013 ScottSherwood. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()

@property IBOutlet UILabel *label;
@property NSTimer *timer;
@property NSDateFormatter *dateFormatter;

@end

@implementation ClockViewController

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


-(void)viewWillAppear:(BOOL)animated{
    
    if(self.dateFormatter==nil){
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"hh:mm:ss"];
    }
    
    [self tick:nil];

    
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

-(void)tick:(NSTimer *)t{
    
    self.label.text = [self.dateFormatter stringFromDate:[NSDate date]];

}

@end
