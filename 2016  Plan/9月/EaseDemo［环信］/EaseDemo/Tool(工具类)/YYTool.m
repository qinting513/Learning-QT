//
//  YYTool.m
//  ITSNS
//
//  Created by Qinting on 16/8/24.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import "YYTool.h"
//#import "amrFileCodec.h"

@implementation YYTool

+(void)faceMappingWithTextView:(YYTextView*)tv{
    YYTextSimpleEmoticonParser *parse = [YYTextSimpleEmoticonParser new];
    
    NSMutableDictionary *mapperDic = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
    NSArray *faceArr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *faceDic in faceArr) {
        NSString *imageName = faceDic[@"png"];
        NSString *text = faceDic[@"chs"];
        [mapperDic setObject:[UIImage imageNamed:imageName] forKey:text];
    }
    
    parse.emoticonMapper = mapperDic;
    tv.textParser = parse;
}

//+(void)playVoiceWithPath:(NSString *)path{
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
////        得到amr 音频数据
//        BmobFile *file = [[BmobFile alloc]initWithFilePath:path];
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:file.url]];
//        
////        把amr 解码 到 wav 格式
//        data = DecodeAMRToWAVE(data);
//        
////        播放
//        dispatch_async( dispatch_get_main_queue(), ^{
//            player = [[AVAudioPlayer alloc]initWithData:data error:nil];
//            [player play];
//        });
//    });
//    
//}

@end
