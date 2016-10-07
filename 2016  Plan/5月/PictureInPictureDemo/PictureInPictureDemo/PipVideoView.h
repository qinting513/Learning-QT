//
//  PipVideoView.h
//  PictureInPictureDemo
//
//  Created by Qinting on 16/6/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PipVideoView : UIView
/** 定义一个播放器 */
@property (nonatomic,strong) AVPlayer *pipAVPlayer;

/** 播放器的layer层 */
@property (nonatomic,strong) AVPlayerLayer *avPlayerLayer;



@end
