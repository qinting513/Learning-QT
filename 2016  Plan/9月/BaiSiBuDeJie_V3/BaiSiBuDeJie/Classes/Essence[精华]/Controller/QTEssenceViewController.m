//
//  QTEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTEssenceViewController.h"
#import "QTTopicTableViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MainRecommendTableViewController.h"

@interface QTEssenceViewController ()
/** 由于只有5种type的API，所以把这几个存到数组来使用 */
@property (nonatomic,strong) NSArray *typeArray;
@end

@implementation QTEssenceViewController

-(NSArray<NSString *> *)titles{
    return @[@"推荐", @"图片", @"段子", @"声音", @"视频", @"网红", @"排行",  @"社会",  @"美女",  @"冷知识", @"游戏"];
}

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return  self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    QTTopicTableViewController *topicVC = [[QTTopicTableViewController alloc]init];
    
    if ( index < self.typeArray.count ) {
        topicVC.type = [self.typeArray[index] intValue];
    }else{
       topicVC.type = [self.typeArray[0] intValue];
    }
    return topicVC;

}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavBar];
}

-(void)setupNavBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImageName:@"MainTagSubIconClick" target:self action:@selector(leftBarButtonItemClick)];
}

/** 导航栏上左边按钮 */
- (void)leftBarButtonItemClick{
    MainRecommendTableViewController *vc = [[MainRecommendTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)typeArray {
	if(_typeArray == nil) {
//        QTTopicTypeAll = 1, //全部
//        QTTopicTypePicture = 10, //图片
//        QTTopicTypeWord = 29,//段子
//        QTTopicTypeVoice = 31,//声音
//        QTTopicTypeVideo = 41, //视频
		_typeArray = @[@(QTTopicTypeAll),@(QTTopicTypePicture), @(QTTopicTypeWord), @(QTTopicTypeVoice), @(QTTopicTypeVideo) ];
	}
	return _typeArray;
}

@end
