//
//  LiveTableViewCell.m
//  LiveApp
//
//  Created by Qinting on 2016/10/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "LiveTableViewCell.h"
#import <UIImageView+WebCache.h>

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LiveTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIconIV;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineUsersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicIV;
@property (weak, nonatomic) IBOutlet UILabel *liveLabel;

@end

@implementation LiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headIconIV.layer.cornerRadius = 5;
    _headIconIV.layer.masksToBounds = YES;
    
    _liveLabel.layer.cornerRadius = 5;
    _liveLabel.layer.masksToBounds = YES;
}

-(void)setLiveItem:(LiveItem *)liveItem{
    _liveItem = liveItem;
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",liveItem.creator.portrait]];
//    [self.headIconIV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@""]];
    [self.headIconIV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"1.jpg"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    self.nickNameLabel.text = liveItem.creator.nick;
    if (liveItem.city.length == 0) {
        self.addressLabel.text = @"难道在火星?";
    }else{
        self.addressLabel.text = liveItem.city;
    }
    [self.bigPicIV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%zd人在看", liveItem.online_users];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%zd", liveItem.online_users]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:Color(216, 41, 116) range:range];
    self.onlineUsersLabel.attributedText = attr;
    
}

@end
