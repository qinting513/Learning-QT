//
//  ViewController.m
//  PictureInPictureDemo
//
//  Created by Qinting on 16/6/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "PipVideoView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#define currentItemStatus @"currentItem.status"

@interface ViewController ()   // <AVPictureInPictureControllerDelegate>

@property (strong, nonatomic) IBOutlet PipVideoView *pipVideoView;

@property (nonatomic,strong) AVPlayer *player;

@property (nonatomic,strong) AVPictureInPictureController *pipController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"video" withExtension:@".mov"];
    AVAsset *asset = [AVAsset assetWithURL:path];
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithAsset:asset];
    [self.player replaceCurrentItemWithPlayerItem:item];
     self.pipVideoView.pipAVPlayer = self.player;
    [self.player play];
}

- (AVPlayer *)player {
	if(_player == nil) {
		_player = [[AVPlayer alloc] init];
        [_player addObserver:self forKeyPath:currentItemStatus options:NSKeyValueObservingOptionNew context:nil];
	}
	return _player;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
        if([keyPath  isEqualToString: currentItemStatus])
        {
              NSNumber *oldNum = change[NSKeyValueChangeOldKey];
            NSNumber *num =  [change valueForKey:NSKeyValueChangeNewKey];
            NSLog(@"num: %@---%@",num,oldNum);
            
            if (num.integerValue != AVPlayerItemStatusReadyToPlay) {
                return;
            }
        }

    self.pipController = [[AVPictureInPictureController alloc]initWithPlayerLayer:self.pipVideoView. avPlayerLayer];
//    self.pipController.delegate = self;
}

@end
