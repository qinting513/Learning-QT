//
//  LineLayout.m
//  CollectionView布局
//
//  Created by Qinting on 16/7/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "LineLayout.h"

/** 设置滚动方向 （只有流水布局才有这个属性）*/
//self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

@implementation LineLayout

/** 准备操作：一般在这里设置一些初始化参数 */
-(void)prepareLayout
{
    //必须调用父类（父类也准备一些操作)
    [super prepareLayout];
    
    /** 设置滚动方向 （只有流水布局才有这个属性）*/
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置cell的大小
    CGFloat itemWH = self.collectionView.frame.size.height * 0.8;
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
    //设置内边距     collectionView宽度减去一个item的宽度后 再除以2
    CGFloat inset = (self.collectionView.frame.size.width - itemWH) *0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

/** 当CollectionView的bounds发生改变时，是否需要刷新布局 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/** 必须写该方法，决定cell如何排布 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    /** 调用父类方法 拿到默认的布局属性 */
 NSArray *arrayRect =  [super layoutAttributesForElementsInRect:rect];
    
    //获得collectionView的中心点的x值
    CGFloat centerX = self.collectionView.frame.size.width*0.5 +self.collectionView.contentOffset.x;
    
    //在默认布局基础上 修改rect，进行微调
    for (UICollectionViewLayoutAttributes *attrs in arrayRect) {
//        计算出cell的中心点 然后跟collectionView的中心点进行比较,得出与中心点的距离值
        CGFloat delta = ABS(centerX-attrs.center.x);
        //利用差距 算出缩放比例( 反比)
        CGFloat scale = 1 - delta / ( self.collectionView.frame.size.width + self.itemSize.width);
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return [arrayRect copy];
}

/**
 *这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 * proposedContentOffset
 ＊滚动后即将停止的时候 则调用这个方法
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算最终的可见范围
    CGRect rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    
    //取得super已经算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算collectionView 最中间的x
    CGFloat centerX = self.collectionView.frame.size.width * 0.5 + proposedContentOffset.x;
    
    //计算最小的间距值
    CGFloat minDetal = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDetal) > ABS(centerX - attrs.center.x) ) {
            minDetal = attrs.center.x - centerX;
        }
    }
    //在原有offset的基础上进行微调
    return CGPointMake(proposedContentOffset.x + minDetal, proposedContentOffset.y);
    
}


@end
