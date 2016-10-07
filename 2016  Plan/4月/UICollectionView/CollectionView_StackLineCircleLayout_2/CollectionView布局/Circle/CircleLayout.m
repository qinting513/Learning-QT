//
//  CircleLayout.m
//  CollectionView布局
//
//  Created by Qinting on 16/7/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "CircleLayout.h"

@implementation CircleLayout

/** 决定cell怎么排布 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
 
    NSMutableArray * arr = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for(int i =  0; i< count;i++)
    {
//创建cell对应的indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        创建i位置的cell的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
    //添加布局属性
        [arr addObject:attrs];
    }
    return  arr;
}

/** 返回indexPath位置的cell的布局属性 : 每一个cell的位置*/
-(UICollectionViewLayoutAttributes* )layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat radius = 80;
    
//    圆心
    CGFloat  centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat  centerY = self.collectionView.frame.size.height * 0.5;
    
    //获取布局属性
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(60, 60);
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    if (count == 1) {
        //如果只有一个了，则显示在中心点
        attrs.center = CGPointMake(centerX, centerY);
    }else{   //数量超过1个的
        //计算每一个item的所在位置的角度   2派 ／count *indexPath.item
        CGFloat angle = 2*M_PI / count *indexPath.item;
        CGFloat attrsCenterX = centerX - radius * cos(angle);
        CGFloat attrsCenterY = centerY - radius * sin(angle);
        
        attrs.center = CGPointMake(attrsCenterX, attrsCenterY);
    }

    // 用来控制cell的层叠顺序，zIndex越大，cell越在上面
    //        attrs.zIndex = i;
    
    return attrs;
}

@end
