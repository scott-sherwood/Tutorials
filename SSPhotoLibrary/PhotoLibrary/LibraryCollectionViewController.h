//
//  LibraryCollectionViewController.h
//  PhotoLibrary
//
//  Created by Scott on 26/10/2012.
//  Copyright (c) 2012 scott-sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LibraryCollectionViewContorllerDelegate;

@interface LibraryCollectionViewController : UICollectionViewController

@property(weak) id<LibraryCollectionViewContorllerDelegate> delegate;

@end


@protocol LibraryCollectionViewContorllerDelegate <NSObject>

-(void)shouldShowImageWithName:(NSString *)name;

@end
