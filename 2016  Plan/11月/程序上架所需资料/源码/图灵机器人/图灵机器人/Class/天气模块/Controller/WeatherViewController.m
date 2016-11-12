//
//  WeatherViewController.m
//  天气助手
//
//  Created by Guo.JC on 16/8/27.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;

@end

@implementation WeatherViewController{
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气";
    [JCWeatherAnimation creatRainForLayer:self.view.layer];
//    [JCWeatherAnimation creatSnowForLayer:self.view.layer];
    [JCWeatherAnimation creatCloudForLayer:self.view.layer];
}

@end
