//
//  WeatherAnimationViewController.h
//  Weather
//
//  Created by Scott on 17/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+weather.h"

@interface WeatherAnimationViewController : UIViewController 

@property(weak) IBOutlet UILabel *temperatureLabel;
@property(weak) IBOutlet UIImageView *backgroundImageView;
@property(strong) NSDictionary *weatherDictionary;

-(IBAction)updateBackgroundImage:(id)sender;
-(IBAction)deleteBackgroundImage:(id)sender;

-(void)start:(NSString *)type;
-(void)stop;


@end
