//
//  NewsCell.h
//  Demo3_自定义Cell
//
//  Created by Qinting on 16/4/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
@interface NewsCell : UITableViewCell
//工厂方法
+(instancetype)cellForTableView:(UITableView*)tableView;
//设置数据
-(void)setData:(News*)news;
@end











