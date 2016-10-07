//
//  Cell.m
//  Demo5_集合视图_自定义Cell和布局
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Cell.h"

@implementation Cell

//没有xib文件时， 系统创建Cell实例时， 调用initWithFrame的初始方法
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc]init];
        self.label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:30];
        self.label.textColor = [UIColor redColor];
        //将 Label 添加到 cell 的 contentView 上
        [self.contentView addSubview:self.label];
        
        
        self.bgImageView = [[UIImageView alloc]init];
        self.bgImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        //把 imageview 设置为 背景view
        self.backgroundView = self.bgImageView;
        
    }
    return self;
}



@end











