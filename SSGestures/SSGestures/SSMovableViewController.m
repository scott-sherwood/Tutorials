//
//  SSMovableViewController.m
//  SSGestures
//
//  Created by Scott Sherwood on 19/10/2011.
//  Copyright (c) 2011 Scott Sherwood. All rights reserved.
//

#import "SSMovableViewController.h"

@implementation SSMovableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Gesture Actions

- (void)rotateGestureAction:(UIRotationGestureRecognizer *)rotate {
    if (rotate.state == UIGestureRecognizerStateBegan) {
        prevRotation = 0.0;
    } 
	
    float thisRotate = rotate.rotation - prevRotation;
    prevRotation = rotate.rotation;
    self.view.transform = CGAffineTransformRotate(self.view.transform, thisRotate);
}

- (void)pinchGestureAction:(UIPinchGestureRecognizer *)pinch {		
	if (pinch.state == UIGestureRecognizerStateBegan)
		prevPinchScale = 1.0;
    
    float thisScale = 1 + (pinch.scale-prevPinchScale);
    prevPinchScale = pinch.scale;
    self.view.transform = CGAffineTransformScale(self.view.transform, thisScale, thisScale);
}

-(void)panGestureAction:(UIPanGestureRecognizer *)pan {
	
    if (pan.state == UIGestureRecognizerStateBegan){
        prevPanPoint = [pan locationInView:self.view.superview];
    }
	
    CGPoint curr = [pan locationInView:self.view.superview];
    
	float diffx = curr.x - prevPanPoint.x;
	float diffy = curr.y - prevPanPoint.y;
	
	CGPoint centre = self.view.center;
	centre.x += diffx;
	centre.y += diffy;
	self.view.center = centre;
    
    prevPanPoint = curr;
}

-(void)tappedGestureAction:(UITapGestureRecognizer *)tap{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"View Tapped" message:@"Tapped" delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:@"Done", nil];
    [av show];
}


#pragma mark - UIGestureRecogniserDelegate


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        [gestureRecognizer addTarget:self action:@selector(panGestureAction:)];
    } else if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
		[gestureRecognizer addTarget:self action:@selector(pinchGestureAction:)];
	} else if ([gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
		[gestureRecognizer addTarget:self action:@selector(rotateGestureAction:)];
	}
    else if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]){
        [gestureRecognizer addTarget:self action:@selector(tappedGestureAction:)];
    }
	return YES;
}

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;



#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
