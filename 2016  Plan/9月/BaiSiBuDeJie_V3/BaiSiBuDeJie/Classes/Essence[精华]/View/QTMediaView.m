//
//  QTMediaView.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTMediaView.h"
#import "QTTopic.h"

@implementation QTMediaView

- (void)setTopic:(QTTopic *)topic{
    [super setTopic:topic];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%d播放", topic.playcount];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image2]];
}

@end
