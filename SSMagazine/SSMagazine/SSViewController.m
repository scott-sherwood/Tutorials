//
//  SSViewController.m
//  SSMagazine
//
//  Created by Scott Sherwood on 26/05/2012.
//  Copyright (c) 2012 Scott Sherwood.
//

#import "SSViewController.h"
#import "ImagePage.h"
#import "SSPage.h"

@interface SSViewController ()

@property (strong, nonatomic) NSArray *td;

@property (weak, nonatomic) IBOutlet SSPagingView *pageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) UIImageView *detailedView;
@property BOOL showDetailedViewAfterSnapToGrid;



@end

@implementation SSViewController

@synthesize pageView, textLabel, detailedView, showDetailedViewAfterSnapToGrid, td;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.showDetailedViewAfterSnapToGrid = NO;
    self.td = [NSArray arrayWithObjects:@"iOS Developer",@"Scott Sherwood",@"iPad", nil];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.textLabel.text = [self.td objectAtIndex:[self.pageView centeredIndex]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(IBAction)test:(id)sender{
    [self.pageView setCenteredIndex:5];
}

-(IBAction)detailViewDoubleTapped:(id)sender{
    [self.pageView setUserInteractionEnabled:YES];
    [UIView animateWithDuration:0.5 animations:^(void){
        self.detailedView.frame = CGRectMake(self.pageView.center.x - ([self widthOfPagingView:self.pageView]/2),
                                             self.pageView.center.y - (self.pageView.bounds.size.height/2), 
                                             [self widthOfPagingView:self.pageView], 
                                             self.pageView.bounds.size.height);
    }completion:^(BOOL finished){
        [self.detailedView removeFromSuperview];
        self.detailedView = nil;
    }];

}

-(IBAction)pageDoubleTapped:(UITapGestureRecognizer *)doubleTap{
    [self.pageView setUserInteractionEnabled:NO];
    ImagePage *page = (ImagePage *)doubleTap.view;
    
    
    if(page.index != pageView.centeredIndex){
        [self.pageView setCenteredIndex:page.index];
        self.showDetailedViewAfterSnapToGrid = YES;
        return;
    }
    
    [self showDetailedViewForPageAtIndex:page.index];

}

-(void)showDetailedViewForPageAtIndex:(NSInteger)index{
    
    self.detailedView = [[UIImageView alloc]initWithImage:
                         [UIImage imageNamed:[NSString stringWithFormat:@"article%d.jpg",index+1]]];
    [self.detailedView setUserInteractionEnabled:YES];
    [self.detailedView setBackgroundColor:[UIColor orangeColor]];
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailViewDoubleTapped:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.detailedView addGestureRecognizer:doubleTap];
    
    
    self.detailedView.frame = CGRectMake(self.pageView.center.x - ([self widthOfPagingView:self.pageView]/2),
                                         self.pageView.center.y - (self.pageView.bounds.size.height/2), 
                                         [self widthOfPagingView:self.pageView], 
                                         self.pageView.bounds.size.height);
    
    [self.view addSubview:self.detailedView];
    
    
    [UIView animateWithDuration:0.5 animations:^(void){
        self.detailedView.frame = CGRectMake(0,0, 1024, 748);
    }completion:^(BOOL finished){
        
    }];

}


#pragma mark - FIPagingViewDelegate


-(void)pagingViewPageChanged:(SSPagingView *)fipvc{
    // pageControl.currentPage = [fipvc currentPageIndex];
}

#pragma mark - FIPageViewDataSource


- (CGFloat)widthOfPagingView:(SSPagingView *)fipvc{
    return 324;
}

- (NSInteger)numberOfPagesInPagingView:(SSPagingView *)fipvc{
    return 3;
}

- (SSPage *)pageAtIndex:(NSInteger)aIndex inPagingView:(SSPagingView *)fipvc{
    
    ImagePage *page = (ImagePage *)[fipvc dequeueRecycledPage];
    
    if (page == nil){
        page = [[ImagePage alloc] initWithFrame:self.pageView.frame];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageDoubleTapped:)];
        [doubleTap setNumberOfTapsRequired:2];
        [page addGestureRecognizer:doubleTap];
    }
    
    page.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"article%d_thumb.png",aIndex+1]];
    
    //page.labelView.text = [NSString stringWithFormat:@"View %d",aIndex];
    
    return page;
}

- (void)pagingView:(SSPagingView *)fipvc didSnapToPageAtIndex:(NSInteger)index{
    if(self.showDetailedViewAfterSnapToGrid)
        [self showDetailedViewForPageAtIndex:index];
    
    self.textLabel.text = [self.td objectAtIndex:index];
    self.showDetailedViewAfterSnapToGrid = NO;
}


@end
