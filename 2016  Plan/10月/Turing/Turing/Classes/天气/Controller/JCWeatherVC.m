//
//  WeatherViewController.m
//  天气助手
//
//  Created by Guo.JC on 16/8/27.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCWeatherVC.h"
#import <CoreLocation/CoreLocation.h>
#import "CitiesViewController.h"
#import "WeatherModel.h"
#import "JCWeatherAnimation.h"
#import "WeatherUtils.h"
#import <MapKit/MapKit.h>

@interface JCWeatherVC ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationmanager;
}
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDecade;
@property (weak, nonatomic) IBOutlet UIImageView *tempUnit;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *refreshAnimation;
@property (weak, nonatomic) IBOutlet UIImageView *ariImage;
@property (weak, nonatomic) IBOutlet UILabel *airInfo;
@property (weak, nonatomic) IBOutlet UILabel *humidityInfo;
@property (weak, nonatomic) IBOutlet UILabel *airPress;
@property (weak, nonatomic) IBOutlet UIImageView *littleGirl;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIImageView *sunShine;
@property (strong, nonatomic)WeatherModel *weatherInfo;
@property (weak, nonatomic) IBOutlet UIImageView *sun;
@property(nonatomic,strong) CitiesViewController *citiesList;
@property(nonatomic,strong)NSString *currentCity;

@property(nonatomic,strong)CAEmitterLayer *cloudAnimation;
@property(nonatomic,strong)CAEmitterLayer *rainAnimation;
@property(nonatomic,strong)CAEmitterLayer *snowAnimation;
@property(nonatomic,strong)CAEmitterLayer *LightningAnimation;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@end

@implementation JCWeatherVC{

}
#pragma mark 选择城市
- (IBAction)choiseCity:(id)sender {
    self.citiesList = [CitiesViewController new];
    
    CitiesViewController *citySupport = [CitiesViewController new];
    [self.navigationController pushViewController:citySupport animated:YES];
//    [self addChildViewController:self.citiesList];
//    CATransition *transition = [CATransition animation];
//    transition.duration = .5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    transition.type = @"rippleEffect";
//    transition.subtype = kCATransitionFromRight;
//    transition.delegate = self;
//    [self.view.layer addAnimation:transition forKey:nil];
//    [self.view addSubview:self.citiesList.view];
//    
//    [self.citiesList.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.and.top.and.right.and.bottom.equalTo(self.view);
//    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:CITY_NAME_KEY];
//    [self getWeatherInfo];

    [JCWeatherAnimation creatLightningForLayer:self.map.layer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:CITY_NAME_KEY];
    [JCWeatherAnimation creatSunnyForLayer:self.sunShine.layer];
    [JCWeatherAnimation rotateImage:self.refreshAnimation];
    
    self.cloudAnimation = [JCWeatherAnimation creatCloudForLayer:self.view.layer];
    self.rainAnimation = [JCWeatherAnimation creatRainForLayer:self.view.layer];
    self.LightningAnimation = [JCWeatherAnimation creatLightningForLayer:self.view.layer];
    self.snowAnimation = [JCWeatherAnimation creatSnowForLayer:self.view.layer];
    self.cloudAnimation.hidden = YES;
    self.rainAnimation.hidden = YES;
    self.LightningAnimation.hidden = YES;
    self.snowAnimation.hidden = YES;
    
    _locationmanager = [[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
    }
    
    //如果没有授权，则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationmanager requestAlwaysAuthorization];
        NSLog(@"请求授权");
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationmanager.delegate=self;
        //设置定位精度
        _locationmanager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationmanager.distanceFilter=distance;
        //启动跟踪定位
        [_locationmanager startUpdatingLocation];
    }
}

#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationmanager stopUpdatingLocation];
}

-(void)getWeatherInfo
{
    __weak JCWeatherVC *mySelf = self;
    [WeatherUtils requestCityWeatherWithCityName:self.currentCity andCallback:^(id obj) {
        mySelf.weatherInfo = obj;
        [mySelf refreshInfo];
    }];
}
-(void)refreshInfo
{
    self.location.text = self.currentCity;
    /*展示当前温度*/
    NSString *temp = self.weatherInfo.temp;
    int _temp = temp.intValue;
    self.tempDecade.image = [UIImage imageNamed:[NSString stringWithFormat:@"org4_widget_nw%d",_temp/10]];
    self.tempUnit.image = [UIImage imageNamed:[NSString stringWithFormat:@"org4_widget_nw%d",_temp%10]];
    /*展示天气情况：晴天，雨天...*/
    NSString *weatherTitle = self.weatherInfo.weather;
    self.weatherLabel.text = weatherTitle;
    
    if ([weatherTitle containsString:@"雨"]) {
        [UIView animateWithDuration:.5 animations:^{
            self.rainAnimation.hidden = NO;
            self.cloudAnimation.hidden = NO;
            self.backGroundImage.image = [UIImage imageNamed:@"bg_rain_day1"];
            self.sunShine.hidden = YES;
            self.sun.hidden = YES;
        }];
    }else
    {
        self.rainAnimation.hidden = YES;
        self.cloudAnimation.hidden = YES;
    }
    
    if ([weatherTitle containsString:@"雷"])
        self.LightningAnimation.hidden = NO;
    else
        self.LightningAnimation.hidden = YES;
    
    if ([weatherTitle containsString:@"阴"] && ![weatherTitle containsString:@"雨"]) {
        [UIView animateWithDuration:.5 animations:^{
            self.cloudAnimation.hidden = NO;
            self.backGroundImage.image = [UIImage imageNamed:@"bg_02"];
            self.sunShine.alpha = .4;
            self.sun.alpha = .4;
        }];
    }
    else{
        self.cloudAnimation.hidden = YES;
    }
    
    if ([weatherTitle containsString:@"雪"]) {
        [UIView animateWithDuration:.5 animations:^{
            self.snowAnimation.hidden = NO;
            self.backGroundImage.image = [UIImage imageNamed:@"bg_snow_day"];
            self.sunShine.hidden = YES;
            self.sun.hidden = YES;
        }];
    }
    else{
         self.snowAnimation.hidden = YES;
    }
    
    if ([weatherTitle containsString:@"云"]) {
        [UIView animateWithDuration:.5 animations:^{
            self.cloudAnimation.hidden = NO;
        }];
    }
    else{
        self.cloudAnimation.hidden = YES;
    }
    if ([weatherTitle containsString:@"晴"]) {
        [UIView animateWithDuration:.5 animations:^{
            self.backGroundImage.image = [UIImage imageNamed:@"bg_sun_day"];
            self.cloudAnimation.hidden = NO;
            self.sunShine.hidden = NO;
            self.sun.hidden = NO;
        }];
    }
    
    self.humidityInfo.text = [NSString stringWithFormat:@"%@%",self.weatherInfo.humidity];
    self.airPress.text = [self.weatherInfo.wind_direction stringByAppendingString:self.weatherInfo.wind_strength];
}

//是否支持旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //只支持竖屏
    return UIInterfaceOrientationMaskPortrait;
}
@end
