//
//  ConversationsTableViewController.m
//  环信测试
//
//  Created by tarena on 16/9/2.
//  Copyright © 2016年 tarena. All rights reserved.
//
#import "ChatViewController.h"
#import "ConversationsTableViewController.h"
#import "EasemobManager.h"
@interface ConversationsTableViewController ()
@property (nonatomic, strong)NSArray *conversations;
@end

@implementation ConversationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.conversations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
 
    EMConversation *c = self.conversations[indexPath.row];
    
    cell.textLabel.text = c.chatter;
    //显示最后一句话
    EMMessage *message = c.latestMessage;
    
    //得到消息的具体内容
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch ((int)msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            
            cell.detailTextLabel.text = txt;
        }
            break;
        case eMessageBodyType_Image:
        {
           cell.detailTextLabel.text = @"[图片消息]";
        }
            break;
        case eMessageBodyType_Voice:
        {
              cell.detailTextLabel.text = @"[语音消息]";
            
        }
            break;
            
    }

    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EMConversation *c = self.conversations[indexPath.row];
    
    ChatViewController *vc = [ChatViewController new];
    
    vc.toUser = c.chatter;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
