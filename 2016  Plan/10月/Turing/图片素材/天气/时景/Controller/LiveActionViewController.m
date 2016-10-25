//
//  LiveActionViewController.m
//  天气预报
//
//  Created by tarena22 on 16/9/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LiveActionViewController.h"
#import "LiveActionViewCell.h"
#import "LiveHeaderView.h"
@interface LiveActionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray* bgImageName;
@property(nonatomic,strong)NSArray *addressName;
@end

@implementation LiveActionViewController
static NSString * const reuseIdentifier = @"Cell";
-(NSMutableArray *)bgImageName
{
    if(_bgImageName==nil)
    {
        _bgImageName = [NSMutableArray array];
        for(int i=0;i<33;i++)
        {
            NSString*bgName =[NSString stringWithFormat:@"IMG_0%d.jpg",150+i];
            [_bgImageName addObject:bgName];
        }
    
    }
    return _bgImageName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];
    
    self.addressName =@[@"北京市昌平区",@"天津市",@"广州番禺区",@"湛江霞山区",@"修水县凤凰山路",@"安徽省铜陵市",@"深圳市龙岗区",@"巴彦县人民大街",@"纽约市昆斯",@"凤凰县江南东路",@"拉斯维加斯",@"北京市昌平区",@"天津市",@"广州番禺区",@"湛江霞山区",@"修水县凤凰山路",@"安徽省铜陵市",@"深圳市龙岗区",@"巴彦县人民大街",@"纽约市昆斯",@"凤凰县江南东路",@"拉斯维加斯",@"北京市昌平区",@"天津市",@"广州番禺区",@"湛江霞山区",@"修水县凤凰山路",@"安徽省铜陵市",@"深圳市龙岗区",@"巴彦县人民大街",@"纽约市昆斯",@"凤凰县江南东路",@"拉斯维加斯"];
    
     UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:fl];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor =[UIColor lightGrayColor];
     [self.collectionView registerNib:[UINib nibWithNibName:@"LiveActionViewCell" bundle:[NSBundle mainBundle]]
           forCellWithReuseIdentifier:reuseIdentifier];
    
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(190, 152);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 30);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.bgImageName.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     LiveActionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString* bgImagename = self.bgImageName[indexPath.row];
    cell.backGIV.image =[UIImage imageNamed:bgImagename];
    cell.addressLabel.text =self.addressName[indexPath.row];
    
    
    return cell;
}
//-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    
//    CGSize size = {[UIScreen mainScreen].bounds.size.width, 200};
//    return size;
//    
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    // 注册表头
//    [collectionView registerClass:[LiveHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    
//    // 初始化表头
//    
//    
//    return nil;
//}
-(void)searchAction
{
    
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
