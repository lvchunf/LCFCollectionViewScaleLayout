//
//  ViewController.m
//  ScalePhoto
//
//  Created by lvhe on 2019/2/11.
//  Copyright © 2019 lvhe. All rights reserved.
//

#import "ViewController.h"
#import "LCFCollectionViewScaleLayout.h"
#import "LCFPhotoCell.h"

static NSString *const LCFPhotoCellId = @"LCFPhotoCell";

@interface ViewController ()<UICollectionViewDataSource>

@property(nonatomic, strong) NSMutableArray *photos;
@end

@implementation ViewController

- (NSMutableArray *)photos {
    if (!_photos) {
        _photos = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_photos addObject:[NSString stringWithFormat:@"%d", i + 1]];
        }
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LCFCollectionViewScaleLayout *layout = [[LCFCollectionViewScaleLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 150);
    
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 200;
    CGFloat collectionY = ([UIScreen mainScreen].bounds.size.height - collectionH) * 0.5;
    CGRect frame = CGRectMake(0, collectionY, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LCFPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:LCFPhotoCellId];
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCFPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LCFPhotoCellId forIndexPath:indexPath];
    NSString *photoName = self.photos[indexPath.item];
    UIImage *image = [UIImage imageNamed:photoName];
    cell.photoView.image = image;
    return cell;
}


@end
