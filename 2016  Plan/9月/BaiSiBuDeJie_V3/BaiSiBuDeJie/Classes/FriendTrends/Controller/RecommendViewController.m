//
//  RecommendViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

//#import <AFNetworking.h>
#import "RecommendViewController.h"
#import "RecommendCategoriesParam.h"
#import "RecommendTool.h"
#import "RecommendCategory.h"
#import "RecommendUsersParam.h"
#import "RecommendUsersCell.h"
#import "RecommendCategoryCell.h"

#define SelectedCategory  self.categoryArray[ [self.categoryTableView indexPathForSelectedRow].row ]

@interface RecommendViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 分类的数组 */
@property (nonatomic,strong) NSArray *categoryArray;

/**  */
@property (nonatomic,strong) RecommendUsersParam *lastParam;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = GlobalColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//    self.categoryTableView.tableFooterView = [UIView new];
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 64;
    [self loadCategory];
    [self setupRefresh];
    
}

-(void)loadCategory{
    
    /**   method 1:
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     parameters[@"a"] = @"category";
     parameters[@"c"] = @"subscribe";
     
     [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
     MYLog(@"progress:%@",downloadProgress);
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     MYLog(@"response:%@",responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     MYLog(@"error:%@",error);
     }];
     */
    [SVProgressHUD show];
    
    /** method2: */
    RecommendCategoriesParam *param = [[RecommendCategoriesParam alloc]init];
    param.a = @"category";
    param.c = @"subscribe";
    [RecommendTool  recommendCategoryWithParam:param success:^(RecommendCategoriesResult *result) {
//        MYLog(@"category result: %@",result);
        
        /** 已经转好为模型类 */
        self.categoryArray = result.list;
      //记得刷新才有数据显示出来
        [self.categoryTableView reloadData];
        
        /** 左边有数据后 加载右边的 */
        /** 选中首行 */
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                                               animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"category 加载失败:%@",error);
        [SVProgressHUD dismiss];
    }];
}

- (void)setupRefresh{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];

    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = NO;
}

/** 首次获取新数据 */
- (void)loadNewUsers{
    /** 从categoryTableView的选择的那个cell获取哪个分类，从而确定id */
    RecommendCategory *category = SelectedCategory;
    NSNumber *lastPage = category.page;
    
    RecommendUsersParam *param = [[RecommendUsersParam alloc]init];
    param.a = @"list";
    param.c = @"subscribe";
    param.category_id = category.id;
    
    /** param为第一次请求的参数，如果第一次请求后会把参数赋给self.lastParam  */
    self.lastParam = param;
    
    [RecommendTool recommendUsersWithParam:param success:^(RecommendUsersResult *result) {
        
        category.page = param.page;
        category.total = result.total;
        /** 先移除 再添加 */
        [category.users removeAllObjects];
        [category.users addObjectsFromArray:result.list];

        //如果不是第一次请求，则存储后 不刷新
        if (self.lastParam != param) {
            return;
        }
        
        [self.userTableView reloadData];
        /** 获取到数据 停止刷新 */
        [self.userTableView.mj_header endRefreshing];
        /** 如果users的数量跟总数一致则说明加载完毕 */
        if (category.users.count >= category.total ){
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        MYLog(@"userTableView 加载数据失败：%@",error);
        if (param != self.lastParam) return;
        
        [self.userTableView.mj_header endRefreshing];
        category.page = lastPage;
    }];
}

/** 获取更多数据 */
- (void)loadMoreUsers{
    
    /** 从categoryTableView的选择的那个cell获取哪个分类，从而确定id */
    RecommendCategory *category = SelectedCategory;
    NSNumber *lastPage = category.page;
    
    RecommendUsersParam *param = [[RecommendUsersParam alloc]init];
    param.a = @"list";
    param.c = @"subscribe";
    param.page = @([lastPage intValue] + 1);
    param.category_id = category.id;
    
    /** param为第一次请求的参数，如果第一次请求后会把参数赋给self.lastParam  */
    self.lastParam = param;
    
    [RecommendTool recommendUsersWithParam:param success:^(RecommendUsersResult *result) {
        
        category.page = param.page;
        category.total = result.total;
        /**  加载更多，是直接添加 */
        [category.users addObjectsFromArray:result.list];
        
        //如果不是第一次请求，则存储后 不刷新
        if (self.lastParam != param) {
            return;
        }
        
        [self.userTableView reloadData];
        /** 获取到数据 停止刷新 */
        
        if (category.users.count >=  category.total ){
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        MYLog(@"userTableView 加载数据失败：%@",error);
        if (param != self.lastParam) return;
        
        [self.userTableView.mj_footer endRefreshing];
        category.page = lastPage;
    }];
}

#pragma mark - tableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
              return self.categoryArray.count;
    }
        RecommendCategory *category  = SelectedCategory;
        return category.users.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        RecommendCategoryCell *cell = (RecommendCategoryCell *)[RecommendCategoryCell cellWithTableView:tableView];
         cell.category  = self.categoryArray[indexPath.row];
        
           return cell;
    }else {
        RecommendUsersCell *cell = (RecommendUsersCell *)[RecommendUsersCell cellWithTableView:tableView];
        cell.userList = [SelectedCategory users][indexPath.row];
       return cell;
    }
    
}

#pragma  mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.userTableView) {
        [self.userTableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    if(tableView == self.categoryTableView){
        self.lastParam  = nil;
        [self.userTableView.mj_header endRefreshing];
        
        RecommendCategory *rc = self.categoryArray[indexPath.row];
        //如果总数等于用户数量了 则停止刷新，并通知没有更多数据
        if (rc.total && rc.users.count >= rc.total ) {
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        
        //刷新数据
        if (rc.users.count) {
            //已经有过，直接显示
            [self.userTableView reloadData];
        }else{
            [self.userTableView reloadData];
            /** 头部有显示下啦加载 */
            [self.userTableView.mj_header beginRefreshing];
        }
        
    }
    
   
}

- (void)dealloc
{
    self.lastParam = nil;
    [SVProgressHUD dismiss];
}

@end
