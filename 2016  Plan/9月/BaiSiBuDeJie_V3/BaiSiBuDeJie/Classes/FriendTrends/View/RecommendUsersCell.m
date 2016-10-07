//
//  RecommendUsersCell.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "RecommendUsersCell.h"
#import "RecommendUsersResult.h"

@interface RecommendUsersCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (weak, nonatomic) IBOutlet UIButton *recommendButton;

@end

@implementation RecommendUsersCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
}


+(UITableViewCell *)cellWithTableView:(UITableView*)tableView{
static NSString* ID = @"RecommendUsersCell";
    RecommendUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setUserList:(RecommendUsersResultList *)userList{
    _userList = userList;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:userList.header]];
    self.nameLabel.text = userList.screen_name;
    self.followLabel.text = [NSString stringWithFormat:@"%@人关注",userList.fans_count];
}

@end
