//
//  MainTableViewController.m
//  tableView添加搜索框
//
//  Created by tarena01 on 15/11/18.
//  Copyright (c) 2015年 qt. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController () <UISearchResultsUpdating,UISearchBarDelegate>

@end

@implementation MainTableViewController



-(NSArray*)allProduct
{
    if (!_allProduct)
    {
        _allProduct = [Product demoData];
    }
    return _allProduct;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品列表";
    //create 用于展示搜索结果的表VC的实例
    self.showResultVC = [[ShowResultTableViewController alloc]init];
    
    //创建搜索控制器的实例
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:self.showResultVC];
    
//    设置适应屏幕宽度
    [self.searchController.searchBar  sizeToFit];
    
//    为当前表头视图添加searchBar
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //设置搜索条的分段类别  scope（范围）
    self.searchController.searchBar.scopeButtonTitles =@[@"设备",@"软件",@"其他"];
    
    //设置搜索控制器的结果更新给代理
    self.searchController.searchResultsUpdater = self;
    
    //允许当前界面上切换展示数据的context（上下文）对象
//    设置此属性才能由另一个表视图显示搜索结果
    self.definesPresentationContext = YES;
    
    //为了捕获searchBar上的类别按钮被点击时，也能立即响应，应设置代理
    self.searchController.searchBar.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allProduct.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    Product* p = self.allProduct[indexPath.row];
    cell.textLabel.text =p.name;
   
    
    return cell;
}

#pragma mark --UISearchResultUpdating协议
//只要用户在文本框中输入的文本发生变化 则自动调用此方法

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
//    根据用户输入的文字，逐一比对商品信息
//    将商品信息显示到展示结果的VC中
    
    //从searchBar中获取用户输入的文字
    NSString* searchText = searchController.searchBar.text;
    
    //获取用户选择的类别按钮
    NSInteger selectedBtnIndex = searchController.searchBar.selectedScopeButtonIndex;
    
    //到self.allProduct中逐一比对 将匹配的存到数组
    NSMutableArray* resultArray = [NSMutableArray array];
    for (Product* p in self.allProduct)
    {
        //判断商品名称 包含输入的搜索文本的范围
        //如果名称匹配 且 类别相同 则将此商品记录到结果数组中
        NSRange range = [p.name rangeOfString:searchText];
        if (range.length>0 && p.type==selectedBtnIndex )
        {
            [resultArray addObject:p];
        }
    }
    
    //把数据传给showResultVC
    self.showResultVC.resultArray = resultArray;
    
    [self.showResultVC.tableView reloadData];

}

#pragma mark -- 
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];

}

@end
