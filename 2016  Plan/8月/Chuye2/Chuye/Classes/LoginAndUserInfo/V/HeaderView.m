//
//  HeaderView.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()
@property (nonatomic,strong) UIView  *bottomView;
@property (nonatomic,strong) UIButton  *preBtn;
@end
@implementation HeaderView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.editProfileBtn.alpha = 0;
        /** 创建底部的View */
        UIView *bottomView  = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor redColor];
        CGFloat width = kScreenW / 4.0;
        bottomView.frame = CGRectMake(0, self.frame.size.height - 2, width, 2);
        [self addSubview:bottomView];
        self.bottomView = bottomView;
    }
    return self;
}

-(void)layoutSubviews{
    self.preBtn = self.worksBtn;
    self.headerPhotoImageView.layer.cornerRadius = self.headerPhotoImageView.frame.size.width * 0.5;
    self.headerPhotoImageView.layer.masksToBounds = YES;
}


- (IBAction)showTypeBtnsClick:(UIButton*)sender {
    if(sender == self.preBtn) return;
    sender.selected = YES;
    self.preBtn.selected = NO;
    self.preBtn = sender;
//    移动底部view
    [UIView animateWithDuration:0.3f animations:^{
        CGPoint center = sender.center;
        center.x = sender.center.x;
        center.y = self.bottomView.center.y;
        self.bottomView.center = center;
    }];
    self.showTypeBtnsClickAtIndex(sender.tag);
}


@end
