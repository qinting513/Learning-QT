//
//  CircleViewController.m
//  CollectionView布局
//
//  Created by Qinting on 16/7/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleLayout.h"
#import "ImageCell.h"

@interface CircleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray  *images;
@property (nonatomic,strong) UICollectionView  *collectionView;
@end

@implementation CircleViewController
static NSString * const cellID = @"circle";

- (NSMutableArray *)images {
    if( !_images) {
        _images = [NSMutableArray array] ;
        for(int i= 1 ; i<=12; i++)
        {
            [_images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return  _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CircleLayout *layout = [[CircleLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.3) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource  = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor= self.view.backgroundColor;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier: cellID];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
        cell.imageName = self.images[indexPath.item];
    return cell;
}

//点击某一个item 则删除它
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self.images removeObjectAtIndex:indexPath.item];
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
