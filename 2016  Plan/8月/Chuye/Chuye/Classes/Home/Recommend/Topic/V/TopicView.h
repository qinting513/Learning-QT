//
//  TopicView.h
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBtnBlock)(NSInteger index);
typedef void(^ClickMoreBtnBlock)();

@interface TopicView : UIView
+(id)loadXib;

@property (nonatomic,strong) NSArray  *topics;
@property (nonatomic,strong) ClickBtnBlock  clickBtnBlock;
@property (nonatomic,strong) ClickMoreBtnBlock clickMoreBtnBlock;
@end
