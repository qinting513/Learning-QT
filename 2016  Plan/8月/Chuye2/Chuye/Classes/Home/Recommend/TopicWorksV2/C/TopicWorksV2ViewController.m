//
//  TopicWorksV2ViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TopicWorksV2ViewController.h"
#import "TopicWorksV2.h"
#import "TopicWorksV2Cell.h"
#import "TopicWorksV2ReusableView.h"
#import "RecommendBannerViewController.h"

#define kHeaderViewH 200

@interface TopicWorksV2ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView  *collectionView;
@property (nonatomic,strong) NSMutableArray  *allWorks;
@property (nonatomic,strong)  TopicWorksV2 *works ;
@property (nonatomic,assign) NSInteger lastId;
@property (nonatomic,assign) NSInteger selectedSegmentIndex;
@property (nonatomic,strong) UIButton  *redBtn;
@end

@implementation TopicWorksV2ViewController
static NSString * const reuseIdentifier = @"TopicWorksV2Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"初页主题";
    [self setupCollectionView];
    self.selectedSegmentIndex = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor darkGrayColor];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.headerReferenceSize = CGSizeMake(kScreenW, kHeaderViewH);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -20, kScreenW, kScreenH) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TopicWorksV2Cell" bundle:nil] forCellWithReuseIdentifier:@"TopicWorksV2Cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TopicWorksV2ReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TopicWorksV2ReusableView"];
    [self.view addSubview: self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UIButton *redBtn = [UIButton buttonWithType:0];
    redBtn.backgroundColor = [UIColor redColor];
    [redBtn setTitle:@"点击重试" forState:UIControlStateNormal];
    [redBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.collectionView addSubview:redBtn];
    redBtn.frame =  CGRectMake( (kScreenW - 100) / 2.0, self.collectionView.frame.size.height/2.0 - 20, 100, 40);
    [redBtn addTarget:self action:@selector(tryLoadAgain:) forControlEvents:UIControlEventTouchUpInside];
    redBtn.hidden = YES;
    self.redBtn = redBtn;

    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(10, 20, 30, 30);
    [btn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
//    加载数据
       [self setupRefresh];
}

-(void)comeBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tryLoadAgain:(UIButton*)b{
    
    [self.collectionView  showBusyHUD];
    b.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView hideBusyHUD];
        b.hidden = NO;
    });
}

-(void)setupRefresh{
    __weak typeof(self) weakSelf = self;
    [self.collectionView addHeaderRefresh:^{
            NSOperationQueue *queue = [[NSOperationQueue alloc]init];
            [queue addOperationWithBlock:^{
                weakSelf.works = [TopicWorksV2 parseTopicWorksV2];
//                [NSThread sleepForTimeInterval:1.0f];
                [weakSelf.allWorks removeAllObjects];
                for(NSInteger  i = 0; i< 18; i++){
                    [weakSelf.allWorks insertObject:weakSelf.works.data.list[i] atIndex:i];
                    weakSelf.lastId = 18;
                }
//                [weakSelf.allWorks addObjectsFromArray:works.data.list];
               
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [weakSelf.collectionView reloadData];
                    [weakSelf.collectionView endHeaderRefresh];
                }];
                
            }];

    }];
    
    [self.collectionView addBackFooterRefresh:^{
        if(weakSelf.selectedSegmentIndex == 1)
        {
               [weakSelf.collectionView endFooterRefreshWithNoMoreData];
              return ;
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"la:%ld",weakSelf.lastId);
                for(NSInteger i = weakSelf.lastId; i< weakSelf.lastId + 30; i++){
                    if( i < weakSelf.works.data.list.count)
                        [weakSelf.allWorks addObject:weakSelf.works.data.list[i]];
                }
                [NSThread sleepForTimeInterval:1.0f];
                weakSelf.lastId  = weakSelf.lastId + 30;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.collectionView reloadData];
                    if( weakSelf.lastId >= weakSelf.works.data.list.count){
                        [weakSelf.collectionView endFooterRefreshWithNoMoreData];
                    }else{
                        [weakSelf.collectionView endFooterRefresh];
                    }
                });
            });
    }];
    [self.collectionView beginHeaderRefresh];
}
#pragma mark -  <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.selectedSegmentIndex == 1) return  0;
    return self.allWorks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TopicWorksV2Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.list = self.allWorks[indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        TopicWorksV2ReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TopicWorksV2ReusableView" forIndexPath:indexPath];
        headerView.segment.selectedSegmentIndex = self.selectedSegmentIndex;
        [headerView.segment addTarget:self action:@selector(selectedAtIndex:) forControlEvents:UIControlEventValueChanged];
        headerView.data = self.data;
        reusableview = headerView;
    }
//    reusableview.backgroundColor = [UIColor redColor];
    return reusableview;
}

-(void)selectedAtIndex:(UISegmentedControl*)control{
//    NSLog(@"----%ld",control.selectedSegmentIndex);
    self.selectedSegmentIndex = control.selectedSegmentIndex;
    self.redBtn.hidden = (control.selectedSegmentIndex == 0);
    [self.collectionView reloadData];
}

- (NSMutableArray *)allWorks {
	if(_allWorks == nil) {
		_allWorks = [[NSMutableArray alloc] init];
	}
	return _allWorks;
}

#pragma mark - UICollectionViewDelegateFlowLayout
/** 每一个Item的Size */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(128, 200);
}
/** 上下左右的 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
/** 每一行的宽度 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
/** 每一列之间的宽度 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
    vc.url = [self.allWorks[indexPath.row] Uri];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
