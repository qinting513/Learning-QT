//
//  WorksTableViewCell.h
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserModel.h"
#import "AddFriend.h"
#import "DiscoveryUsers.h"

@interface WorksTableViewCell : UITableViewCell

@property (nonatomic,strong) UserModelDataWorks  *works;
@property (nonatomic,strong) AddFriendDataWorks *data;

@property (nonatomic, strong) DiscoveryUsersDataWorks *userDataWorks;

@end
