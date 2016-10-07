//
//  MeTableViewCell.m
//  CustomCell
//
//  Created by Qinting on 16/7/14.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MeTableViewCell.h"
#import "UIView+Extension.h"

@implementation MeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         
         //设置背景图片
         UIImageView *bgView = [[UIImageView alloc]init];
         bgView.image = [UIImage imageNamed:@"background"];
         self.backgroundView = bgView;
         
         self.textLabel.textColor = [UIColor redColor];
         self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image  == nil) {
        return ;
    }
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.imageView.x = 10;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 1;
    
    NSLog(@"%@",NSStringFromCGPoint(self.imageView.center));
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    NSLog(@"%@",NSStringFromCGRect(self.frame));
}

@end
