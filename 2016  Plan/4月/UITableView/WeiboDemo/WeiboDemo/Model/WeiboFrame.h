//
//  WeiboFrame.h
//  Weibo
//
               

//  Created by Qinting on 16/7/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Weibo.h"

#define kNameFont   [UIFont systemFontOfSize:16]
#define kTimeFont [UIFont systemFontOfSize:12]
#define kContentFont [UIFont systemFontOfSize:14]

#define  kScreenW  [UIScreen mainScreen].bounds.size.width
#define  kScreenH  [UIScreen mainScreen].bounds.size.height

@interface WeiboFrame : NSObject
@property (nonatomic,strong) Weibo  *weibo;

@property (nonatomic,assign,readonly ) CGRect  iconF;
@property (nonatomic,assign,readonly ) CGRect  nameF;
@property (nonatomic,assign,readonly ) CGRect  timeF;
@property (nonatomic,assign,readonly ) CGRect  sourceF;
@property (nonatomic,assign,readonly ) CGRect  contentF;
@property (nonatomic,assign,readonly ) CGRect  imageF;

@property (nonatomic,assign,readonly ) CGFloat cellHeight;

@end
