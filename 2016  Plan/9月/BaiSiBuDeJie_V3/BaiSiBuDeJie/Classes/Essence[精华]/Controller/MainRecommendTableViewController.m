//
//  MainRecommendTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MainRecommendTableViewController.h"
#import <AFNetworking.h>
#import "HTTPTool.h"
#import "MainRecommendResult.h"
#import "MainRecommendResultCell.h"

@interface MainRecommendTableViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation MainRecommendTableViewController

  static NSString *cellID = @"MainRecommendResultCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    [self.tableView registerNib:[UINib nibWithNibName:@"MainRecommendResultCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 65;
    
    NSMutableDictionary *param  = [NSMutableDictionary dictionary];
    param[@"a"] = @"tag_recommend";
    param[@"action"] = @"sub";
    param[@"c"] = @"topic";
        
    [HTTPTool GET:MainURL params:param success:^(id json) {
        self.dataArray =  [MainRecommendResult mj_objectArrayWithKeyValuesArray:json];
        NSLog(@"json:    %@",json);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"request failure:%@",error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    MainRecommendResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath ];
   
    MainRecommendResult* result = self.dataArray[indexPath.row];
    cell.result = result;
    return cell;
}



@end
