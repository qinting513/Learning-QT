//
//  DiscoveryViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryUtils.h"
#import "Discovery.h"
#import "WorksStackView.h"
#import "RecommendBannerViewController.h"
#import "DiscoveryHeaderReusableView.h"
#import "DiscoveryUsersTableViewController.h"

@interface DiscoveryViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray *allDiscoveries;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *allUsers;
@property (nonatomic,assign) NSInteger  lastId;
@property (nonatomic,strong) UICollectionViewFlowLayout  *flowLayout;

@end

@implementation DiscoveryViewController

static NSString * const reuseIdentifier = @"DiscoveryViewController";
#pragma  mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日推荐";
    
    [self setupCollectionView];
}

-(void)setupCollectionView{
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"HeaderView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DiscoveryHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DiscoveryHeaderReusableView"];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self setupRefresh];
}

-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        NSString *url = @"http://chuye.cloud7.com.cn/dataflow/discovery?device=iOS&version=2.9.7&nettp=WIFI";
           [DiscoveryUtils GET:url completionHandler:^(Discovery* discovery, NSError *myError) {
               [weakSelf.allDiscoveries removeAllObjects];
               [weakSelf.allDiscoveries addObjectsFromArray:discovery.data.works];
               weakSelf.allUsers = discovery.data.users;
               [weakSelf.collectionView reloadData];
               [weakSelf.collectionView endHeaderRefresh];
           }];
    }];
    [self.collectionView addBackFooterRefresh:^{
        NSString *url = [NSString stringWithFormat:@"http://chuye.cloud7.com.cn/dataflow/discovery?device=iOS&version=2.9.7&nettp=WIFI&lastId=%ld",weakSelf.lastId];
        [DiscoveryUtils GET:url completionHandler:^(Discovery* discovery, NSError *myError) {
            /** 去除相同的元素  */
            NSArray *arr = discovery.data.works;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSMutableArray *mutableArr = [NSMutableArray array];
                BOOL flag = NO;
                for (int i = 0; i< arr.count; i++) {
                    DiscoveryDataWorks * b = arr[i];
                    for ( DiscoveryDataWorks * bb   in weakSelf.allDiscoveries) {
                        if(b.ID == bb.ID){
                            flag = YES;
                        }
                    }
                    if(!flag) {
                        [mutableArr addObject:b];
                    }
                    flag = NO;
                }
                [weakSelf.allDiscoveries addObjectsFromArray:mutableArr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.collectionView reloadData];
                    [weakSelf.collectionView endFooterRefresh];
                });
            });

        }];
    }];
    [self.collectionView beginHeaderRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if(!self.collectionView.mj_header){
//        NSLog(@"mj_header");
//     self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
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

#pragma mark -  <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allDiscoveries.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    WorksStackView  *stackView =  [cell.contentView viewWithTag:1000];
    if(stackView == nil){
        stackView = [WorksStackView loadXib];
        stackView.tag = 1000;
        [cell.contentView addSubview:stackView];
    }
    stackView.discoveryDataWorks = self.allDiscoveries[indexPath.item];
    [stackView.stackViewBtn addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchUpInside];
    self.lastId = stackView.discoveryDataWorks.ID;
    return cell;
}

/** 点击跳转 */
-(void)selectedItem:(UIButton *)btn{
    
    UICollectionViewCell *cell = ( UICollectionViewCell *)btn.superview.superview.superview;
    NSIndexPath* indexP = [self.collectionView indexPathForCell:cell];
    DiscoveryDataWorks  * discoveryDataWorks= self.allDiscoveries[indexP.item];
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
    vc.url = discoveryDataWorks.Url;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        DiscoveryHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DiscoveryHeaderReusableView" forIndexPath:indexPath];
        reusableview = headerView;
        headerView.users = self.allUsers;
        for (UIButton  *btn in headerView.allBtns) {
            [btn addTarget:self  action:@selector(clickImageBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    //    if (kind == UICollectionElementKindSectionFooter)
    //    {
    //        RecipeCollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    //
    //        reusableview = footerview;
    //    }
    
    reusableview.backgroundColor = [UIColor redColor];
    
    return reusableview;
}
/** 点击头像 跳转 */
-(void)clickImageBtn:(UIButton *)b{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DiscoveryUsersTableViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DiscoveryUsersTableViewController"];
    [self.navigationController pushViewController:vc  animated:YES];

}

#pragma mark - UICollectionViewDelegateFlowLayout
/** 每一个Item的Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(128, 180);
}
/** 上下左右的 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
/** 每一行的宽度 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
/** 每一列之间的宽度 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"collectionView--%ld",indexPath.item);
    
}

#pragma mark - 懒加载
- (NSMutableArray *)allDiscoveries {
	if(_allDiscoveries == nil) {
		_allDiscoveries = [[NSMutableArray alloc] init];
	}
	return _allDiscoveries;
}

- (UICollectionViewFlowLayout *)flowLayout {
	if(_flowLayout == nil) {
		_flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 130);
	}
	return _flowLayout;
}

@end
