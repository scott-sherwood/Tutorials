//
//  WeatherAnimationViewController.m
//  Weather
//
//  Created by Scott on 17/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "WeatherAnimationViewController.h"
#import "AFNetworking.h"

@interface WeatherAnimationViewController ()

@property(strong)NSTimer *generator;

@end

@implementation WeatherAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *desc = [self.weatherDictionary weatherDescription];
    
    if([self.weatherDictionary objectForKey:@"tempMinC"])
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@ \u00B0c - %@ \u00B0c",
                                      [self.weatherDictionary tempMinC],
                                      [self.weatherDictionary tempMaxC]];
    else
        self.temperatureLabel.text = [NSString stringWithFormat:@"%@ \u00B0",[self.weatherDictionary tempC]];
    
    
    self.title = desc;
    
    [self start:desc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions



-(IBAction)deleteBackgroundImage:(id)sender{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"WeatherHTTPClientImages/"];
	
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    
    NSString *desc = [self.weatherDictionary weatherDescription];
    [self start:desc];
}

-(IBAction)updateBackgroundImage:(id)sender{
    //Store this image on the same server as the weather canned files
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.scott-sherwood.com/wp-content/uploads/2013/01/scene.png"]];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request
                                                                              imageProcessingBlock:nil
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                                                               self.backgroundImageView.image = image;
                                                                                               [self saveImage:image withFilename:@"background.png"];
                                                                                           }
                                                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                                               NSLog(@"Error %@",error);
                                                                                           }];
    [operation start];
}




-(void)saveImage:(UIImage *)image withFilename:(NSString *)filename{
    
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"WeatherHTTPClientImages/"];
	
    
    BOOL isDir;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
        if(!isDir){
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            
            NSLog(@"%@",error);
        }
    }
    
    path = [path stringByAppendingPathComponent:filename];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSLog(@"Written: %d",[imageData writeToFile:path atomically:YES]);
}

-(UIImage *)imageWithFilename:(NSString *)filename{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"WeatherHTTPClientImages"];
	path = [path stringByAppendingPathComponent:filename];
    
    return [UIImage imageWithContentsOfFile:path];
}



#pragma mark - Animation
-(void)start:(NSString *)type{
    [self stop];
    
    if([[type lowercaseString] isEqualToString:@"clear"]){
        [self clear];
    }
    else if([[type lowercaseString] isEqualToString:@"cloudy"] ||
            [[type lowercaseString] isEqualToString:@"overcast"]){
        UIImageView *iv = [self cloudy];
        [self pulseImageView:iv];
    }
    else if([[type lowercaseString] isEqualToString:@"partly cloudy"]){
        UIImageView *iv = [self sunny:CGPointMake(100,50)];
        [self bounceImageView:iv];
        [self cloudy];
    }
    else if([[type lowercaseString] isEqualToString:@"sunny"]){
        UIImageView *iv = [self sunny:CGPointMake(160,90)];
        [self pulseImageView:iv];
    }
    else if([[type lowercaseString] isEqualToString:@"light rain shower"] ||
            [[type lowercaseString] isEqualToString:@"patchy rain nearby"] ||
            [[type lowercaseString] isEqualToString:@"patchy light drizzle"] ||
            [[type lowercaseString] isEqualToString:@"moderate or heavy rain in area with thunder"] ||
            [[type lowercaseString] isEqualToString:@"patchy light rain"]){
        
        [self weatherItem:@"rain" andLevel:1.0];
        [self raining];
    }
    else if([[type lowercaseString] isEqualToString:@"mist"]){
        [self cloudy];
        
        UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
        view.center = CGPointMake(160,125);
        [view setBackgroundColor:[UIColor whiteColor]];
        view.alpha = 0.5;
        [self.backgroundImageView addSubview:view];
        [self.backgroundImageView bringSubviewToFront:view];
    }
    else if([[type lowercaseString] isEqualToString:@"light snow"]||
            [[type lowercaseString] isEqualToString:@"patchy light snow"]){
        [self weatherItem:@"snow" andLevel:.5];
        [self andryCloud];
    }
    else if([[type lowercaseString] isEqualToString:@"moderate snow"] ||
            [[type lowercaseString] isEqualToString:@"moderate or heavy sleet"] ||
            [[type lowercaseString] isEqualToString:@"patchy moderate snow"]){
        [self weatherItem:@"snow" andLevel:2.0];
        [self andryCloud];
    }
    else if([[type lowercaseString] isEqualToString:@"heavy snow"]||
            [[type lowercaseString] isEqualToString:@"patchy heavy snow"]){
        [self weatherItem:@"snow" andLevel:3.5];
        [self andryCloud];
    }
    else{
        [self weatherItem:@"rain" andLevel:1.0];
        [self raining];
    }
    
    if([self imageWithFilename:@"background.png"]){
        self.backgroundImageView.image = [self imageWithFilename:@"background.png"];
    }
    else{
        self.backgroundImageView.image = [UIImage imageNamed:@"lightsky.png"];
        
    }
}

-(void)raining{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"angrycloud"]];
    imageView.center = CGPointMake(160,125);
    [self.backgroundImageView addSubview:imageView];
    [self.backgroundImageView bringSubviewToFront:imageView];
    
}

-(UIImageView *)sunny:(CGPoint)point{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun"]];
    imageView.center = point;
    [self.backgroundImageView addSubview:imageView];
    [self.backgroundImageView bringSubviewToFront:imageView];
    
    return imageView;
    
}

-(void)bounceImageView:(UIImageView *)iv{
    
    CGPoint point = iv.center;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         iv.center = CGPointMake(point.x,point.y+75);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseIn
                                          animations:^{
                                              iv.center = CGPointMake(iv.center.x,iv.center.y-75);
                                          }
                                          completion:^(BOOL finished) {
                                              if(finished)
                                                  [self bounceImageView:iv];
                                          }];
                     }];
}


-(void)pulseImageView:(UIImageView *)iv{
    
    
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseOut
                     animations:^{
                         iv.transform = CGAffineTransformScale(iv.transform, 2, 2);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseIn
                                          animations:^{
                                              iv.transform = CGAffineTransformScale(iv.transform, .5, .5);
                                          }
                                          completion:^(BOOL finished) {
                                              if(finished)
                                                  [self pulseImageView:iv];
                                          }];
                     }];
}

-(UIImageView *)cloudy{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud"]];
    imageView.center = CGPointMake(160,125);
    [self.backgroundImageView addSubview:imageView];
    [self.backgroundImageView bringSubviewToFront:imageView];
    return imageView;
}


-(void)weatherItem:(NSString *)name andLevel:(CGFloat)level{
    if(self.generator){
        [self.generator invalidate];
        self.generator = nil;
    }
    
    self.generator = [NSTimer scheduledTimerWithTimeInterval:(.1*(1/level)) target:self selector:@selector(addItem:) userInfo:name repeats:YES];
}

-(void)addItem:(NSTimer *)timer{
    
    NSString *image = timer.userInfo;
    
    int x = arc4random()%80;
    int y = arc4random()%100;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.center = CGPointMake(x+120,y+120);
    [self.backgroundImageView addSubview:imageView];
    [self.backgroundImageView sendSubviewToBack:imageView];
    [self tweenLeftImageView:imageView];
}


-(void)tweenLeftImageView:(UIImageView *)iv{
    
    CGPoint point = iv.center;
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         iv.center = CGPointMake(point.x-50,point.y+200);
                         iv.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [iv removeFromSuperview];
                     }];
}

-(void)andryCloud{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"angrycloud"]];
    imageView.center = CGPointMake(160,125);
    [self.backgroundImageView addSubview:imageView];
    [self.backgroundImageView bringSubviewToFront:imageView];
}


-(void)thunder{
    UIImageView *thunderBoltImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thunderbolt"]];
    thunderBoltImageView.center = CGPointMake(160,150);
    [self.backgroundImageView addSubview:thunderBoltImageView];
    [self.backgroundImageView bringSubviewToFront:thunderBoltImageView];
    
}


-(void)clear{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clear"]];
    imageView.center = CGPointMake(160,125);
    [self.backgroundImageView addSubview:imageView];
    [self.backgroundImageView bringSubviewToFront:imageView];
    
    [self rotateImageView:imageView];
}

-(void)rotateImageView:(UIImageView *)iv{
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         iv.transform = CGAffineTransformRotate(iv.transform, M_PI / 2);
                         
                     }
                     completion:^(BOOL finished) {
                         if(finished)
                             [self rotateImageView:iv];
                     }];
}



-(void)stop{
    [self.generator invalidate];
    self.generator = nil;
    
    for(UIView *view in self.backgroundImageView.subviews){
        [view removeFromSuperview];
    }
}

@end
