//
//  StackViewController.m
//  CollectionView布局
//
//  Created by Qinting on 16/7/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "StackViewController.h"
#import "StackLayout.h"
#import "ImageCell.h"

@interface StackViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray  *images;
@property (nonatomic,strong) UICollectionView  *collectionView;

@property (weak, nonatomic) IBOutlet UIView *stackView;

@end

@implementation StackViewController

static NSString *const cellID = @"image";

- (NSMutableArray *)images {
    if( !_images) {
        _images = [NSMutableArray array] ;
        for(int i = 1; i<= 12; i++){
            [_images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return  _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // 创建布局
    StackLayout *layout = [[StackLayout alloc]init];
      // 创建collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width ,200) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
//    注意把collcetionView背景色设置为没有，才显示Label
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:cellID];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imageName =  self.images[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除图片名
    [self.images removeObjectAtIndex:indexPath.item];
    
    // 刷新数据
    //    [self.collectionView reloadData];
    
    // 直接将cell删除
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}



@end
