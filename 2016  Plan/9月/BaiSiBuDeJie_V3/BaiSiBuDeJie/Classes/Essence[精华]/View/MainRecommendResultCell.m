//
//  MainRecommendResultCell.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MainRecommendResultCell.h"

@interface MainRecommendResultCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end

@implementation MainRecommendResultCell

-(void)setResult:(MainRecommendResult *)result{
    _result = result;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:result.image_list] placeholderImage:[UIImage imageNamed:@"header_cry_icon"]];
    self.titleLabel.text = result.theme_name;
    self.descLabel.text = [NSString stringWithFormat:@"已有%@人关注", result.sub_number];
}


@end
