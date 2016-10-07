//
//  News.h
//  Demo03_自定义单元格
//
//  Created by xiaoz on 15/9/15.
//  Copyright (c) 2015年 xiaoz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

//新闻标题
@property(nonatomic,strong)NSString *title;
//新闻图片
@property(nonatomic,strong)NSString *newsImage;
//新闻评论数
@property(nonatomic,assign)NSInteger commentCount;

+(NSMutableArray *)demoData;

@end








