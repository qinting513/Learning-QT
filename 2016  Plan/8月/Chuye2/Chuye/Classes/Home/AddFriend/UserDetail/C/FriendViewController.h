//
//  FriendViewController.h
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddFriend.h"
#import "DiscoveryUsers.h"

@interface FriendViewController : UIViewController
@property (nonatomic,strong) AddFriendData *data;
@property (nonatomic, strong) DiscoveryUsersData *userData;
@property (nonatomic,assign) BOOL  isFromDiscovery;
@end
