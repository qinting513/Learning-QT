//
//  TableViewController.m
//  Demo3_自定义Cell
//
//  Created by Qinting on 16/4/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TableViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "FooterView.h"
@interface TableViewController ()<FooterDelegate>
@property(nonatomic,strong)NSMutableArray *allNews;
@property(nonatomic,strong)UIRefreshControl *refresh;
@end

@implementation TableViewController

-(NSArray *)allNews {
    if(!_allNews) {
        _allNews = [[News demoData] mutableCopy];
    }
    return _allNews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupFooterAndHeaderView];
    
    [self setupRefresh];
}

-(void)setupFooterAndHeaderView{
    //设置表头视图
    //[[NSBundle mainBundle] 获取当前程序的文件夹
    //在当前文件夹下寻找 Header.xib文件，并通过该文件 加载Header视图， 最后将Header视图设置为tableview 的表头视图
    self.tableView.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"Header" owner:nil options:nil].lastObject;
    //设置表尾视图
    FooterView *footerView = [[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:nil options:nil].lastObject;
    //设置代理
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;

}
-(void)setupRefresh{
    //1. 创建 UIRefreshControl控件的实例
    self.refresh = [[UIRefreshControl alloc]init];
    //2. 将实例 赋值 给表视图控制器的 refreshControl 属性
    self.refreshControl = self.refresh;
    //3. 给 refresh 添加 valueChanged 事件的监听
    [self.refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];

}

-(void)refresh:(UIRefreshControl*)sender {
    //    开始刷新数据
    NSLog(@"开始刷新数据");
    //三秒钟以后执行  后 调用 加载数据方法  SEL
    NSDictionary *newDataDic = @{@"title":@"新的数据", @"newsImage":@"n1.png",@"commentCount":@"3000"};
    //创建新闻对象
    News *news = [[News alloc]init];
    //通过字典初始化对象中的各个属性  使用KVC
    [news setValuesForKeysWithDictionary:newDataDic];
    
    [self performSelector:@selector(refreshOver:) withObject:news afterDelay:3];
}
//加载完成  把 传入的数据 添加到tabelview
-(void)refreshOver:(News *)news {
    //在数组的 开始位置 插入新的数据
    [self.allNews insertObject:news atIndex:0];
    //更新界面
    [self.tableView reloadData];
    //修改 refreshContro ， 停止旋转
    [self.refresh endRefreshing];
}


//实现footerview的代理方法
-(void)loadData:(FooterView *)footer {
    NSLog(@"加载数据");
    
    //GCD 技术   线程技术
    //等待2秒钟后 执行 block代码块的内容
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //创建一个字典  字典中的可以和对象的属性名称相同
        NSDictionary *newDataDic = @{@"title":@"新的数据", @"newsImage":@"n1.png",@"commentCount":@"3000"};
        //创建新闻对象
        News *news = [[News alloc]init];
        //通过字典初始化对象中的各个属性  使用KVC
        [news setValuesForKeysWithDictionary:newDataDic];
        //将对象添加到数组中
        [self.allNews addObject:news];
        //刷新tableview
        [self.tableView reloadData];
        
        //通过footerView 隐藏view  显示button
        //通过委托方 做一些事情
        [footer didLoadNewsData];
    });
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allNews.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //通过 封装的工厂方法 创建Cell
    NewsCell *cell = [NewsCell cellForTableView:tableView];
    News *news = self.allNews[indexPath.row];
    //根据新闻数据对象 设置 Cell中的显示内容
    [cell setData:news];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
