//
//  NSDictionary+weather_package.h
//  WeatherTutorial
//
//  Created by Scott on 19/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (weather_package)

-(NSDictionary *)currentCondition;
-(NSDictionary *)request;
-(NSArray *)commingWeather;

@end
