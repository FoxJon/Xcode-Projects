//
//  JHFPhotosViewController.m
//  Photo Bombers
//
//  Created by Jonathan Fox on 7/20/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "JHFPhotosViewController.h"

@interface JHFPhotosViewController ()

@end

@implementation JHFPhotosViewController

- (instancetype)init{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Photo Bombers";
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 21;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

@end
