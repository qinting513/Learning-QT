//
//  FriendHeaderView.m
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendHeaderView.h"



@interface FriendHeaderView()

@property (nonatomic,strong) UIView  *bottomView;
@property (nonatomic,strong) UIButton  *preBtn;
@end
@implementation FriendHeaderView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        
        /** 创建底部的View */
        UIView *bottomView  = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor redColor];
        //平均之后再左右减去20；
        CGFloat width = kScreenW / 3.0 ;
        bottomView.frame = CGRectMake(20, self.frame.size.height - 2, width-40, 2);
        [self addSubview:bottomView];
        self.bottomView = bottomView;
    }
    return self;
}

-(void)layoutSubviews{
    self.preBtn = self.worksButton;
    self.headerImageView.layer.cornerRadius = self.headerImageView.frame.size.width * 0.5;
    self.headerImageView.layer.masksToBounds = YES;
}



- (IBAction)showTypeBtnsClick:(UIButton*)sender {
    if(sender == self.preBtn) return;
    sender.selected = YES;
    self.preBtn.selected = NO;
    self.preBtn = sender;
    //    移动底部view
    [UIView animateWithDuration:0.3f animations:^{
//        CGPoint center = sender.center;
//        center.x = sender.center.x + 20;
//        center.y = self.bottomView.center.y;
//        self.bottomView.center = center;
        //平均之后再左右减去20；
        CGFloat width = kScreenW / 3.0;
        self.bottomView.frame = CGRectMake(20+width * sender.tag, self.frame.size.height - 2, width-40, 2);
    }];
    self.friendShowTypeBtnsClickAtIndex(sender.tag);
}

-(void)setData:(AddFriendData *)data{
    _data = data;
    [self.worksButton setTitle:[NSString stringWithFormat:@"%ld 作品",data.Works.count] forState:UIControlStateNormal];
    [self.transmitButton setTitle:[NSString stringWithFormat:@"%d 转发", 0] forState:UIControlStateNormal];
    [self.joinButton setTitle:[NSString stringWithFormat:@"%d 收藏", 0] forState:UIControlStateNormal];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:data.User.HeadPhoto]
                            placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.nameLabel.text = data.User.Nickname;
    self.IDLabel.text = [NSString stringWithFormat:@"ID:%ld",data.User.Id];
    self.introLabel.text = data.User.Introduction;
    [self.dingyueButton setTitle:[NSString stringWithFormat:@"%ld 订阅", [data.Works.firstObject Access]] forState:UIControlStateNormal];
     [self.fansButton setTitle:[NSString stringWithFormat:@"%ld 粉丝", data.RID] forState:UIControlStateNormal];
    
}

-(void)setUserData:(DiscoveryUsersData *)userData{
    _userData = userData;
    [self.worksButton setTitle:[NSString stringWithFormat:@"%ld 作品",userData.Works.count] forState:UIControlStateNormal];
    [self.transmitButton setTitle:[NSString stringWithFormat:@"%d 转发", 0] forState:UIControlStateNormal];
    [self.joinButton setTitle:[NSString stringWithFormat:@"%d 收藏", 0] forState:UIControlStateNormal];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:userData.User.HeadPhoto]
                            placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.nameLabel.text = userData.User.Nickname;
    self.IDLabel.text = [NSString stringWithFormat:@"ID:%ld",userData.User.Id];
    self.introLabel.text = userData.User.Introduction;
    [self.dingyueButton setTitle:[NSString stringWithFormat:@"%ld 订阅", [userData.Works.firstObject Access]] forState:UIControlStateNormal];
    [self.fansButton setTitle:[NSString stringWithFormat:@"%ld 粉丝", userData.RID] forState:UIControlStateNormal];
}

@end
