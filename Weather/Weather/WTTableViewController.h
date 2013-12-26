//
//  WTTableViewController.h
//  Weather
//
//  Created by Scott on 26/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherHTTPClient.h"

@interface WTTableViewController : UITableViewController <NSXMLParserDelegate,UIActionSheetDelegate,CLLocationManagerDelegate, WeatherHttpClientDelegate>


-(IBAction)clear:(id)sender;
-(IBAction)jsonTapped:(id)sender;
-(IBAction)plistTapped:(id)sender;
-(IBAction)xmlTapped:(id)sender;
-(IBAction)httpClientTapped:(id)sender;
-(IBAction)apiTapped:(id)sender;

@end
