//
//  FriendGroupHeaderView.h
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendGroupModel,FriendGroupHeaderView;

@protocol FriendGroupHeaderViewDelegate <NSObject>

@optional
-(void)friendGroupHeaderViewDidClickNameBtn:(FriendGroupHeaderView*)headerView;

@end


@interface FriendGroupHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong) FriendGroupModel *friendGroup;

@property (nonatomic,weak)  id <FriendGroupHeaderViewDelegate> delegate;

+(instancetype)headerViewWithTableView:(UITableView*)tableView;

@end
