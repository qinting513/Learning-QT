//
//  QTMeButtonListCell.h
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTMeButtonListCell : UITableViewCell

@property (nonatomic,strong) NSArray *squareLists;

/** 返回一个cell */
+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
