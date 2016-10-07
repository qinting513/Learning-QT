//
//  JCVoiceUtils.m
//  图灵机器人
//
//  Created by Guo.JC on 16/8/31.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCVoiceUtils.h"

@interface JCVoiceUtils()<IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate>
@end

@implementation JCVoiceUtils{

    NSString *_result;
}

+(JCVoiceUtils *)sharedVoice
{
    @synchronized(self) {
        if (!_JCVoice) {
            _JCVoice = [[JCVoiceUtils alloc]init];
        }
    }
    /*1.创建合成对象*/
    if (!_iFlySpeechSynthesizer) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
        _iFlySpeechSynthesizer.delegate = _JCVoice;
    }
    if (!_iFlySpeechRecognizer) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance]; //设置听写模式
        [_iFlySpeechRecognizer setDelegate:_JCVoice];
    }
    return _JCVoice;
}

-(void)startVoiceTransToText
{
    _result = @"";
    [_iFlySpeechRecognizer cancel];
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    [_iFlySpeechRecognizer startListening];
}
#pragma mark 语音转化回调方法
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    _result =[NSString stringWithFormat:@"%@%@", self.voiceResult,resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    self.voiceResult = [NSString stringWithFormat:@"%@%@", self.voiceResult,resultFromJson];
    
    if (isLast){
        NSLog(@"听写结果(json)：%@测试", _result);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"语音转化完成" object:self.voiceResult];
    }
//    NSLog(@"_result=%@",_result);
//    NSLog(@"resultFromJson=%@",resultFromJson);
//    NSLog(@"isLast=%d,_textView.text=%@",isLast,_showText.text);
}
-(void)textTransferVoiceWithText:(NSString *)text
{
    
    
    //2.设置合成参数
    //设置在线工作方式
    [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                  forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //音量,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"60" forKey: [IFlySpeechConstant VOLUME]];
    //发音人,默认为”xiaoyan”,可以设置的参数列表可参考“合成发音人列表”
    [_iFlySpeechSynthesizer setParameter:@"vinn" forKey: [IFlySpeechConstant VOICE_NAME]];
    //保存合成文件名,如不再需要,设置设置为nil或者为空表示取消,默认目录位于 library/cache下
    [_iFlySpeechSynthesizer setParameter:@" tts.pcm" forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    //3.启动合成会话
    [_iFlySpeechSynthesizer startSpeaking: text];
    
    
    //1.创建语音听写对象

    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //2.设置听写参数
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path是录音文件名,设置value为nil或者为空取消保存,默认保存目录在 Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
}
@end
