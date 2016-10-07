//
//  FriendViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendHeaderView.h"

#import "TransmitTableViewCell.h"
#import "JoinInTableViewCell.h"
#import "WorksTableViewCell.h"

#import "RecommendBannerViewController.h"

#define kHeaderViewHeight 260
#define kCellHeight 140

@interface FriendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) FriendHeaderView  *headerView;
@property (nonatomic,strong) UIScrollView   *scrollView;
@property (nonatomic,strong) UITableView  *tableView;
@property (nonatomic,assign) FriendShowType showType;
@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** headerView */
    [self setupHeaderView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.hidesBarsOnSwipe = NO;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setupHeaderView{
    /** scrollView */
    self.scrollView = [[UIScrollView  alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100);
    [self.view addSubview:self.scrollView];
    
    self.headerView = [[NSBundle  mainBundle] loadNibNamed:@"FriendHeaderView" owner:nil options:nil].lastObject;
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, kHeaderViewHeight);
    if(self.isFromDiscovery){
        self.headerView.userData = self.userData;
    }else{
//   不是从发现那里传来的
        self.headerView.data = self.data;
    }
    __weak typeof(self)  weakSelf = self;
    self.headerView.friendShowTypeBtnsClickAtIndex = ^(NSInteger index){
        weakSelf.showType = index;
        [weakSelf.tableView reloadData];
    };
    [self.scrollView addSubview:self.headerView];
    
    /** 右上角按钮 */
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(kScreenW - 50,20 , 30, 30);
    [btn setImage:[UIImage imageNamed:@"more friends"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(popButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    /** 设置tableView */
    CGRect tableViewFrame = CGRectMake(0, kHeaderViewHeight, self.view.frame.size.width, 3999);
    self.tableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.scrollView addSubview:self.tableView];
}

-(void)popButtonClick:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
  
    if(self.showType == FriendShowTypeWorks) {
          self.tableView.hidden = NO;
        if(self.isFromDiscovery){
            self.scrollView.contentSize = CGSizeMake(kScreenW, kHeaderViewHeight + self.userData.Works.count * kCellHeight + 50);
            return self.userData.Works.count;
        }
        
      self.scrollView.contentSize = CGSizeMake(kScreenW, kHeaderViewHeight + self.data.Works.count * kCellHeight + 50);
        return self.data.Works.count;
    }
    
    self.tableView.hidden = YES;
    if(self.showType ==  FriendShowTypeTransmit) {
        return 0;
    }
    if(self.showType == FriendShowTypeJoin){
        return 0;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.showType == FriendShowTypeWorks) {
        WorksTableViewCell *cell = [self createCellWithTableView:tableView cellType:@"WorksTableViewCell"];
        if(self.isFromDiscovery){
            cell.userDataWorks = self.userData.Works[indexPath.row];
            return cell;
        }
        
        cell.data = self.data.Works[indexPath.row];
        return cell;
    }

    if(self.showType ==  FriendShowTypeTransmit) {
        TransmitTableViewCell *cell = [self createCellWithTableView:tableView cellType:@"TransmitTableViewCell"];
//        cell.transmitData = self.data.Works[indexPath.row];
        return cell;
    }
    if(self.showType == FriendShowTypeJoin) {
        JoinInTableViewCell *cell = [self createCellWithTableView:tableView cellType:@"JoinInTableViewCell"];
//        cell.favoritesData = self.data.Works[indexPath.row];
        return cell;
    }
    
    return nil;
}

-(id)createCellWithTableView:(UITableView *)tableView cellType:(NSString*)typeName{
    Class class = NSClassFromString(typeName);
    id obj = [tableView dequeueReusableCellWithIdentifier:typeName ];
    if(obj == nil){
        obj = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(class) owner:nil options:nil].lastObject;
    }
    return obj;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
    AddFriendDataWorks *work = self.data.Works[indexPath.row];
    vc.url = work.Uri;
    [self presentViewController:vc  animated:YES completion:nil];
}

-(void)dealloc{
    self.isFromDiscovery = NO;
}

@end
