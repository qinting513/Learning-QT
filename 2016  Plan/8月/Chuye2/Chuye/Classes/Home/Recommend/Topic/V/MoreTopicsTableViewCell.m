//
//  MoreTopicsTableViewCell.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MoreTopicsTableViewCell.h"
@interface MoreTopicsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *dingyueButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end


@implementation MoreTopicsTableViewCell

-(void)setData:(MoreTopicsData *)data{
    _data = data;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:data.ThumbnailUrl] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.titleLabel.text = [NSString stringWithFormat:@"# %@ #",data.Title];
    self.countLabel.text = [NSString stringWithFormat:@"%ld篇  %ld人 订阅",data.WorkCount,data.SubscribeCount];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
