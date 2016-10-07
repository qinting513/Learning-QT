//
//  FriendCell.h
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FriendModel.h"

@interface FriendCell : UITableViewCell

@property (nonatomic,strong) FriendModel *friendModel;

+ (instancetype)friendCellWithTableView:(UITableView*)tableView;

@end
