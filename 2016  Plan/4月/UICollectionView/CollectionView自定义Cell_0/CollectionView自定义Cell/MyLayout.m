//
//  MyLayout.m
//  Demo5_集合视图_自定义Cell和布局
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout

-(instancetype)init {
    if (self = [super init]) {
        //初始化 布局相关的 设置
        //1.项的大小
        self.itemSize = CGSizeMake(80, 80);
        //2.最小行间隔
        self.minimumLineSpacing = 10;
        //3.最小项间隔
        self.minimumInteritemSpacing = 5;
        //4.设置4个边的间隔
        self.sectionInset = UIEdgeInsetsMake(50, 50, 50, 50);
        //5.设置 布局 为水平方向
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

@end






