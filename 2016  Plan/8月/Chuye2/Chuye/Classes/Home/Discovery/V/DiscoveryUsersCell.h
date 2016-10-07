//
//  DiscoveryUsersCell.h
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoveryUsers.h"

@interface DiscoveryUsersCell : UITableViewCell
@property (nonatomic,strong) DiscoveryUsersData  *usersData;
/** 点击进入用户的详情界面 */
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageBtns;
@end
