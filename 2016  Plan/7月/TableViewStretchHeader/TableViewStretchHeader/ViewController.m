//
//  ViewController.m
//  TableViewStretchHeader
//
//  Created by Qinting on 16/7/13.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#define StretchHeaderHeight 200

#import "ViewController.h"
#import "QTStretchableTableHeaderView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) QTStretchableTableHeaderView *strectchTableHeaderView;
@end

@implementation ViewController



- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
          _tableView.delegate = self;
          _tableView.dataSource = self;
          _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView  = [UIView new];
//        _tableView.separatorColor = [UIColor redColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
           self.tableView.separatorInset = UIEdgeInsetsZero;
        [self.view addSubview:  _tableView];
    }
    return   _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"我的";
    
    /** 注意一定要关掉系统自动调整，要不然往上推时，头部视图缩小 */
    self.automaticallyAdjustsScrollViewInsets = NO;
   
    [self initStretchHeader];
}



- (void)initStretchHeader
{
    //设置背景图片
    UIImageView *bgImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, StretchHeaderHeight)];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo" ofType:@"png"]];
//    bgImageView.image = [UIImage imageNamed:@"photo"];

    //添加一个容器View到头部
    UIView *contentView = [[UIView alloc]initWithFrame:bgImageView.bounds];
    contentView.backgroundColor = [UIColor clearColor];
    
    UIImageView *avater = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
    avater.image = [UIImage imageNamed:@"avater"];
    avater.center = contentView.center;
    [contentView addSubview: avater];
    
    self.strectchTableHeaderView = [QTStretchableTableHeaderView new];
    [self.strectchTableHeaderView stretchHeaderForTableView:self.tableView withView:bgImageView subView:contentView];
}

#pragma mark - stretchableTable delegate
//必须调用的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.strectchTableHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self.strectchTableHeaderView resizeView];
}

#pragma mark - table delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }




@end
