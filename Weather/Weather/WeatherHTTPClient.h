//
//  WeatherHTTPClient.h
//  Weather
//
//  Created by Scott on 02/02/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "AFHTTPClient.h"

@protocol WeatherHttpClientDelegate;

@interface WeatherHTTPClient : AFHTTPClient

@property(weak) id<WeatherHttpClientDelegate> delegate;

+ (WeatherHTTPClient *)sharedWeatherHTTPClient;
- (id)initWithBaseURL:(NSURL *)url;
-(void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(int)number;

@end

@protocol WeatherHttpClientDelegate <NSObject>
-(void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(id)weather;
-(void)weatherHTTPClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error;
@end

