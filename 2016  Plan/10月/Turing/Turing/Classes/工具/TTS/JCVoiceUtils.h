//
//  JCVoiceUtils.h
//  图灵机器人
//
//  Created by Guo.JC on 16/8/31.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JCVoiceUtils;

static IFlySpeechSynthesizer *_iFlySpeechSynthesizer;
static IFlySpeechRecognizer *_iFlySpeechRecognizer;
static JCVoiceUtils *_JCVoice;

@interface JCVoiceUtils : NSObject<IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate>
@property(nonatomic,copy)NSString *voiceResult;

+(JCVoiceUtils*)sharedVoice;
-(void)textTransferVoiceWithText:(NSString *)text;
-(void)startVoiceTransToText;


@end
