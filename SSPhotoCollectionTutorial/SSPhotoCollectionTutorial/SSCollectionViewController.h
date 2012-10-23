//
//  SSCollectionViewController.h
//  SSCollectionViewTutorial
//
//  Created by Scott on 24/09/2012.
//  Copyright (c) 2012 ScottSherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSCollectionViewDelegate;

@interface SSCollectionViewController : UICollectionViewController

@property(weak) id<SSCollectionViewDelegate> delegate;

@end


@protocol SSCollectionViewDelegate <NSObject>

-(void)collectionViewController:(SSCollectionViewController *)cvc didSelectIndexPath:(NSIndexPath *)indexPath;

@end