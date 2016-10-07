//
//  UserDetailViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserInfo.h"
#import "MainTabBarController.h"
#import "UserInfoUtils.h"
#import "UserModel.h"
#import "Favorites.h"
#import "Transmit.h"
#import "HeaderView.h"
#import "TransmitTableViewCell.h"
#import "JoinInTableViewCell.h"
#import "WorksTableViewCell.h"
#import "RecommendBannerViewController.h"
#import "FavoritesViewController.h"
#import "EditProfileController.h"

#define kHeaderViewHeight 240
#define kCellHeight 140

@interface UserDetailViewController () <UITableViewDataSource,UITableViewDelegate>

/** 控件 */
@property (nonatomic,assign) NSInteger  lastId;
//@property (strong, nonatomic)  UIView *redView;
@property (nonatomic,strong) UIScrollView   *scrollView;
@property (nonatomic,strong) UITableView  *tableView;
@property (nonatomic,strong) HeaderView  *headerView;

/** 数据 */
@property (nonatomic,strong)   UserInfo *userInfo;

@property (nonatomic,strong) UserModel  *userModel;
@property (nonatomic,strong) Favorites  *favorites;
@property (nonatomic,strong) Transmit *transmit;
@property (nonatomic,assign) ShowType showType;
@end

@implementation UserDetailViewController

#pragma mark -  小幸运
- (void)viewDidLoad {
    [super viewDidLoad];
    [UserInfo sharedUserInfo].isUserDetailExist = YES;
    [self getData];
    [self setupScrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.navigationBar.hidden = YES;
    if ([UserInfo sharedUserInfo].registerName){
        self.headerView.nicknameLabel.text = [UserInfo sharedUserInfo].registerName;
    }
    else{
    self.headerView.nicknameLabel.text = self.userModel.data.Works.lastObject.User.nickname;
    }
    
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"/Documents/header.png"];
    UIImage *image =  [UIImage imageWithContentsOfFile:imagePath];
    if(image){
        self.headerView.headerPhotoImageView.image = image;
    }else{
       [self.headerView.headerPhotoImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.data.Works.lastObject.User.headPhoto]];
    }
    
}

#pragma mark - getData
-(void)getData{
        self.userModel =  [UserInfoUtils parseUserModel];
        self.favorites = [UserInfoUtils parseFavorites];
        self.transmit = [UserInfoUtils parseTransmit];
}
#pragma mark - setupHeaderView
-(void)setupScrollView{
    /** scrollView */
    self.scrollView = [[UIScrollView  alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100);
    [self.view addSubview:self.scrollView];
    
    /** headerView */
    [self setupHeaderView];
    
    /** 右上角按钮 */
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(kScreenW - 50,20 , 30, 30);
    [btn setImage:[UIImage imageNamed:@"more friends"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(logoutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    /** 设置tableView */
    CGRect tableViewFrame = CGRectMake(0, kHeaderViewHeight, self.view.frame.size.width, 9999);
    self.tableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
//    self.tableView.tableFooterView = [UIView new];
    [self.scrollView addSubview:self.tableView];
}

-(void)setupHeaderView{
    self.headerView = [[NSBundle  mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil].lastObject;
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, kHeaderViewHeight);
   self.headerView.nicknameLabel.text = self.userModel.data.Works.lastObject.User.nickname;
    [self.headerView.worksBtn setTitle:[NSString stringWithFormat:@"%ld 作品",self.userModel.data.Works.count] forState:UIControlStateNormal];
    [self.headerView.sketchBtn setTitle:[NSString stringWithFormat:@"%d 草稿",0] forState:UIControlStateNormal];
    [self.headerView.transmitBtn setTitle:[NSString stringWithFormat:@"%ld 转发",self.transmit.data.count] forState:UIControlStateNormal];
    [self.headerView.favoritesBtn setTitle:[NSString stringWithFormat:@"%ld 收藏",self.favorites.data.count] forState:UIControlStateNormal];
    [self.headerView.favoritesBtn addTarget:self action:@selector(gotoFavoritesVC) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.editProfileBtn addTarget:self action:@selector(editProfileBtnClick) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self)  weakSelf = self;
    self.headerView.showTypeBtnsClickAtIndex = ^(NSInteger index){
        weakSelf.showType = index;
        [weakSelf.tableView reloadData];
    };
    [self.scrollView addSubview:self.headerView];
}

-(void)editProfileBtnClick{
    self.navigationController.navigationBar.hidden = NO;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditProfileController *vc = [sb instantiateViewControllerWithIdentifier:@"EditProfileController"];
    vc.userModel = self.userModel;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoFavoritesVC{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoritesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FavoritesViewController"];
    vc.favorites = self.favorites;
//    [self presentViewController:vc animated:YES completion:nil];
}



//退出登录
- (void)logoutButtonClick:(id)sender {
    NSString *userName = [UserInfo sharedUserInfo].userName;
    NSDictionary *info = [UserInfo loadUserInfoFromSandBoxWithName:userName];
    NSString *pwd = info[kPassword];
    if(userName.length != 0 && pwd.length != 0){
        NSDictionary *userInfo = @{userName : userName, kPassword:pwd,kIsLogin:@"NO"};
        [UserInfo saveToSandBoxWithUserInfo:userInfo andUserName:userName];
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTabBarController *mainVC = [sb instantiateInitialViewController];
    mainVC.selectedIndex = 0;
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.showType == ShowTypeWorks) {
              self.scrollView.contentSize = CGSizeMake(kScreenW, kHeaderViewHeight + self.userModel.data.Works.count * kCellHeight + 50);
      return self.userModel.data.Works.count;
    }
    if(self.showType ==  ShowTypeSketch)
    {
          self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100);
        return 0;
    }
    if(self.showType ==  ShowTypeTransmit) {
              self.scrollView.contentSize = CGSizeMake(kScreenW, kHeaderViewHeight +self.transmit.data.count * kCellHeight + 50 );
        return self.transmit.data.count;
    }
    if(self.showType == ShowTypeJoin){
               self.scrollView.contentSize = CGSizeMake(kScreenW, kHeaderViewHeight +self.favorites.data.count * kCellHeight+ 50);
        return self.favorites.data.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(self.showType == ShowTypeWorks) {
        WorksTableViewCell *cell = [self createCellWithTableView:tableView cellType:@"WorksTableViewCell"];
        cell.works = self.userModel.data.Works[indexPath.row];
        return cell;
    }
    if(self.showType ==  ShowTypeSketch){
        static NSString *cellID = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = @(indexPath.row).stringValue;
        return cell;
    }
    if(self.showType ==  ShowTypeTransmit) {
        TransmitTableViewCell *cell = [self createCellWithTableView:tableView cellType:@"TransmitTableViewCell"];
        cell.transmitData = self.transmit.data[indexPath.row];
        return cell;
    }
    if(self.showType == ShowTypeJoin) {
        JoinInTableViewCell *cell = [self createCellWithTableView:tableView cellType:@"JoinInTableViewCell"];
        cell.favoritesData = self.favorites.data[indexPath.row];
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
    return 140;
}

#pragma  mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"%ld --- %ld",indexPath.row,self.showType);
    NSString *url = nil;
    if(self.showType == ShowTypeWorks) {
           UserModelDataWorks *w = self.userModel.data.Works[indexPath.row];
        url = w.Uri;
    }
    if(self.showType ==  ShowTypeSketch)
    {
        
    }
    if(self.showType ==  ShowTypeTransmit) {
    TransmitData *d = self.transmit.data[indexPath.row];
        url = d.Uri;
    }
    if(self.showType == ShowTypeJoin){
         FavoritesData *d =  self.favorites.data[indexPath.row];
        url = d.Uri;
    }
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
    vc.url = url;
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)dealloc{
    [UserInfo sharedUserInfo].isUserDetailExist = NO;
}

@end
