//
//  RecommendCategoryCell.h
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendCategory.h"

@interface RecommendCategoryCell : UITableViewCell

+(UITableViewCell *)cellWithTableView:(UITableView*)tableView;
@property (nonatomic,strong) RecommendCategory *category;

@end
