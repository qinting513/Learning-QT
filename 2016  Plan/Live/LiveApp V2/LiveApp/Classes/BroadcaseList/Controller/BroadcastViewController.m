//
//  BroadcastViewController.m
//  LiveApp
//
//  Created by Qinting on 2016/10/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "BroadcastViewController.h"
#import "LiveTableViewCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "LiveItem.h"

@interface BroadcastViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView  *tableView;
@property (nonatomic,strong) NSArray  *lives;
@end

static NSString * cellID = @"LiveTableViewCell";

@implementation BroadcastViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"直播列表";
    [self initTableView];
    [self loadData];
}

-(void)initTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LiveTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 420.0f;
    self.tableView.estimatedRowHeight = UITableViewAutomaticDimension;
}


-(void)loadData{
    
    // 映客数据url
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    AFHTTPSessionManager *manamger = [AFHTTPSessionManager manager];
    manamger.responseSerializer = [AFJSONResponseSerializer serializer];
    manamger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [manamger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        self.lives = [LiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail: %@",error);
    }];
    
}

#pragma  mark - tableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lives.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.liveItem = self.lives[indexPath.row];
    return cell;
}



@end
