//
//  QQListTableViewController.m
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QQListTableViewController.h"
#import "FriendModel.h"
#import "FriendGroupModel.h"
#import "FriendGroupHeaderView.h"
#import "FriendCell.h"

@interface QQListTableViewController ()<FriendGroupHeaderViewDelegate>

@property (nonatomic,strong) NSArray  *friendGroups;

@end

@implementation QQListTableViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 44;
}


-(NSArray *)friendGroups{
    if (_friendGroups == nil) {
        _friendGroups = [FriendGroupModel getFriendGroupsList];
    }
    
    return _friendGroups;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.friendGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FriendGroupModel *friendGroupModel = self.friendGroups[section];
    
    
    return friendGroupModel.isExpend ? friendGroupModel.friends.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [FriendCell friendCellWithTableView:tableView];
    FriendGroupModel *friendGroupModel = self.friendGroups[indexPath.section];
    FriendModel *friendModel = friendGroupModel.friends[indexPath.row];
//    cell.friendModel = friendModel;
    
    cell.textLabel.text = friendModel.name;
    cell.detailTextLabel.text = friendModel.intro;
    cell.imageView.image = [UIImage imageNamed:friendModel.icon];
    cell.textLabel.textColor = friendModel.isVip ? [UIColor redColor] : [UIColor blackColor];
    return cell;
}


#pragma mark - Table view delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FriendGroupHeaderView *headerView = [FriendGroupHeaderView headerViewWithTableView:tableView];
    headerView.delegate = self;
    
    FriendGroupModel *friendGroup = self.friendGroups[section];
    headerView.friendGroup = friendGroup;
    
    headerView.tag = section;
    return headerView;
}

#pragma mark - headerView的代理方法
-(void)friendGroupHeaderViewDidClickNameBtn:(FriendGroupHeaderView *)headerView{
    
    NSIndexSet *indexSection = [NSIndexSet indexSetWithIndex:headerView.tag];
    [self.tableView reloadSections:indexSection  withRowAnimation:UITableViewRowAnimationNone];

}


@end
