//
//  StackLayout.m
//  CollectionView布局
//
//  Created by Qinting on 16/7/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "StackLayout.h"

@implementation StackLayout


/** 决定cell的布局  每一个cell对应一个UICollectionViewLayoutAttributes */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for(int i = 0; i<count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attrs];
    }
    return  array;
}

/** 对布局属性进行设置 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes
                                                    layoutAttributesForCellWithIndexPath:indexPath];
    /** 设置中心点为collectionView的中心点 ，并且同一个中心点*/
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5,
                                                   self.collectionView.frame.size.height * 0.5);
    attrs.size = CGSizeMake(150, 150);
    //设置层叠，越后面放的，越在上面,注意负号
    attrs.zIndex = - indexPath.item;
    //第0个
    if(indexPath.item == 0) return attrs;
    //第［5，N］个
    if (indexPath.item > 4) {
        attrs.hidden = YES;
        return attrs;
    }
    
    /** 设置旋转角度 ［0，4］*/
    NSArray * angles = @[@0,@(-0.2),@0.2,@(-0.5),@0.5];
    CGFloat angle = [angles[indexPath.item] doubleValue];
    attrs.transform = CGAffineTransformMakeRotation(angle);
    
    return attrs;
}

@end
