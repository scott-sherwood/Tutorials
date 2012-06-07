//
//  ImagePage.m
//  SSMagazine
//
//  Created by Scott Sherwood on 26/05/2012.
//  Copyright (c) 2012 Scott Sherwood.
//

#import "ImagePage.h"

@implementation ImagePage

@synthesize imageView, labelView;

-(id)init{
    self = [super init];
    if(self!=nil){
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
        [iv setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
        [iv setContentMode:UIViewContentModeScaleAspectFit];
        self.imageView = iv;
        
       // self.labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self addSubview:self.imageView];
        [self addSubview:self.labelView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
