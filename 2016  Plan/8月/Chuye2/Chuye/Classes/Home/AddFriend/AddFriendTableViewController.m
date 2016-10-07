//
//  AddFriendTableViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AddFriendTableViewController.h"
#import "AddFriendUtils.h"
#import "AddFriend.h"
#import "UIView+Round.h"

#import "AddFriendCell.h"
#import "FriendViewController.h"

@interface AddFriendTableViewController ()
@property (nonatomic,strong) NSMutableArray  *allUsers;
@property (nonatomic,assign) NSInteger  lastId;
@end

@implementation AddFriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
    self.title = @"添加好友";
    self.tableView.rowHeight = 80;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddFriendCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        NSString *url = @"http://chuye.cloud7.com.cn/dataflow/discoveryUsers?device=iOS&version=2.9.7&nettp=WIFI";
        [AddFriendUtils GETFriends:url completionHandler:^(id mode, NSError *err) {
          AddFriend *friend = mode;
            for (id obj in friend.data) {
                [weakSelf.allUsers insertObject:obj atIndex:0];
            }
//            [weakSelf.allUsers addObjectsFromArray:friend.data];
            AddFriendData *d = weakSelf.allUsers.lastObject;
            weakSelf.lastId = d.RID;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endHeaderRefresh];
        }];
    }];
    [self.tableView addBackFooterRefresh:^{
        NSString *url = [NSString stringWithFormat:@"http://chuye.cloud7.com.cn/dataflow/discoveryUsers?device=iOS&version=2.9.7&nettp=WIFI&lastId=%ld",weakSelf.lastId];
        [AddFriendUtils GETFriends:url completionHandler:^(id mode, NSError *err) {
            AddFriend *friend = mode;
            [weakSelf.allUsers addObjectsFromArray:friend.data];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endFooterRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 1;
    return self.allUsers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"FriendCell";
    AddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

    if(indexPath.section == 0){
      cell.nameLabel.text = @"添加微信好友";
        cell.iconImageView.image = [UIImage imageNamed:@"add_wx_friend"];
        return cell;
    }
    
    AddFriendDataUser *user = [self.allUsers[indexPath.row] User];
    cell.nameLabel.text = user.Nickname;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.HeadPhoto]
                          placeholderImage:[UIImage imageNamed:@"work_pic"]];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
if(section == 0) return @"";
    return @"值得认识的人";
}

- (NSMutableArray *)allUsers {
	if(_allUsers == nil) {
		_allUsers = [[NSMutableArray alloc] init];
	}
	return _allUsers;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        NSURL *url = [NSURL URLWithString:@"Chuye://aaa?backScheme=wechat"];
        UIApplication  *app = [UIApplication sharedApplication];
        if ([app canOpenURL:url]) {
            NSLog(@"---url:%@",url);
            [app openURL:url];
        }else{
            NSLog(@"打开应用程序失败");
        }
            return;
    }

    FriendViewController *vc = [[FriendViewController alloc]init];
    vc.data = self.allUsers[indexPath.row];
    [self.navigationController pushViewController:vc  animated:YES];
}

@end
