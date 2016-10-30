//
//  HeadScaleViewController.m
//  TableView头部放大
//
//  Created by Qinting on 2016/10/31.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "HeadScaleViewController.h"
#import <HMObjcSugar/HMObjcSugar.h>
#import "UIImageView+WebCache.h"

#define  kHeadViewHeight 200

NSString *const cellID = @"cellID";

@interface HeadScaleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)     UIView          *headView;;
@property (nonatomic,strong)     UIView          *headImageView;
@property (nonatomic,strong)     UIView          *lineView;
@property (nonatomic,assign)     NSInteger       statueStyle;
@end

@implementation HeadScaleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.statueStyle = UIStatusBarStyleLightContent;
    [self setupTableView];
    [self setupHeadView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return self.statueStyle;
}

-(void)setupHeadView{
    
    /** 设置容器View */
   self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                self.view.hm_width, kHeadViewHeight)];
    self.headView.backgroundColor = [UIColor hm_colorWithHex:0xF8F8F8];
    [self.view addSubview: self.headView];
    /** 设置图片 */
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:self.headView.bounds];
    headImageView.backgroundColor = [UIColor hm_colorWithHex:0x000033];
    [self.headView addSubview:headImageView];
    _headImageView = headImageView;
    
    // 一定要设置这两个
    headImageView.contentMode = UIViewContentModeScaleAspectFill;
    headImageView.clipsToBounds = YES;
    NSURL *url = [NSURL URLWithString:@"http://imga1.pic21.com/bizhi/150331/09210/s11.jpg"];
    [headImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"5"]];
    
    /** 设置分割线 */
    CGFloat lineHeight = 1 / [UIScreen mainScreen].bounds.size.height;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                kHeadViewHeight - lineHeight, self.headView.hm_width, 1)];
    [self.headView addSubview: lineView];
    lineView.backgroundColor = [UIColor lightGrayColor];
    _lineView = lineView;
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    tableView.contentInset = UIEdgeInsetsMake(kHeadViewHeight, 0, 0, 0);
    //设置指示条
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentInset.top + scrollView.contentOffset.y;
    if (offset <= 0) {
    NSLog(@" 放大： %f",offset);
        _headView.hm_y = 0;
        _headView.hm_height = kHeadViewHeight - offset;
        _headImageView.alpha = 1;
    }else{
        // 整体移动
        _headView.hm_height = kHeadViewHeight;
       //往上移动到64 就不移动了
        CGFloat min = kHeadViewHeight - 64;
        _headView.hm_y = - MIN(min, offset);
        
        // 设置透明度
        CGFloat progress = 1 - (offset / min);
        _headImageView.alpha = progress;
        
        _statueStyle = (progress < 0.5) ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    // 设置图像高度
    _headImageView.hm_height = _headView.hm_height;
    // 设置分割线的位置
    _lineView.hm_y = _headView.hm_height - _lineView.hm_height;
    
}

@end
