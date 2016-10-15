//
//  LiveViewController.m
//  LiveApp
//
//  Created by Qinting on 2016/10/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "LiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "LiveItem.h"
#import <UIImageView+WebCache.h>

@interface LiveViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) IJKFFMoviePlayerController  *playerVc;
@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    // 设置直播占位图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",_live.creator.portrait]];
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 拉流地址
    NSURL *url = [NSURL URLWithString:_live.stream_addr];
    NSLog(@"=========== %@",self.live.stream_addr);
    self.playerVc = [[IJKFFMoviePlayerController alloc]initWithContentURL:url withOptions:nil];
        // 准备播放
    [self.playerVc prepareToPlay];
    self.playerVc.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:self.playerVc.view atIndex:1];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_playerVc pause];
    [_playerVc stop];
    [_playerVc shutdown];
//    _playerVc = nil;
}



@end
