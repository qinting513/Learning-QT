//
//  QTWaterflowLayout.h
//  01-瀑布流
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QTWaterflowLayout;

@protocol QTWaterflowLayoutDelegate <NSObject>

@required
/**
 *  返回每个item的高度，这是必须实现的方法
 *
 *  @param waterflowLayout 本类
 *  @param index           索引，表示那一个item
 *  @param itemWidth       item的宽度
 *
 *  @return item的高度
 */
- (CGFloat)waterflowLayout:(QTWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
/** 返回总列数 */
- (CGFloat)columnCountInWaterflowLayout:(QTWaterflowLayout *)waterflowLayout;
/** 每一列之间的间隙 */
- (CGFloat)columnMarginInWaterflowLayout:(QTWaterflowLayout *)waterflowLayout;
/** 每一行之间的间隙 */
- (CGFloat)rowMarginInWaterflowLayout:(QTWaterflowLayout *)waterflowLayout;
/** 每一个item的edge */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(QTWaterflowLayout *)waterflowLayout;
@end

@interface QTWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<QTWaterflowLayoutDelegate> delegate;
@end
