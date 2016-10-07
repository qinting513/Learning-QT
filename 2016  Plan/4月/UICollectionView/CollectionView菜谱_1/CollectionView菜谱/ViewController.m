//
//  ViewController.m
//  CollectionView菜谱
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//
#import "DataUtils.h"
#import "ViewController.h"
#import "DishCell.h"
@interface ViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)NSArray *dishes;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *cv = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:fl];
    cv.delegate = self;
    cv.dataSource = self;
    [self.view addSubview:cv];
    self.dishes = [DataUtils paseDishes];
    [cv registerNib:[UINib nibWithNibName:@"DishCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    self.title = @"鱼的各种做法";
}
//   10*2+3*?+2*10 = 335

#pragma  mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dishes.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.dish = self.dishes[indexPath.row];
    
    
    return cell;
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(111, 111);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 10, 0, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    NSLog(@"%s",__func__);
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Dish *dish = self.dishes[indexPath.row];
    
    UIViewController *vc = [[UIViewController alloc]init];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:vc.view.bounds];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dish.albums]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [vc.view addSubview:imageView];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = dish.title;
    [self.navigationController pushViewController:vc animated:YES];

}
@end
