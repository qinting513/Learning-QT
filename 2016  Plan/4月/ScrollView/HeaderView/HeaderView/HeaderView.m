//
//  HeaderView.m
//  HeaderView
//
//  Created by Qinting on 16/4/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "HeaderView.h"

#define kWidth 80


@implementation HeaderView

/** 在初始化方法里创建 */
-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;{
    self = [super initWithFrame:frame];
    if (self) {
    
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        /** 1.设置frame */
        scrollView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
//        scrollView.frame = frame;
        
        /** 2.设置contentSize  height＝＝0 说明禁止垂直方向滚动*/
        scrollView.contentSize = CGSizeMake( imageArray.count * kWidth, 0);

        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0,-64, imageArray.count * kWidth, frame.size.height)];
//        v.backgroundColor = [UIColor greenColor];
        for(int i = 0; i< imageArray.count; i++){
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(kWidth * i, 0, kWidth, kWidth);
            [btn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            /** 3.添加子视图 */
            [v addSubview:btn];
        }
        [scrollView addSubview:v];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        /** 1.设置frame */
      scrollView.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        /** 2.设置contentSize  height＝＝0 说明禁止垂直方向滚动*/
        scrollView.contentSize = CGSizeMake( textArray.count * kWidth, 0);
//        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        [self addSubview:scrollView];
#warning question2: 为什么是－64?
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0,-64, textArray.count * kWidth, frame.size.height)];
      
        for(int i = 0; i< textArray.count; i++){
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(kWidth * i, 0, kWidth, frame.size.height);
            [btn setTitle:textArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            /** 2.添加子视图 */
            [v addSubview:btn];
#warning  question3: why直接添加不可以,需要添加到一个UIView上面先？
//            [scrollView addSubview:btn];
        }
        [scrollView addSubview:v];
    }
    return self;
}

-(void)clickBtn:(UIButton*)btn{
    NSLog(@"%@",btn.titleLabel.text);
    if ([self.delegate respondsToSelector:@selector(headerView:clickButtonAtIndex:)]) {
        [self.delegate headerView:self clickButtonAtIndex:btn.tag];
    }
}

@end
