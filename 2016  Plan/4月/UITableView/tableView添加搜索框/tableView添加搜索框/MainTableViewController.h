//
//  MainTableViewController.h
//  tableView添加搜索框
//
//  Created by tarena01 on 15/11/18.
//  Copyright (c) 2015年 qt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ShowResultTableViewController.h"

@interface MainTableViewController : UITableViewController

@property(nonatomic,strong)Product* product;

@property(nonatomic,strong) NSArray* allProduct;

@property(nonatomic,strong)UISearchController* searchController;

//属性：专门用来展示搜索结果的表视图控制器
@property (nonatomic,strong)ShowResultTableViewController* showResultVC;
@end
