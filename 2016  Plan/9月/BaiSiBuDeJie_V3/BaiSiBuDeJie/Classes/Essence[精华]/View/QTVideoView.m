//
//  QTVideoView.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTVideoView.h"

@implementation QTVideoView

+(id)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setTopic:(QTTopic *)topic{
    [super setTopic:topic];
    
    self.durationLabel.text = [NSString stringWithFormat:@"%02d:%02d",topic.videotime / 60, topic.videotime % 60];
    
    /** 如果是大图 则缩放，不是则填满 */
    if(topic.bigImage){
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }else{
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    

}

@end
