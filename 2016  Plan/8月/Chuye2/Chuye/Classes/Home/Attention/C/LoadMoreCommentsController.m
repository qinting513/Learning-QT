//
//  LoadMoreCommentsController.m
//  Chuye
//
//  Created by Qinting on 16/8/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "LoadMoreCommentsController.h"
#import "UIView+Round.h"
#import "AddFriendCell.h"
@interface LoadMoreCommentsController ()

@end

@implementation LoadMoreCommentsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"所有评论";
    self.tableView.rowHeight = 80;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return   self.data.Comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CommentsCell";
    AddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddFriendCell" owner:nil options:nil] lastObject];;
    }
    AttentionDataComments *com = self.data.Comments[indexPath.row];
    cell.nameLabel.text = com.User.Nickname;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:com.User.HeadPhoto] placeholderImage:[UIImage imageNamed:@"work_pic"]];
          cell.descLabel.text = com.Content;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    for (int i = 0; i<  self.data.Comments.count; i ++) {
//        NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexP];
//
//        cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width * 0.5;
//        cell.imageView.layer.masksToBounds  = YES;
//    }

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
