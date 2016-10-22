//
//  LiveVC.m
//  给张工的
//
//  Created by Guo.JC on 16/10/20.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "LiveVC.h"
#import <Masonry.h>
#import <AFNetworking.h>
typedef enum
{
    Hall,
    BedRoom,
    WashRoom
}RoomType;


@interface LiveVC ()

@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UIImageView *hall;
@property (weak, nonatomic) IBOutlet UIImageView *bedRoom;
@property (weak, nonatomic) IBOutlet UIImageView *washRoom;
@property (nonatomic, strong) UIView *blackView;


@property (nonatomic, assign) int ShowType;

@property (nonatomic, strong) NSArray *hallImages;
@property (nonatomic, strong) NSArray *bedRoomImages;
@property (nonatomic, strong) NSArray *WashRoomImages;

@end

@implementation LiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadAnimation];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self getData];
    UIButton *btn = [UIButton buttonWithType:0];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(20, 30, 23.0/2, 42.0/2);
    [btn setBackgroundImage:[UIImage imageNamed:@"left_arrow"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion: nil];
}
#pragma mark 加载动画
- (void)loadAnimation{
    if (!self.blackView) {
        self.blackView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.blackView.backgroundColor = [UIColor blackColor];
        self.blackView.alpha = .8;
        [self.view addSubview:self.blackView];
        
        UIImageView *loadActivity = [UIImageView new];
        loadActivity.image = [UIImage imageNamed:@"加载"];
        [self.blackView addSubview:loadActivity];
        
        [loadActivity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.blackView);
            make.width.and.height.offset(80);
        }];
        
        CABasicAnimation *anim = [CABasicAnimation animation];
        anim.keyPath = @"transform.rotation";
        anim.toValue = @(M_PI * 2);
        anim.duration = 1.5;
        anim.repeatCount = MAXFLOAT;
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        [loadActivity.layer addAnimation:anim forKey:nil];
    }
}


-(void)getData{
    NSDictionary *sourceDict = @{
                        @"hall": @"http://xiaoguotu.to8to.com/list-h1s1i0",
                        @"bedroom" : @"http://xiaoguotu.to8to.com/list-h1s2i0",
                        @"washroom" : @"http://xiaoguotu.to8to.com/list-h1s5i0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    for(NSString *key in sourceDict.allKeys){
       [manager GET:sourceDict[key] parameters:nil  progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSData *data = responseObject;
           NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
           NSString *pattern = @"http:(.*?).jpg";
         NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
           NSArray *results = [regular matchesInString:responseString options:0 range:NSMakeRange(0, responseString.length)];
           NSMutableArray<NSURL*> *allUrls = [NSMutableArray array];
           for (NSTextCheckingResult* result in results){
             NSRange range = [result rangeAtIndex:0];
             NSString *urlString = [responseString substringWithRange:range];
             [allUrls addObject:[NSURL URLWithString:urlString]];
          }
            if([key isEqualToString: @"hall"]){
               self.hallImages = allUrls;
            }else if([key isEqualToString:@"bedroom"]){
             self.bedRoomImages = allUrls;
            }else{
             self.WashRoomImages = allUrls;
          }
           self.ShowType = Hall;
           if (self.hallImages.count > 0 && self.WashRoomImages.count > 0 && self.bedRoomImages.count > 0 ) {
              [self refreshUI];
              
           }
           
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error == %@",error);
      }];
   }
}

#pragma mark 选择需要查看的房间
- (IBAction)selectShowRoom:(UIButton *)sender {
    [self changeSelect:(int)sender.tag];
    [self refreshUI];
}

#pragma mark 加载图片
- (void)changeSelect:(int)type{
    switch (type) {
        case Hall:
        {
            self.hall.alpha = 1;
            self.bedRoom.alpha = .5;
            self.washRoom.alpha = .5;
            self.ShowType = Hall;
        }
            break;
            
        case BedRoom:
        {
            self.hall.alpha = .5;
            self.bedRoom.alpha = 1;
            self.washRoom.alpha = .5;
            self.ShowType = BedRoom;
        }
            break;
            
        case WashRoom:
        {
            self.ShowType = WashRoom;
            self.hall.alpha = .5;
            self.bedRoom.alpha = .5;
            self.washRoom.alpha = 1;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 点击刷新图片
- (IBAction)refreshAction:(UIButton *)sender {
    
    [self refreshUI];
    
}

#pragma mark 刷新UI
- (void)refreshUI{
    switch (self.ShowType) {
        case Hall:
        {
            [self getImageDataWithURL:self.hallImages[arc4random()%self.hallImages.count] ShowImage:self.showImage selectImage:self.hall];
        }
            break;
            
        case BedRoom:
        {
            [self getImageDataWithURL:self.bedRoomImages[arc4random()%self.bedRoomImages.count] ShowImage:self.showImage selectImage:self.bedRoom];
        }
            break;
            
        case WashRoom:
        {
            [self getImageDataWithURL:self.WashRoomImages[arc4random()%self.WashRoomImages.count] ShowImage:self.showImage selectImage:self.washRoom];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark 开线程获取图片
- (void)getImageDataWithURL:(NSURL *)url ShowImage:(UIImageView *)imageView selectImage:(UIImageView*)selectImageView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
            selectImageView.image = image;
            if(self.blackView){
                [self.blackView removeFromSuperview];
                self.blackView = nil;
            }
        });
    });
}


@end
