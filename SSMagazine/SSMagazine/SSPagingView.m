//
//  FIPagingViewController.m
//  SSMagazine
//
//  Created by Scott Sherwood on 26/05/2012.
//  Copyright (c) 2012 Scott Sherwood.
//

#import "SSPagingView.h"
#import "SSPage.h"
#import "ImagePage.h"

//should really calculate this so we always have enough pages to ensure the entire screen can be displayed
#define NUMBER_OF_PAGES_IN_RECYCLE_POOL 6 

@interface SSPagingView ()

@property (strong, nonatomic) UIView *leftPadding;
@property (strong, nonatomic) UIView *rightPadding;

@property CGFloat lastOffset;
@property (strong, nonatomic)  NSMutableSet *recycledPages;
@property (strong, nonatomic)  NSMutableArray *visiblePages;

- (void)reloadData;
- (CGRect)frameForPageAtIndex:(NSInteger)index;
- (BOOL)isDisplayingPageForIndex:(NSUInteger)index;

@end

@implementation SSPagingView

@synthesize scrollView;
@synthesize recycledPages, visiblePages;
@synthesize dataSource, delegate;
@synthesize lastOffset;
@synthesize leftPadding,rightPadding;

-(void)awakeFromNib{
    [super awakeFromNib];

    self.recycledPages = [NSMutableSet set];
    self.visiblePages = [NSMutableArray array];    
}

-(void)layoutSubviews{
    [super layoutSubviews];

    [self.scrollView removeFromSuperview];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds] ;
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    [self reloadData]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(SSPage *)dequeueRecycledPage{
    SSPage *vc = [self.recycledPages anyObject];
    if(vc)
        [self.recycledPages removeObject:vc];
    
    return vc;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    if([self.delegate respondsToSelector:@selector(pagingViewControllerPageChanged:)])
        [self.delegate pagingViewPageChanged:self];
    
    [self reloadData];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)_scrollView{
    if([self.delegate respondsToSelector:@selector(pagingView:didSnapToPageAtIndex:)])
        [self.delegate pagingView:self didSnapToPageAtIndex:[self centeredIndex]];
}

- (CGRect)frameForPageAtIndex:(NSInteger)index {
    
    CGFloat paddingWidth = (self.scrollView.bounds.size.width/2)-([self.delegate widthOfPagingView:self]/2);
    
    return CGRectMake((index * [self.delegate widthOfPagingView:self]) + paddingWidth, 0, [self.delegate widthOfPagingView:self], CGRectGetHeight(self.scrollView.bounds));
}

-(int)centeredIndex{
    return (self.scrollView.contentOffset.x + ([self.delegate widthOfPagingView:self]/2))/[self.delegate widthOfPagingView:self];
}

-(void)setCenteredIndex:(int)index{
    
    CGFloat xPos = index*[self.delegate widthOfPagingView:self];
    CGFloat offset = 0;//(self.scrollView.frame.size.width/2)-([self.delegate pagingViewPageWidth:self]/2);
    
    [self.scrollView setContentOffset:CGPointMake(xPos-offset, 0.0f) animated:YES];
}

- (void)snapToItemScrollViewToPosition:(UIScrollView *)_scrollView {
	
    int selection = [self centeredIndex];
    [self setCenteredIndex:selection];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)_scrollView{
    [self snapToItemScrollViewToPosition:_scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate)
        [self snapToItemScrollViewToPosition:_scrollView];
}

#pragma mark - Helpers


-(void)reloadData{
    CGFloat contentWidth = [self.delegate widthOfPagingView:self] * [self.dataSource numberOfPagesInPagingView:self];
    CGFloat paddingWidth = (self.scrollView.bounds.size.width/2) - ([self.delegate widthOfPagingView:self]/2);
    
    self.leftPadding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingWidth, self.scrollView.bounds.size.height)];
    self.rightPadding = [[UIView alloc] initWithFrame:CGRectMake(contentWidth+paddingWidth, 0, paddingWidth, self.scrollView.bounds.size.height)];
    [self.leftPadding setBackgroundColor:[UIColor clearColor]];
    [self.rightPadding setBackgroundColor:[UIColor clearColor]];
    
    self.scrollView.contentSize = CGSizeMake(contentWidth+(2*paddingWidth), self.scrollView.bounds.size.height);
    
    CGRect visibleBounds = self.scrollView.bounds;
    int firstNeededPageIndex = floorf((CGRectGetMinX(visibleBounds)-paddingWidth) / [self.delegate widthOfPagingView:self]);
    int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-paddingWidth) / [self.delegate widthOfPagingView:self]);
    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex  = MIN(lastNeededPageIndex, [self.dataSource numberOfPagesInPagingView:self]-1);
    
    // Recycle unneeded controllers
    for (SSPage *page in visiblePages) {
        
        if (page.index < firstNeededPageIndex || page.index > lastNeededPageIndex) {
            if([recycledPages count] < NUMBER_OF_PAGES_IN_RECYCLE_POOL )
                [recycledPages addObject:page];
            
            [page removeFromSuperview];
        }
    }
    
    [self.visiblePages removeObjectsInArray:[self.recycledPages allObjects]];
    
    [self.scrollView addSubview:self.leftPadding];
    [self.scrollView addSubview:self.rightPadding];
    
    // Add missing pages
    for (int i = firstNeededPageIndex; i <= lastNeededPageIndex; i++) {
        if (![self isDisplayingPageForIndex:i])
        {
            SSPage *page = (SSPage *)[self.dataSource pageAtIndex:i inPagingView:self];
            page.frame = [self frameForPageAtIndex:i];  
            page.index = i;
            
            [self.scrollView addSubview:page];
            [self.visiblePages addObject:page];
        }
    }
    
}


-(BOOL)isDisplayingPageForIndex:(NSUInteger)index
{
    BOOL foundPage = NO;
    for (SSPage *page in visiblePages) {
        if (page.index == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}


@end
