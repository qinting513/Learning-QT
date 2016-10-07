//
//  RequetsTableViewController.m
//  EaseDemo
//
//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "RequetsTableViewController.h"
#import "EasemobManager.h"

@interface RequetsTableViewController ()

@end

@implementation RequetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [EasemobManager sharedManager].requestArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSDictionary *dict = [EasemobManager sharedManager].requestArray[indexPath.row];
    cell.textLabel.text = dict[@"userName"];
    cell.detailTextLabel.text = dict[@"message"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        NSDictionary *dict = [EasemobManager sharedManager].requestArray[indexPath.row];
    NSString *title =  [NSString stringWithFormat:@"%@想添加你",dict[@"userName"]];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:dict[@"message"]   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[EasemobManager sharedManager]allowFriendRequest:dict[@"userName"] allowBlock:^{
              [[NSNotificationCenter defaultCenter]postNotificationName:@"FriendStatusChange" object:nil];
            [[EasemobManager sharedManager].requestArray removeObject:dict];
            [self.tableView reloadData];
        }];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [[EasemobManager sharedManager] denyFriendRequest:dict[@"userName"] denyBlock:^{
            [[EasemobManager sharedManager].requestArray removeObject:dict ];
            [self.tableView reloadData];
        }];
    }];
    [ac addAction:action1];
    [ac addAction:action2];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
