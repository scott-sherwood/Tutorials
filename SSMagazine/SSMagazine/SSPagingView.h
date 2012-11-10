//
//  FIPagingViewController.h
//  SSMagazine
//
//  Created by Scott Sherwood on 26/05/2012.
//  Copyright (c) 2012 Scott Sherwood. 
//

#import <UIKit/UIKit.h>
#import "SSPage.h"

@protocol SSPagingViewDataSource;
@protocol SSPagingViewDelegate;

@interface SSPagingView : UIView <UIScrollViewDelegate>

@property (weak ,nonatomic) IBOutlet id<SSPagingViewDelegate> delegate;
@property (weak ,nonatomic) IBOutlet id<SSPagingViewDataSource> dataSource;
@property (strong, nonatomic) UIScrollView *scrollView;
@property int centeredIndex;

- (void)reloadData;
- (SSPage *)dequeueRecycledPage;

@end


@protocol SSPagingViewDataSource <NSObject>

@required
    - (SSPage *)pageAtIndex:(NSInteger)index inPagingView:(SSPagingView *)fipvc;
    - (NSInteger)numberOfPagesInPagingView:(SSPagingView *)fipvc;

@end

@protocol SSPagingViewDelegate <NSObject>

@required
    - (CGFloat)widthOfPagingView:(SSPagingView *)fipvc;

@optional
    - (void)pagingViewPageChanged:(SSPagingView *)fipvc;
    - (void)pagingView:(SSPagingView *)fipvc didSnapToPageAtIndex:(NSInteger)index;

@end