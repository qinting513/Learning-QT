//
//  SettingViewController.m
//  影讯App
//
//  Created by tarena22 on 16/8/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingHeaderView.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *groups;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    
//    self.navigationController.navigationBar.clipsToBounds=YES;
    self.groups = [NSMutableArray array];
    
    NSArray *g1 = @[@[@"寂寞公告",@"address_list"]];
    
    NSArray *g2 = @[@[@"墨圈",@"game_center"],@[@"活动中心",@"alipay_msp_comment"],@[@"皮肤小铺",@"app"],@[@"个性助手",@"APC_Qrcode"]];
    
    NSArray *g3 = @[@[@"墨迹商城",@"more"],@[@"空气果",@"hot_status"]];
    NSArray *g4 = @[@[@"设置",@"cast"]];
    NSArray *g5 = @[@[@"清理缓存",@"APC_chi_g"]];
    self.groups = @[g1,g2,g3,g4,g5];
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tv.dataSource = self;
    tv.delegate = self;
    [self.view addSubview:tv];
    self.tableView = tv;
     SettingHeaderView *hv = [[NSBundle mainBundle]loadNibNamed:@"SettingHeaderView" owner:self options:0][0];
    self.tableView.tableHeaderView = hv;
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *group = self.groups[section];
    return group.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSArray *group = self.groups[indexPath.section];
    
    NSArray *item = group[indexPath.row];
    cell.textLabel.text = item[0];
    cell.imageView.image = [UIImage imageNamed:item[1]];
    
    
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    SettingHeaderView* UHV = (SettingHeaderView*)self.tableView.tableHeaderView;
    [UHV updateSubViewsWithOffset:scrollView.contentOffset.y];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
