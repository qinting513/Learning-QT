//
//  WorksCell.h
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnCellHeight)(CGFloat height);
typedef void(^ReturnClickTopic)( NSString *url);

@interface WorksCell : UITableViewCell
/** 创建Cell */
+(WorksCell*)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath ;
@property (nonatomic,strong) NSArray  *works;
@property (nonatomic,strong)  ReturnCellHeight cellHeight;
@property (nonatomic,strong) ReturnClickTopic  clickTopic;
@end
