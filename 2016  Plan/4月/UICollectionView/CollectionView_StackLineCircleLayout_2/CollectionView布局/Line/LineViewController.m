//
//  LineViewController.m
//  CollectionView布局
//
//  Created by Qinting on 16/7/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "LineViewController.h"
#import "LineLayout.h"
#import "ImageCell.h"

@interface LineViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) NSMutableArray  *images;
@property (nonatomic,strong) UICollectionView  *collectionView;
@end

@implementation LineViewController


static NSString *const ID = @"image";

- (NSMutableArray *)images {
    if( !_images) {
        _images = [NSMutableArray array] ;
        for (int i =1; i<=12;i++){
            [self.images addObject:[NSString stringWithFormat:@"%d" , i]];
        }
    }
    return  _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局
    LineLayout *layout = [[LineLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height*0.3 ) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.images.count ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName = self.images[indexPath.item % (self.images.count) ];
    return cell;
}

#pragma mark - delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//修改模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    //刷新
//    [self.collectionView reloadData];
    
    //直接删除cell
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
