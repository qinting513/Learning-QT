//
//  AttentionViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AttentionViewController.h"
#import "Attention.h"
#import "AttentionTableViewCell.h"
#import "LoadMoreCommentsController.h"
#import "MoreTopicsTableViewController.h"

#define kHeadViewHeight 150

@interface AttentionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView  *tableView;
@property (nonatomic,strong) NSMutableArray  *allAttentionDatas;
@property (nonatomic,strong) Attention *attention;
@property (nonatomic,assign) NSInteger  lastId;
@end

@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
}
//CGRectMake(0, 0, self.view.frame.size.width , kScreenH)
- (void)setupTableView {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset  =  UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview: self.tableView];

    UIView *headView = [UIView new];
    headView.frame = CGRectMake(0, 0, kScreenW, kHeadViewHeight);
    
   UIButton* btn = [UIButton buttonWithType:0];
    [btn setTitle:@"您还没有订阅作品，快去订阅吧！ > " forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(10, 10,self.tableView.frame.size.width - 20, kHeadViewHeight - 20);
    [btn addTarget:self action:@selector(loadMoreTopics) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview: btn];
    self.tableView.tableHeaderView =  headView;

    
    [self setupRefresh];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

-(void)loadMoreTopics{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MoreTopicsTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MoreTopicsTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [queue addOperationWithBlock:^{
           weakSelf.attention = [Attention parseAttention];
            [weakSelf.allAttentionDatas removeAllObjects];
            for(NSInteger  i = 0; i< 8; i++){
                [weakSelf.allAttentionDatas insertObject:weakSelf.attention.data[i] atIndex:i];
                weakSelf.lastId = 8;
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endHeaderRefresh];
            }];
            
        }];
        
    }];
    
    [self.tableView addBackFooterRefresh:^{

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSLog(@"la:%ld",weakSelf.lastId);
            for(NSInteger i = weakSelf.lastId; i< weakSelf.lastId + 10; i++){
                if( i < weakSelf.attention.data.count)
                    [weakSelf.allAttentionDatas addObject: weakSelf.attention.data[i]];
            }
            [NSThread sleepForTimeInterval:1.0f];
            weakSelf.lastId  = weakSelf.lastId + 10;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                if( weakSelf.lastId >=  weakSelf.attention.data.count){
                    [weakSelf.tableView endFooterRefreshWithNoMoreData];
                }else{
                    [weakSelf.tableView endFooterRefresh];
                }
            });
        });
    }];
    [self.tableView beginHeaderRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"%s",__func__);
    [UIView animateWithDuration:1.0 animations:^{
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
        [UIView animateWithDuration:5.0f animations:^{
            self.navigationController.navigationBar.alpha = 0;
        }];
    }];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//        NSLog(@"%s",__func__);
    [UIView animateWithDuration:1.0f animations:^{
        self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
        self.navigationController.navigationBar.alpha = 1.0;
    }];
}

#pragma mark -TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allAttentionDatas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionTableViewCell"];
    if(cell == nil){
        cell = [AttentionTableViewCell loadCell];
    }
    cell.data = self.allAttentionDatas[indexPath.row];
    cell.loadMoreCommentsBtn.tag = indexPath.row;
    [cell.loadMoreCommentsBtn addTarget:self action:@selector(loadMoreCommentsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void) loadMoreCommentsBtnClick:(UIButton *)b{
    LoadMoreCommentsController *vc = [[LoadMoreCommentsController alloc]init];
    vc.data = self.allAttentionDatas[b.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)allAttentionDatas {
	if(_allAttentionDatas == nil) {
		_allAttentionDatas = [[NSMutableArray alloc] init];
	}
	return _allAttentionDatas;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 460;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
