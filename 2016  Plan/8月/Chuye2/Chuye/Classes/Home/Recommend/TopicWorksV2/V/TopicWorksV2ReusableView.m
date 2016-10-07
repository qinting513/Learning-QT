//
//  TopicWorksV2ReusableView.m
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TopicWorksV2ReusableView.h"

@implementation TopicWorksV2ReusableView

-(void)layoutSubviews{
    [super layoutSubviews];
}



-(void)setData:(MoreTopicsData *)data{
    _data = data;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:data.ThumbnailUrl] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    [self.titleLabel setText:data.Title];
    self.introLabel.text = data.Description;
}

@end
