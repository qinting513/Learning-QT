//
//  TitleView.m
//  SwitchButton
//
//  Created by Qinting on 16/8/12.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TitleView.h"
#import "Masonry.h"

@interface TitleView()
@property (nonatomic,strong) UIButton  *preButton;
@property (nonatomic,strong) UIView  *bottomView;

@end

@implementation TitleView

-(void)awakeFromNib{
//    NSLog(@"%s",__func__);
}

-(id)initWithFrame:(CGRect)frame allButtonTitles:(NSArray *)titles  {
    self = [super initWithFrame:frame];
    if (self ) {
//        self.backgroundColor = [UIColor lightGrayColor];
        /** 创建button */
//        NSArray *titles = @[@"兴趣推荐",@"今日最新",@"附近最热",@"为你精选"];
        UIButton *lastBtn = nil;
        for(int i = 0; i< titles.count; i++){
            UIButton *btn = [UIButton buttonWithType:0];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [self addSubview:btn];
            CGFloat  btnWidth = frame.size.width*1.0/titles.count;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//                //                make.top.mas_equalTo(0);
//                //                make.bottom.mas_equalTo(0);
//                //              合并为一句话
                make.top.bottom.mas_equalTo(0);
                if (i == 0) {
                    make.left.mas_equalTo(self);
                }else{
                    //                    除第一个 每一个的左边等于前一个右边的0距离
                    make.left.mas_equalTo(lastBtn.mas_right).mas_equalTo(0);
                    if(i == titles.count-1){
                        make.right.mas_equalTo(0);
                    }
                }
                make.width.mas_equalTo(btnWidth);
            }];
            lastBtn = btn;
            
                if ( i==1 ) {
                    btn.selected = YES;
                    self.preButton = btn;
                    /** 创建底部的View */
                    UIView *bottomView  = [[UIView alloc]init];
                    bottomView.backgroundColor = [UIColor orangeColor];
                    bottomView.frame = CGRectMake(btnWidth * i, self.frame.size.height - 2, frame.size.width*1.0/titles.count, 2);
//                            NSLog(@"%@",bottomView);
                    [self addSubview:bottomView];
                    self.bottomView = bottomView;
                }
         }
    }
    return self;
}

-(void)btnClick:(UIButton*)btn{
        if(btn == self.preButton) return;
        btn.selected = YES;
        self.preButton.selected = NO;
        self.preButton = btn;
    
        [UIView animateWithDuration:0.3 animations:^{
            self.bottomView.frame = CGRectMake(btn.frame.origin.x, self.frame.size.height - 2, btn.bounds.size.width, 2);
        }];
    [self.delegate titleView:self buttonClickAtIndex:btn.tag];
    
}

-(void)setAllButtonTitles:(NSArray *)allButtonTitles{
    _allButtonTitles = allButtonTitles;
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIButton class]]){
            UIButton *b = (UIButton*)view;
//            NSLog(@"%@--%@",b,allButtonTitles[b.tag]);
            [b setTitle:allButtonTitles[b.tag] forState:UIControlStateNormal];
        }
    }
}

-(void)setTitleFont:(UIFont *)titleFont{
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIButton class]]){
            UIButton *b = (UIButton*)view;
            b.titleLabel.font = titleFont;
        }
    }
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIButton class]]){
            UIButton *b = (UIButton*)view;
            [b setTitleColor:titleColor forState:UIControlStateNormal];
        }
    }
}

-(void)setBottomViewColor:(UIColor *)bottomViewColor{
    _bottomViewColor = bottomViewColor;
    for (UIView *view in self.subviews) {
        if(![view isKindOfClass:[UIButton class]]){
            view.backgroundColor = bottomViewColor;
        }
    }
}

//-(void)settitleImageNames:(NSArray *)titleImageNames  {
//    _titleImageNames = titleImageNames;
//    for (UIView *view in self.subviews) {
//        if([view isKindOfClass:[UIButton class]]){
//            UIButton *b = (UIButton*)view;
//            [b setTitle:@"" forState:UIControlStateNormal];
//            [b setImage:[UIImage imageNamed:titleImageNames[b.tag]] forState:UIControlStateNormal];
//        }
//    }
//}

@end