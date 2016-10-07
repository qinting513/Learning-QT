//
//  YYTool.h
//  ITSNS
//
               

//  Created by Qinting on 16/8/24.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <YYKit.h>
static AVAudioPlayer *player;
@interface YYTool : NSObject
/** 读取plist文件 将text对应的image 映射到YYTextView的textParser */
+(void)faceMappingWithTextView:(YYTextView*)tv;

+(void)playVoiceWithPath:(NSString *)path;
@end
