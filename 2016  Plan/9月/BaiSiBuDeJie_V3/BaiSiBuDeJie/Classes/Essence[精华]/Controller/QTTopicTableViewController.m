//
//  QTTopicTableViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTTopicTableViewController.h"
#import "QTTopicParam.h"
#import "QTNewViewController.h"
#import "QTTopicTool.h"
#import "QTTopic.h"
#import "QTTopicFrame.h"
#import "QTTopicCell.h"

@interface QTTopicTableViewController ()

@property (nonatomic,strong) QTTopicParam *param;
/** 存储QTTopicFrame的数组 */
@property (nonatomic,strong) NSMutableArray *topicFrames;

@property (copy, nonatomic) NSString *maxtime;
@end

@implementation QTTopicTableViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupRefresh];
    [self loadNewTopic];

}

#pragma mark - 初始化
- (void)setupTableView{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /** nav 64 + headerView 44   底部tabbar 49*/
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
}

-(void)setupRefresh{
    /** header */
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    /** 头部显示最新更新时间 */
    self.tableView.mj_header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@ - %@ - %zd",[self class],self.param ,self.type];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    /** footer */
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    self.tableView.mj_footer.hidden = YES;
}
#pragma mark - 加载网络数据
/** 首次加载数据 */
-(void)loadNewTopic{
    
    /** 当前所加载的页码数 */
    NSNumber *lastPage = self.param.page;
    /** 当前加载的页码数 设置是1 */
    self.param.page = @1;
    [QTTopicTool topicGetDataWithParam:self.param success:^(QTTopicResult *result) {
        
      /** 第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：
             需要传入加载上一页时返回值字段“maxtime”中的内容。 */
        self.maxtime = result.maxtime;
        
        [self.topicFrames removeAllObjects];
        
        NSMutableArray *newFrames = [NSMutableArray array];
        /** 把topic赋给topicFrame中的topic */
        for (QTTopic *topic in result.list) {
            QTTopicFrame *f = [[QTTopicFrame alloc]init];
            f.topic = topic;
            [newFrames addObject:f];
        }
        [self.topicFrames addObjectsFromArray:newFrames];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        /** 请求失败， 当前所加载的页码数不变*/
        self.param.page = lastPage;
        [self.tableView.mj_header endRefreshing];
    }];

}

/** 加载更多 数据 */
-(void)loadMoreTopic{
/** 当前所加载的页码数 */
    NSNumber *lastPage = self.param.page;
    self.param.page = @(self.param.page.intValue + 1);
    self.param.maxtime = self.maxtime;
    
    /** 获取请求*/
    [QTTopicTool topicGetDataWithParam:self.param success:^(QTTopicResult *result) {
        self.maxtime = result.maxtime;
        NSMutableArray *newFrame = [NSMutableArray array];
        for (QTTopic  *topic in result.list) {
            QTTopicFrame *f = [[QTTopicFrame alloc]init];
            f.topic = topic;
            [newFrame addObject:f];
        }
        
        /** 获取更多的数据 往数组后i面添加即可 */
        [self.topicFrames addObjectsFromArray:newFrame];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        self.param.page = lastPage;
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topicFrames.count == 0);
    return self.topicFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QTTopicCell *cell = [QTTopicCell cellWithTableView:tableView];
    cell.topicFrame = self.topicFrames[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QTTopicFrame *topicFrame = self.topicFrames[indexPath.row];
    return topicFrame.cellHeight + 20;
}

#pragma mark - lazy
- (QTTopicParam *)param {
	if(_param == nil) {
		_param = [[QTTopicParam alloc] init];
        _param.a = [self.parentViewController isKindOfClass:[QTNewViewController class]] ? @"newlist" : @"list";
        _param.c = @"data";
        _param.type = self.type;
	}
	return _param;
}


- (NSMutableArray *)topicFrames {
	if(_topicFrames == nil) {
		_topicFrames = [[NSMutableArray alloc] init];
	}
	return _topicFrames;
}

@end
