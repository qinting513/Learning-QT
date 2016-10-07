//
//  MoreTopicsTableViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MoreTopicsTableViewController.h"
#import "MoreTopics.h"
#import "RecommendUtils.h"
#import "MoreTopicsTableViewCell.h"
@interface MoreTopicsTableViewController ()
@property (nonatomic,strong) NSArray   *allMoreTopicsData;
@end

@implementation MoreTopicsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"话题";
         [self setupRefresh];
    self.tableView.contentInset = UIEdgeInsetsMake(6, 0, 0, 0);
}

-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        /** 初始化所有数值 */
       NSString *url = @"http://chuye.cloud7.com.cn/dataflow/ActiveTopics?device=iOS&version=2.9.7&nettp=WIFI";
        [RecommendUtils   GETMoreTopics:url completionHandler:^(NSArray *arr, NSError *error) {
            weakSelf.allMoreTopicsData = arr;
            [weakSelf.tableView endHeaderRefresh];
            [weakSelf.tableView reloadData];
        }];

    }];

    [self.tableView beginHeaderRefresh];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allMoreTopicsData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTopicsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreTopicsTableViewCell" forIndexPath:indexPath];
    cell.data = self.allMoreTopicsData[indexPath.row];
    return cell;
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
