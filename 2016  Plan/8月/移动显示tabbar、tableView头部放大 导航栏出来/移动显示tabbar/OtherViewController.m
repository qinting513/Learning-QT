//
//  OtherViewController.m
//  移动显示tabbar
//
//  Created by _鑫宇↘無人懂會 on 16/3/15.
//  Copyright © 2016年 _鑫宇↘無人懂會. All rights reserved.
//



/** contentSize是UIScrollView可以滚动的区域。在我的理解中，我把UIScrollView看成是具有上下两层的一个复合视图，frame控制着上层的大小，我们看到的UIScrollView的大小实际就是frame的大小，上层固定不动，显示的变化，由下层的滚动来控制。而下层滚动的区域的大小，就是由contentSize来控制的了。例如：若frame = (0, 0, 320, 480) contentSize = (320, 960)，代表本UIScrollView可以上下滚动，滚动区域为frame大小的两倍。
 
 contentOffset是UIScrollView当前显示区域的顶点相对于frame顶点的偏移量，
 */

#import "OtherViewController.h"

#define KScreen_Width [UIScreen mainScreen].bounds.size.width
#define KScreen_Height [UIScreen mainScreen].bounds.size.height
static CGFloat const imageBGHeight = 200; // 背景图片的高度
static NSString * const identifier = @"cell"; // cell重用标识符

@interface OtherViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageBG;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation OtherViewController
#pragma mark - privateLazy
- (UIImageView *)imageBG {
    if (_imageBG == nil) {
        _imageBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BGimage.jpg"]];
        /** 设置x，y值，没变化，是因为一运行会调用scrollViewDidScroll 调整了高度*/
        _imageBG.frame = CGRectMake(60, 0, KScreen_Width, imageBGHeight);
        _imageBG.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageBG;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = [UIScreen mainScreen].bounds;
        _tableView.contentInset = UIEdgeInsetsMake(imageBGHeight, 0, 0, 0);
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text=@"title";
        _titleLabel.textColor = [UIColor blueColor];
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0;
    }
    return _titleLabel;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    [self setupTableView];
}

/**
 *    BasrVC push 到AVC，在AVC的self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
 *    但是要在BaseVC里设置self.navigationController.navigationBar.subviews.firstObject.alpha = 1; 奇怪！！
 *    滚动后，设置self.navigationController.navigationBar.subviews.firstObject.alpha = scrollView.contentOffset / 64; 使得向上滚动后alpha渐变为1
 */

- (void)setupNav {

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.titleView = self.titleLabel;
}

-(void)setupTableView {
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    [self.tableView addSubview:self.imageBG];
}

#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据--%zd", indexPath.row];
    return cell;
}

#pragma mark -  重点的地方在这里 滚动时候进行计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /** 往下滑动tableView，其实是contentSize往上移动，contentSize的左顶点
       跟tableView可见的左顶点的距离就越大，即contentOffset.y负增长 */
    CGFloat offsetY = scrollView.contentOffset.y;
        NSLog(@"%@ --- %.2lf",scrollView, scrollView.contentOffset.y);
 /** 其实最开始contentSize的左顶点跟tableView的左顶点都是屏幕UIScreen左顶点，
  只不过加了图片了，tableView的左顶点下移，加上图片的高度后，两个点又重合了
  如果下滑，则offsetH又负增长，表明是下滑*/
    CGFloat offsetH = imageBGHeight + offsetY;
    /** 刚开始没滑动时offsetH是 - 20，因为有状态栏，tableView会下移20个高度 */
    NSLog(@"hhh:%lf",offsetH);
    if (offsetH < 0) {
        CGRect frame = self.imageBG.frame;
/**  负负得正，图片高度变高，使得图片变大*/
        frame.size.height = imageBGHeight - offsetH;
        /**  y轴也要改变，是相对于tableView的左顶点，所以是负值 -imageBGHeight */
        frame.origin.y = -imageBGHeight + offsetH;
        /** 保持图片左顶点在屏幕左顶点 */
         frame.origin.x = 0;
        self.imageBG.frame = frame;
    }
    
    /** alpha 相对值,往上滚动tableView时，offsetH越来越大，大到大于1时就全显示了 */
    CGFloat alpha = offsetH / imageBGHeight;
//    NSLog(@"alpha: %lf",alpha);
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor redColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    self.titleLabel.alpha = alpha;
}

#pragma mark - 返回一张纯色图片
/** 返回一张纯色图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}
@end
