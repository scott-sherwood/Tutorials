//
//  SSAppDelegate.m
//  Clock
//
//  Created by Scott on 28/09/2013.
//  Copyright (c) 2013 ScottSherwood. All rights reserved.
//

#import "SSAppDelegate.h"
#import "GAITracker.h"
#import "GAI.h"
#import "GAIFields.h"

@implementation SSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
/********** Testing **********/
    //  [[GAI sharedInstance] setDryRun:YES];
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    /* send uncaught exceptions to Google Analytics. */
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
/********** Sampling Rate 20 seconds. **********/
    [GAI sharedInstance].dispatchInterval = 20;
    
  
    /* Initialize tracker */
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-26663270-2"];

    /********** Sampling Rate **********/
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [tracker set:kGAIAppVersion value:version];
    [tracker set:kGAISampleRate value:@"50.0"]; // sampling rate of 50%
    
    
    

/********** Using Multiple Trackers **********/
//    // t1 becomes the default tracker because it is the first tracker initialized.
//    id<GAITracker> t1 = [[GAI sharedInstance] trackerWithTrackingId:@"UA-XXXX-1"];
//    id<GAITracker> t2 = [[GAI sharedInstance] trackerWithTrackingId:@"UA-XXXX-2"];
//    
//    // Returns t1.
//    id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
//    
//    // Hit sent to UA-XXXX-1.
//    [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
//                           set:@"Home Screen" forKey:kGAIScreenName] build]];
//    
//    // Override the default tracker.
//    [[GAI sharedInstance] setDefaultTracker:t2];
//    // Returns t2.
//    defaultTracker = [[GAI sharedInstance] defaultTracker];
   
/********** Opting Out **********/
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Google Analytics" message:@"With your permission usage information will be collected to improve the application." delegate:self cancelButtonTitle:@"Opt Out" otherButtonTitles:@"Opt In", nil];
    [av show];
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [[GAI sharedInstance] setOptOut:YES];
            break;
        case 1:
            [[GAI sharedInstance] setOptOut:NO];
            break;
            
        default:
            break;
    }
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
