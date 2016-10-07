//
//  TopicsViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "WorksViewController.h"
#import "WorksStackView.h"
#import "RecommendUtils.h"
#import "Works.h"
#import "RecommendBannerViewController.h"

@interface WorksViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray *allTopics;
@property (nonatomic,strong)     Works * works;
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation WorksViewController
static NSString * const reuseIdentifier = @"WorksViewController";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日推荐";
    
    [self setupCollectionView];
}

-(void)setupCollectionView{
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:fl];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
     [self setupRefresh];
}

-(void)setupRefresh{

    __weak typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                weakSelf.works = [RecommendUtils parseWorks];
            [weakSelf.allTopics addObjectsFromArray:weakSelf.works.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView endHeaderRefresh];
            });
        });
    
    }];
    [self.collectionView addBackFooterRefresh:^{
        [weakSelf.allTopics addObjectsFromArray:weakSelf.works.data];
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView endFooterRefresh];
    }];
    [self.collectionView beginHeaderRefresh];
}

#pragma mark -  <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allTopics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   
    WorksStackView  *stackView =  [cell.contentView viewWithTag:1000];
    if(stackView == nil){
        stackView = [WorksStackView loadXib];
        stackView.tag = 1000;
        [cell.contentView addSubview:stackView];
    }
    stackView.worksData = self.allTopics[indexPath.item];
    [stackView.stackViewBtn addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

/** 点击跳转 */
-(void)selectedItem:(UIButton *)btn{

    UICollectionViewCell *cell = ( UICollectionViewCell *)btn.superview.superview.superview;
   NSIndexPath* indexP = [self.collectionView indexPathForCell:cell];
    WorksData  * worksData= self.allTopics[indexP.item];
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
    vc.url = worksData.Uri;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
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
    
    NSLog(@"--%ld",indexPath.item);
    
}

#pragma mark - 懒加载
- (NSMutableArray *)allTopics {
	if(_allTopics == nil) {
		_allTopics = [[NSMutableArray alloc] init];
	}
	return _allTopics;
}

@end
