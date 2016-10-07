//
//  FriendCell.m
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendCell.h"


@implementation FriendCell

-(void)setFriendModel:(FriendModel *)friendModel
{
    self.friendModel = friendModel;
    self.textLabel.text = friendModel.name;
    self.detailTextLabel.text = friendModel.intro;
    self.imageView.image = [UIImage imageNamed:friendModel.icon];
    //会员
    self.textLabel.textColor = friendModel.isVip ? [UIColor redColor] : [UIColor blackColor];
    
}


+ (instancetype)friendCellWithTableView:(UITableView*)tableView{
 static NSString *reuseID = @"cell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    return cell;

}

@end
