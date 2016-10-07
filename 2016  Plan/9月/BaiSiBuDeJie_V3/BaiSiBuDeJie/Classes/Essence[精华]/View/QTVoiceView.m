//
//  QTVoiceView.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTVoiceView.h"

@implementation QTVoiceView

+(id)voiceView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setTopic:(QTTopic *)topic{
    
    [super setTopic: topic];
    
    self.durationLabel.text = [NSString stringWithFormat:@"%2d:%2d",topic.voicetime/60, topic.voicetime%60];
}

@end
