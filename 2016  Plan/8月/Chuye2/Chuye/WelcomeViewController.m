//
//  WelcomeViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
@import AVFoundation;

@interface WelcomeViewController ()
//显示视频
@property (nonatomic,strong) AVPlayerLayer  *playerLayer;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"mov.bundle/movie" withExtension:@"mp4"];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:videoURL];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    _playerLayer.frame = self.view.bounds;
    
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_playerLayer];
    [player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    
}
- (void)playToEnd{
    [_playerLayer removeFromSuperlayer];
    //点击以后, 让欢迎页的所在的window, 逐渐变透明, 并且放大
    [UIView animateWithDuration:1 animations:^{
        self.view.window.alpha = 0;
        //view 三大属性: bounds,  frame, transform
        self.view.window.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        delegate.welcomeWindow.hidden = YES;
        //释放欢迎控制器的指针索引
        delegate.welcomeWindow.rootViewController = nil;
        delegate.welcomeWindow = nil;
        //设置当前版本号为已读版本号
        NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
        NSString *version = infoDic[@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"ReadVersion"];
        //NSUserDefaults从内存写入硬盘的时机,由runloop来掌握, 并不是立刻写入.
        //要想立刻写入, 则调用
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

- (void)dealloc{
    //切记: 监听者必须在添加的对应生命周期中删除
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"dealloc");
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
