//
//  DiscoveryUsersCell.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "DiscoveryUsersCell.h"
#import "UIView+Round.h"

@interface DiscoveryUsersCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introdutionLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *descLabels;

@end

@implementation DiscoveryUsersCell

-(void)setUsersData:(DiscoveryUsersData *)usersData{
    _usersData = usersData;
    /** 给用户设置显示内容 */
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:usersData.User.HeadPhoto]
                                        placeholderImage:[UIImage imageNamed:@"find user_btn"]];
    self.nicknameLabel.text = usersData.User.Nickname;
    self.introdutionLabel.text = usersData.User.Introduction;
    
    /** 设置图片按钮 */
    for (int i = 0; i <usersData.Works.count; i++) {
        UIButton *b = self.imageBtns[i];
        UILabel *label = self.descLabels[i];
        DiscoveryUsersDataWorks *works = usersData.Works[i];
        [b setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:works.ThumbnailUrl] placeholderImage:[UIImage imageNamed:@"AppIcon57x57"]];
        label.text = works.Title;
    }

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.iconImageView circleImage];
    for (UIButton *b  in self.imageBtns) {
        [b  circleImageWithCornerRadius:5.0f borderWidth:1.0f borderColor:[UIColor whiteColor]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
