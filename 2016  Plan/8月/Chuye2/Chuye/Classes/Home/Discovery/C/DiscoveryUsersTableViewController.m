//
//  DiscoveryUsersTableViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "DiscoveryUsersTableViewController.h"
#import "DiscoveryUtils.h"
#import "DiscoveryUsersCell.h"
//#import "UserDetailViewController.h"
#import "FriendViewController.h"

/** 点击进入到详细界面 */
#import "RecommendBannerViewController.h"

@interface DiscoveryUsersTableViewController ()
@property (nonatomic,strong) NSMutableArray  *allUsers;
@property (nonatomic,assign) NSInteger lastId ;

@end

@implementation DiscoveryUsersTableViewController

#pragma  mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现用户";
     [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        NSString *url = @"http://chuye.cloud7.com.cn/dataflow/discoveryUsers?device=iOS&version=2.9.7&nettp=WIFI";
        [DiscoveryUtils GETUsers:url completionHandler:^(DiscoveryUsers *discoveryUsers, NSError *myError) {
            [weakSelf.allUsers addObjectsFromArray:discoveryUsers.data];
           DiscoveryUsersData *d = weakSelf.allUsers.lastObject;
            weakSelf.lastId = d.RID;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endHeaderRefresh];
        }];
    }];
    [self.tableView addBackFooterRefresh:^{
        NSString *url = [NSString stringWithFormat:@"http://chuye.cloud7.com.cn/dataflow/discoveryUsers?device=iOS&version=2.9.7&nettp=WIFI&lastId=%ld",weakSelf.lastId];
        [DiscoveryUtils GETUsers:url completionHandler:^(DiscoveryUsers *discoveryUsers, NSError *myError) {
                   [weakSelf.allUsers addObjectsFromArray:discoveryUsers.data];
                    [weakSelf.tableView reloadData];
                  [weakSelf.tableView endFooterRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allUsers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoveryUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoveryUsersCell" forIndexPath:indexPath];
    cell.usersData = self.allUsers[indexPath.row];
    [cell.iconButton addTarget:self action:@selector(clickIntoUserDetail:) forControlEvents:UIControlEventTouchUpInside];
    for (UIButton* b in cell.imageBtns) {
        [b addTarget:self action:@selector(clickImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

#pragma mark - 按钮的点击事件
-(void)clickIntoUserDetail:(UIButton*)btn{
/** 获取到是点击的按钮是哪一行的 */
    DiscoveryUsersCell *cell = (DiscoveryUsersCell*)btn.superview.superview.superview;
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
  DiscoveryUsersData *userData =  self.allUsers[indexP.row];
//    NSLog(@"-----%@",userData);
    FriendViewController  *vc = [[FriendViewController alloc]init];
    vc.isFromDiscovery = YES;
    vc.userData = userData;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickImageBtn:(UIButton*)btn{
    DiscoveryUsersCell *cell = (DiscoveryUsersCell*)btn.superview.superview.superview;
    NSIndexPath *indexP = [self.tableView indexPathForCell:cell];
//        NSLog(@"---%ld --- %ld",indexP.row,btn.tag);
      DiscoveryUsersData *userData =  self.allUsers[indexP.row];
    DiscoveryUsersDataWorks * work = userData.Works[btn.tag];
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
    vc.url = work.Uri;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (NSMutableArray *)allUsers {
    if(_allUsers == nil) {
        _allUsers = [[NSMutableArray alloc] init];
    }
    return _allUsers;
}

@end
