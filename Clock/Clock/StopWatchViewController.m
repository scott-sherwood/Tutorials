//
//  SSSecondViewController.m
//  Clock
//
//  Created by Scott on 28/09/2013.
//  Copyright (c) 2013 ScottSherwood. All rights reserved.
//

#import "StopWatchViewController.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"


@interface StopWatchViewController ()

@property IBOutlet UILabel *label;
@property IBOutlet UIButton *toggle;

@property NSTimer *timer;
@property NSDateFormatter *dateFormatter;
@property int ticks;

@end

@implementation StopWatchViewController

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
        [self.dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

/********** Using the default tracker **********/
    id tracker = [[GAI sharedInstance] defaultTracker];
      
/**********Manual screen recording**********/
//  [tracker set:kGAIScreenName value:@"Stopwatch"];
//  [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
/**********Setting and Sending Data**********/
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"appview", kGAIHitType, @"Stopwatch1", kGAIScreenName, nil];
//    [tracker send:params];
    
    
    /* MapBuilder class simplifies the process of building hits */
    [tracker send:[[[GAIDictionaryBuilder createAppView] set:@"Stopwatch2" forKey:kGAIScreenName] build]];
}

-(IBAction)startToggle:(id)sender{
    [self logButtonPress:sender];
    if(self.timer){
        [self stop:sender];
        [self.toggle setTitle:@"Start" forState:UIControlStateNormal];
    }
    else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.0166 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        [self.toggle setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

-(IBAction)reset:(id)sender{
    [self logButtonPress:sender];
    [self stop:sender];
    [self.toggle setTitle:@"Start" forState:UIControlStateNormal];
    
    self.ticks = 0;
    self.label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",0,0,0];
}

-(void)logButtonPress:(id)sender{
    
    if(![sender isKindOfClass:[UIButton class]]){
        return NSLog(@"Only logging button presses in this method");
    }
    
    UIButton *but = (UIButton *)sender;
    NSLog(@"%@",but.titleLabel.text);
    
/********** Applying Values to Multiple Hits********/
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    /* Set the screen name on the tracker */
    [tracker set:kGAIScreenName value:@"Stopwatch"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
/********** Measuring Events**********/
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[but.titleLabel text]
                                                           value:nil] build]];
    
    // Clear the screen name field when we're done.
    [tracker set:kGAIScreenName value:nil];
}



-(void)stop:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
}



-(void)tick:(NSTimer *)t{
    self.ticks++;
    
    int lt = self.ticks % 100;
    int sec = floor((self.ticks / 100)%60);
    int min = floor((self.ticks / 100)/60);
    
    self.label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",min,sec,lt];
}


@end
