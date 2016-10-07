//
//  FavoritesViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//
#define TAG 99
#import "FavoritesViewController.h"
#import "FavoritesCell.h"
#import "MainTabBarController.h"
#import "RecommendBannerViewController.h"

@interface FavoritesViewController ()<UICollectionViewDataSource>

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(10, 20, 30, 30);
    [btn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(comeBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)comeBack{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainTabBarController *mainVC = [sb instantiateInitialViewController];
    mainVC.selectedIndex = 0;
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  self.favorites.data.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavoritesCell *cell = (FavoritesCell  *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FavoritesCell" forIndexPath:indexPath];
    FavoritesData *d = self.favorites.data[indexPath.section];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:d.Thumbnail]
                            placeholderImage:[UIImage imageNamed:@"work_pic"]];
    cell.headerImageView.tag =  indexPath.section;
    cell.nicknameLabel.text = d.User.nickname;
    [cell.pageButton setTitle:[NSString stringWithFormat:@"%ld/%ld",indexPath.section+1,self.favorites.data.count] forState:UIControlStateNormal];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendBannerViewController *vc = [[RecommendBannerViewController alloc]init];
        FavoritesData *d = self.favorites.data[indexPath.section];
    vc.url = d.Uri;
    [self presentViewController:vc animated:YES completion:nil];
}



@end
