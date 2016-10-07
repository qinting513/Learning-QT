//
//  JoinInTableViewCell.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "JoinInTableViewCell.h"

@interface JoinInTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessShareLabel;

@end

@implementation JoinInTableViewCell
-(void)setFavoritesData:(FavoritesData *)favoritesData{
    _favoritesData = favoritesData;
    [self.headerPhotoImageView sd_setImageWithURL:[NSURL URLWithString:favoritesData.Thumbnail] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.titleLabel.text = favoritesData.Title;
    self.accessShareLabel.text  = [NSString stringWithFormat:@"•  %ld/%ld/%ld",favoritesData.Access,favoritesData.Share,favoritesData.Comments];
}


@end
