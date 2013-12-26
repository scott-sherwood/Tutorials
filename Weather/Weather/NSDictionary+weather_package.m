//
//  NSDictionary+weather_package.m
//  WeatherTutorial
//
//  Created by Scott on 19/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "NSDictionary+weather_package.h"

@implementation NSDictionary (weather_package)


-(NSDictionary *)currentCondition{
    NSDictionary *dict = [self objectForKey:@"data"];
    NSArray *ar = [dict objectForKey:@"current_condition"];
    return [ar objectAtIndex:0];
}

-(NSDictionary *)request{
    NSDictionary *dict = [self objectForKey:@"data"];
    NSArray *ar = [dict objectForKey:@"request"];
    return [ar objectAtIndex:0];
}

-(NSArray *)commingWeather{
    NSDictionary *dict = [self objectForKey:@"data"];
    return [dict objectForKey:@"weather"];
}



@end
