//
//  showResultTableViewController.h
//  tableView添加搜索框
//
//  Created by tarena01 on 15/11/18.
//  Copyright (c) 2015年 qt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowResultTableViewController : UITableViewController

//本控制器是被动使用的，所以要展示的数据来源是使用者提供，于是需要公开一个属性
//这个数组中的元素类似都是Product
@property(nonatomic,strong)NSArray* resultArray;

@end
