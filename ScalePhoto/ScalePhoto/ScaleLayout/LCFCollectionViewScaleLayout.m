//
//  LCFCollectionViewScaleLayout.m
//  ScalePhoto
//
//  Created by lvhe on 2019/2/11.
//  Copyright © 2019 lvhe. All rights reserved.
//

#import "LCFCollectionViewScaleLayout.h"

@implementation LCFCollectionViewScaleLayout

/** 初始化操作 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/** 布局属性数组 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes *attrs in attributesArr) {
        CGFloat distanceToCenter = ABS(attrs.center.x - centerX);
        CGFloat scale = 1 - distanceToCenter / self.collectionView.frame.size.width;
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attributesArr;
}

/** 修改最终偏移量 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //找出距中点最小的间距值
    CGFloat minDistanceToCenter = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in attributesArr) {
        if (ABS(minDistanceToCenter) > ABS(attrs.center.x - centerX)) {
            minDistanceToCenter = attrs.center.x - centerX;
        }
    }
    
    //保证在中心
    proposedContentOffset.x += minDistanceToCenter;
    return proposedContentOffset;
}

@end
