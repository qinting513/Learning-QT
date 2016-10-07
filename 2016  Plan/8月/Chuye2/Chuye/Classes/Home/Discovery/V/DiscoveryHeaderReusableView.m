//
//  DiscoveryHeaderReusableView.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "DiscoveryHeaderReusableView.h"

@interface DiscoveryHeaderReusableView ()



@end

@implementation DiscoveryHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    for (UIButton *btn in self.allBtns) {
        btn.layer.cornerRadius = btn.frame.size.width * 0.5;
        btn.layer.masksToBounds = YES;
    }
}

-(void)setUsers:(NSArray *)users{
    _users = users;
    for(int i = 0; i< users.count; i++){
       UIButton *b =  self.allBtns[i];
        [b setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:users[i]] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    }
}

@end
