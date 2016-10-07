//
//  WeiboTableViewController.m
//  WeiboDemo
//
//  Created by Qinting on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WeiboTableViewController.h"
#import "DataManager.h"
#import "WeiboCell.h"
#import "Weibo.h"
#import "WeiboFrame.h"

@interface WeiboTableViewController ()

@property (nonatomic,strong) NSArray  *allData;

@end

@implementation WeiboTableViewController

/** 懒加载 获取数据模型，模型里不仅有数据 还有每个控件的布局属性 */
- (NSArray *)allData {
    if( !_allData) {
        _allData = [DataManager loadData] ;
    }
    return  _allData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
      NSLog(@"numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     NSLog(@"numberOfRowsInSection--%ld", section);
    return  self.allData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath--%ld",indexPath.row);
static NSString *cellID = @"weibo";
    WeiboCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil ) {
        cell = [[WeiboCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
       cell.weiboF  = self.allData[indexPath.row];
    
    return cell;
}


-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       NSLog(@"heightForRowAtIndexPath--%ld",indexPath.row);
    /**  从数组里获取出模型，将计算的cell的高度返回 */
    WeiboFrame *f  = self.allData[indexPath.row];
    return f.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       WeiboFrame *f  = self.allData[indexPath.row];
      self.backBlock(f.weibo.name,f.weibo.content);
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
