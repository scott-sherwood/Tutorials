//
//  NSDictionary+weather.h
//  Weather
//
//  Created by Scott on 14/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (weather)



-(NSNumber *)cloudCover;
-(NSNumber *)humidity;
-(NSDate *)observationTime;
-(NSNumber *)precipMM;
-(NSNumber *)pressue;
-(NSNumber *)tempC;
-(NSNumber *)tempF;
-(NSNumber *)visibility;
-(NSNumber *)weatherCode;
-(NSString *)windDir16Point;
-(NSNumber *)windDirDegree;
-(NSNumber *)windSpeedKmph;
-(NSNumber *)windSpeedMiles;
-(NSString *)weatherDescription;
-(NSString *)weatherIconURL;
-(NSDate *)date;
-(NSNumber *)tempMaxC;
-(NSNumber *)tempMaxF;
-(NSNumber *)tempMinC;
-(NSNumber *)tempMinF;


@end
