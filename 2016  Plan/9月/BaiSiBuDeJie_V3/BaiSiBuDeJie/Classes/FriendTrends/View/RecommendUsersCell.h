//
//  RecommendUsersCell.h
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendUsersResultList;

@interface RecommendUsersCell : UITableViewCell

+(UITableViewCell *)cellWithTableView:(UITableView*)tableView;

@property (nonatomic,strong) RecommendUsersResultList *userList;

@end
