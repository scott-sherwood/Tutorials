//
//  SSCollectionViewController.m
//  CollectionViewTutorial
//
//  Created by Scott on 24/09/2012.
//  Copyright (c) 2012 ScottSherwood. All rights reserved.
//

#import "SSCollectionViewController.h"
#import "SSCollectionViewCell.h"
#import "SSDetailImageViewController.h"

@interface SSCollectionViewController ()

@end

@implementation SSCollectionViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"DetailImageSegue"]){
        SSCollectionViewCell *cell = (SSCollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        int i = indexPath.row%10;
        
        SSDetailImageViewController *divc = (SSDetailImageViewController *)[segue destinationViewController];
        divc.img =  [UIImage imageNamed:[NSString stringWithFormat:@"image%d@2x.jpg",i]];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    SSCollectionViewCell *cvc = (SSCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    int i = indexPath.row%10;
    
    cvc.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"imageicon%d@2x.jpg",i]];
    
    
    return cvc;
}



@end
