//
//  RecommendTableViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//


#import "RecommendTableViewController.h"
#import "ZLScrolling.h"
#import "RecommendUtils.h"
#import "Recommend.h"
#import "RecommendBannerViewController.h"
#import "TopicView.h"
#import "WorksCell.h"
#import "AlbumCell.h"
#import "AlbumHeaderView.h"
#import "WorksViewController.h"
#import "MoreTopicsTableViewController.h"

@interface RecommendTableViewController ()<ZLScrollingDelegate>

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,strong)    Recommend *recommend ;
@property (nonatomic,assign) CGFloat  firstRowHeight;
@property (nonatomic,assign)  NSInteger  lastID;
@property (nonatomic,strong) NSMutableArray  *allAlbums;
@end

@implementation RecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionFooterHeight = 1;
    [self setupRefresh];
}

-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
 [self.tableView addHeaderRefresh:^{
     /** 初始化所有数值 */
     weakSelf.recommend =  [RecommendUtils parseRecomend];
     [weakSelf.allAlbums addObjectsFromArray:weakSelf.recommend.data.album];
     [weakSelf setupHeaderView];
     [weakSelf.tableView endHeaderRefresh];
     [weakSelf.tableView reloadData];
 }];
    [self.tableView addBackFooterRefresh:^{
        NSString * url = [NSString stringWithFormat:@"http://chuye.cloud7.com.cn/WorkAlbum?device=iOS&version=2.9.7&nettp=WIFI&lastId=%ld",weakSelf.lastID];
          [RecommendUtils GET:url completionHandler:^(NSArray *arr, NSError *error) {
              /** 去除相同的元素  */
              dispatch_async(dispatch_get_global_queue(0, 0), ^{
                  NSMutableArray *mutableArr = [NSMutableArray array];
                  BOOL flag = NO;
                  for (int i = 0; i< arr.count; i++) {
                      RecommendDataAlbum * b = arr[i];
                      for ( RecommendDataAlbum * bb   in weakSelf.allAlbums) {
                          if(b.Id == bb.Id){
                              flag = YES;
                          }
                      }
                      if(!flag) {
                          [mutableArr addObject:b];
                      }
                         flag = NO;
                  }
                   [weakSelf.allAlbums addObjectsFromArray:mutableArr];
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [weakSelf.tableView reloadData];
                          [weakSelf.tableView endFooterRefresh];
                      });
              });
      
            }];
    }];
    [self.tableView beginHeaderRefresh];
}

-(void)setupHeaderView{

    /** 加载网络图片进行轮播 ，需设置播放时间和代理，遵守协议实现代理方法*/
    RecommendDataBanners * banner = self.recommend.data.banners[0];
//    NSLog(@"%@",banner.Thumbnail);
    NSArray *url = @[banner.Thumbnail,banner.Thumbnail];
    NSMutableArray *urlarr = [NSMutableArray array];
    for (NSString *str in url) {
        NSURL *imurl = [NSURL URLWithString:str];
        [urlarr addObject:imurl];
    }
    UIImage *placeholder = [UIImage imageNamed:@"work_pic"];
    ZLScrolling *zl = [[ZLScrolling alloc] initWithCurrentController:self frame:CGRectMake(0, 0, self.view.frame.size.width, 120) photos:urlarr placeholderImage:placeholder];
    zl.timeInterval = 3;
//    zl.pageControl.pageIndicatorTintColor = [UIColor redColor];
    zl.delegate= self;
    
    /** 顶部按钮 */
    TopicView *topicView = [TopicView loadXib];
    topicView.frame = CGRectMake(0, 120, self.headerView.bounds.size.width, 120);
    topicView.topics = self.recommend.data.topic;
    topicView.clickBtnBlock = ^(NSInteger index){
//        NSLog(@"%ld",index);
    };
    topicView.clickMoreBtnBlock = ^(){
        MoreTopicsTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreTopicsTableViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.headerView addSubview:topicView];
    
}

-(void)zlScrolling:(ZLScrolling *)zlScrolling clickAtIndex:(NSInteger)index{
    RecommendDataBanners * banner = self.recommend.data.banners[0];
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
    vc.url = banner.Url;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 1;
    return self.allAlbums.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        WorksCell *workCell = [WorksCell createCellWithTableView:tableView indexPath:indexPath];
        workCell.cellHeight = ^(CGFloat cellHeight){
            self.firstRowHeight = cellHeight;
            [self.tableView setNeedsLayout];
        };
        workCell.clickTopic = ^(NSString *url){
            RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
            vc.url = url;
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        };
           workCell.works = self.recommend.data.works;
        return workCell;
    }
    
    AlbumCell * cell = [AlbumCell createCellWithTableView:tableView indexPath:indexPath];
    cell.album = self.allAlbums[indexPath.row];
    self.lastID = cell.album.Id;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) return self.firstRowHeight;
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AlbumHeaderView * view = [[[NSBundle mainBundle]loadNibNamed:@"AlbumHeaderView" owner:nil options:nil]lastObject];
    if(section == 0){
    view.label.text = @"每日推荐";
        [view.moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
    view.label.text = @"精彩合辑";
        view.moreButton.hidden = YES;
    }
    return view;
}
/** 每日推荐 点击更多按钮 */
-(void)moreButtonClick:(UIButton*)btn{
    WorksViewController *topicVC = [[WorksViewController alloc]init];
    [self.navigationController pushViewController:topicVC animated:YES];
}

- (NSMutableArray *)allAlbums {
	if(_allAlbums == nil) {
		_allAlbums = [[NSMutableArray alloc] init];
	}
	return _allAlbums;
}

@end
