//
//  TopicWorksV2Cell.m
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TopicWorksV2Cell.h"

@interface TopicWorksV2Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoritesBtn;

@end

@implementation TopicWorksV2Cell
-(void)setList:(TopicWorksV2DataList *)list{
    _list = list;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:list.ThumbnailUrl] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.nameLabel.text = list.User.nickname;
    self.titleLabel.text = list.Title;
    [self.favoritesBtn setTitle:@(list.Praise).stringValue forState:UIControlStateNormal];
}

@end
