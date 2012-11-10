//
//  LibraryCollectionViewController.m
//  PhotoLibrary
//
//  Created by Scott on 26/10/2012.
//  Copyright (c) 2012 scott-sherwood. All rights reserved.
//

#import "LibraryCollectionViewController.h"
#import "LibraryItemCollectionCell.h"

@interface LibraryCollectionViewController ()


@end

@implementation LibraryCollectionViewController


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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LibraryItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"imageicon%d.jpg",indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *filename = [NSString stringWithFormat:@"image%d.jpg",indexPath.row];
    
    if([self.delegate respondsToSelector:@selector(shouldShowImageWithName:)])
        [self.delegate shouldShowImageWithName:filename];
    
}

@end
