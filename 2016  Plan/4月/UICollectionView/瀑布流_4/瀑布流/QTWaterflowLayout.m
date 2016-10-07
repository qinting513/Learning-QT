//
//  QTWaterflowLayout.m
//  01-瀑布流
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTWaterflowLayout.h"

/** 默认的列数 */
static const NSInteger QTDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat QTDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat QTDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets QTDefaultEdgeInsets = {10, 10, 10, 10};

@interface QTWaterflowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

/** get方法，如果没有写代理方法 则用默认的设置 */
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;
@end

@implementation QTWaterflowLayout

#pragma mark - 常见数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return QTDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return QTDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return QTDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return QTDefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

#pragma  mark - Layout 要实现的几个方法
/**
 * 初始化操作，每次刷新布局 都来调用一次
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }

    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建item所在的位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性 这个属性通过下面的 layoutAttributesForItemAtIndexPath 方法获取到，
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 决定cell的排布，返回一个数组，数组元素都是UICollectionViewLayoutAttributes，即布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性(frame)，多次被调用
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //  每一个item的宽度  w= (总宽度 - 左间距  - 右间距  -  (总列数 - 1)＊列间距  ) ／ 总列数；
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    //高度 通过代理方法获取到 这是必须实现的代理方法
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // 找出高度最短的那一列 destinationColunme
    NSInteger destColumn = 0;
    //设置一个中间变量 保存最小值  其实这个数组self.columnHeights里就3个数值
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    //  x = 左间距 +  列数 * (宽度＋固定间距)
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    // 高度最矮的那一行
    CGFloat y = minColumnHeight;
    //如果不是第0行 则高度相加
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }
    return attrs;
}


/** 设置contentSize，就像UIScrollView那样，设置内容尺寸，要不然就滚动不了，看不了更多内容 */
- (CGSize)collectionViewContentSize
{
//    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
//    for (NSInteger i = 1; i < self.columnCount; i++) {
//        // 取得第i列的高度
//        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
//        
//        if (maxColumnHeight < columnHeight) {
//            maxColumnHeight = columnHeight;
//        }
//    }
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end
