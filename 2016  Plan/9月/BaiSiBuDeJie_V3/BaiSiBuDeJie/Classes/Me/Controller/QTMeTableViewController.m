//
//  QTMeTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTMeTableViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "QTMeTool.h"
#import "QTMeParam.h"
#import "QTMeButtonListCell.h"
#import "QTLoginViewController.h"

@interface QTMeTableViewController ()

@property (nonatomic,strong) NSArray *tagLists;
@property (nonatomic,strong) NSArray *squareLists;

@end

@implementation QTMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor darkGrayColor];
    [self loadData];
    [self setupNavbar];

}

- (void)setupNavbar{
    self.view.backgroundColor =  GlobalColor;
    self.navigationItem.title = @"我的";
    UIBarButtonItem *moonItem= [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImageName:@"mine-moon-icon-click" target:self action:@selector(moonBarButtonItemClick)];
    
    UIBarButtonItem *toolItem= [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImageName:@"mine-setting-icon-click" target:self action:@selector(toolBarButtonItemClick)];
    self.navigationItem.rightBarButtonItems = @[toolItem,moonItem];
}

- (void)moonBarButtonItemClick{
    MYLog(@"moonBarButtonItemClick");
}

- (void)toolBarButtonItemClick{
    MYLog(@"toolBarButtonItemClick");
}

- (void) loadData{
    /** 设置请求参数 */
    QTMeParam *param = [[QTMeParam alloc]init];
    param.a = @"square";
    param.c = @"topic";
    
    /** 获取请求结果 并已经转化成模型类 */
        [QTMeTool  meToolWithParam:param success:^(QTMeResult *result) {
            self.tagLists = result.tag_list;
            self.squareLists = result.square_list;
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            MYLog(@"Me Fetch Failure: %@",error);
        }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 2) {
        UITableViewCell *cell = [self cellWithTable:tableView row:indexPath.row];
        return cell;
    }else{
        QTMeButtonListCell *cell = [QTMeButtonListCell cellWithTableView:tableView];
        cell.squareLists = self.squareLists;
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return  95*7;
    }
    return 44;
}

- (UITableViewCell *)cellWithTable:(UITableView *)tableView row:(NSUInteger)index {
    NSString *cellID = index == 0 ?  @"login" :  @"baisihongren";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell  =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (index == 0) {
      cell.textLabel.text = @"登录／注册";
    }else{
    cell.textLabel.text = @"离线下载";
    }
    return cell;
}

#pragma  mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        QTLoginViewController *loginVC = [[QTLoginViewController alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else if (indexPath.row == 1){
    
    }else{
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
