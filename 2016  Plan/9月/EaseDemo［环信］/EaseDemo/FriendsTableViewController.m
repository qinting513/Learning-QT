//
//  FriendsTableViewController.m
//  EaseDemo
//
//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "ViewController.h"
#import "ChatViewController.h"
#import "EasemobManager.h"
#import "RequetsTableViewController.h"
#import "ConversationsTableViewController.h"

@interface FriendsTableViewController ()<IChatManagerDelegate>
@property (nonatomic,strong) NSMutableArray   *allFriends;
@property (nonatomic,strong) NSArray  *offlineMessages;
@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友列表";
  
   UIBarButtonItem *logout = [[UIBarButtonItem alloc]initWithTitle:@"logout" style:0 target:self action:@selector(logoutAction)];
   UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithTitle:@"add" style:0 target:self action:@selector(addAction)];
    UIBarButtonItem *coversation = [[UIBarButtonItem alloc]initWithTitle:@"最近聊天" style:0 target:self action:@selector(coversationBtnClik)];
    self.navigationItem.rightBarButtonItems = @[logout,add,coversation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendStatusChange) name:@"FriendStatusChange" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offlineMessagesAction:) name:@"ReceiveOfflineMessagesNotification" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadFriennds];
}

-(void)coversationBtnClik{
    ConversationsTableViewController *vc = [[ConversationsTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark  - 接收到好友请求
-(void)friendStatusChange{
    [self loadFriennds];
}

-(void)offlineMessagesAction:(NSNotification*)noti{
    self.offlineMessages = noti.object;
    [self.tableView reloadData];
}

#pragma  mark  - 退出
- (void)logoutAction {
  [[EasemobManager sharedManager] logout:^{
      [self.navigationController popViewControllerAnimated:YES];
  }];
}

#pragma  mark  -  添加
- (void)addAction {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入好友名" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {  }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[EasemobManager sharedManager]addFriendWithName:ac.textFields[0].text  andMessage:@"来啊，互相伤害！"];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [self presentViewController:ac animated:YES completion:nil];
}
#pragma  mark  - 获取好友
-(void)loadFriennds{
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
//            NSLog(@"获取成功 -- %@",buddyList);
            for (id obj in buddyList) {
                if(![self.allFriends containsObject:obj]){
                    [self.allFriends insertObject:obj atIndex:0];
                }
            }
            [self.tableView reloadData];
        }else{
            NSLog(@"获取错误:%@",error);
        }
    } onQueue:nil];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 1;
    return self.allFriends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if(indexPath.section == 0){
        cell.textLabel.text = [NSString stringWithFormat:@"%ld个好友请求",[EasemobManager sharedManager].requestArray.count];
        if(self.offlineMessages.count > 0){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld条未读消息",self.offlineMessages.count];
        }
        
    }else{
        EMBuddy *buddy = self.allFriends[indexPath.row];
        cell.textLabel.text = buddy.username;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMBuddy *buddy = self.allFriends[indexPath.row];
        [[EasemobManager sharedManager]deleteFriendWithName:buddy.username deleteSuccessBlock:^{
            [self.allFriends removeObject:buddy];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        RequetsTableViewController *vc = [[RequetsTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ChatViewController  * vc = [[ChatViewController  alloc]init];
        vc.toUser = [self.allFriends[indexPath.row] username];
        [self.navigationController pushViewController:vc animated:nil];
    }
}



- (NSMutableArray *)allFriends {
	if(_allFriends == nil) {
		_allFriends = [[NSMutableArray alloc] init];
	}
	return _allFriends;
}

@end
