//
//  AddFriendCell.m
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
}

@end
