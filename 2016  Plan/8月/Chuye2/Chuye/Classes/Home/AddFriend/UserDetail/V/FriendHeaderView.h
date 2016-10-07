//
//  FriendHeaderView.h
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFriend.h"
#import "DiscoveryUsers.h"
/** 选择显示的类型 */
typedef NS_ENUM(NSUInteger,FriendShowType){
   FriendShowTypeWorks = 0,
    FriendShowTypeTransmit,
    FriendShowTypeJoin  //拿收藏的数据显示
};

typedef void(^FriendShowTypeBtnsClickAtIndex)(NSInteger index);

@interface FriendHeaderView : UIView
@property (nonatomic,strong) AddFriendData *data;
@property (nonatomic, strong) DiscoveryUsersData *userData;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIButton *fansButton;
@property (weak, nonatomic) IBOutlet UIButton *dingyueButton;

/** 作品 */
@property (weak, nonatomic) IBOutlet UIButton *worksButton;
@property (weak, nonatomic) IBOutlet UIButton *transmitButton;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
//私聊
@property (weak, nonatomic) IBOutlet UIButton *privateChatBtn;
//添加关注
@property (weak, nonatomic) IBOutlet UIButton *addFocusBtn;


@property (nonatomic,strong) FriendShowTypeBtnsClickAtIndex  friendShowTypeBtnsClickAtIndex;
@end
