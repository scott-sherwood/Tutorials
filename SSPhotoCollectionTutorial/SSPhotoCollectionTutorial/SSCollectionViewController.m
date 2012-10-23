//
//  SSCollectionViewController.m
//  SSCollectionViewTutorial
//
//  Created by Scott on 24/09/2012.
//  Copyright (c) 2012 ScottSherwood. All rights reserved.
//

#import "SSCollectionViewController.h"
#import "SSCollectionViewCell.h"

@interface SSCollectionViewController ()

@end

@implementation SSCollectionViewController

@synthesize delegate;

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

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    //PhotoDetailSegue
//    
//    if([segue.identifier isEqualToString:@"PhotoDetailSegue"]){
//        SSCollectionViewCell *cell = (SSCollectionViewCell *)sender;
//        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
//        
//        int imageNumber = indexPath.row % 10;
//        
//        SSImageDetailViewController *idvc = (SSImageDetailViewController *)[segue destinationViewController];
//        idvc.img = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg",imageNumber]];
//    }
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"Cell";
    SSCollectionViewCell *cell = (SSCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    int imageNumber = indexPath.row % 10;
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"imageicon%d.jpg",imageNumber]];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.delegate respondsToSelector:@selector(collectionViewController:didSelectIndexPath:)])
        [self.delegate collectionViewController:self didSelectIndexPath:indexPath];
}

@end
