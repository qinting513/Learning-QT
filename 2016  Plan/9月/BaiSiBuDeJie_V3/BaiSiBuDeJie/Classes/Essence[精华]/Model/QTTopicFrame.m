//
//  QTTopicFrame.m
//  BaiSiBuDeJie
//
                        /*
                         *----------Dragon be here!----------*
                         * 　　　┏┓　　　┏┓
                         * 　　┏┛┻━━━┛┻┓
                         * 　　┃　　　　　　　┃
                         * 　　┃　　　━　　　┃
                         * 　　┃　┳┛　┗┳　┃
                         * 　　┃　　　　　　　┃
                         * 　　┃　　　┻　　　┃
                         * 　　┃　　　　　　　┃
                         * 　　┗━┓　　　┏━┛
                         * 　　　　┃　　　┃神兽保佑
                         * 　　　　┃　　　┃代码永无BUG！
                         * 　　　　┃　　　┗━━━┓
                         * 　　　　┃　　　　　　　┣┓
                         * 　　　　┃　　　　　　　┏┛
                         * 　　　　┗┓┓┏━┳┓┏┛
                         * 　　　　　┃┫┫　┃┫┫
                         * 　　　　　┗┻┛　┗┻┛
                           * ━━━━━神兽出没，杀死BUG━━━━━━*
                         *
                         *  http://my.oschina.net/AngusTing/blog?catalog=3487645
                         *  推荐博客 http://www.jianshu.com/users/1c034326279d/latest_articles
                         *
                         */


//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTTopicFrame.h"
#import "QTTopic.h"

@implementation QTTopicFrame

-(void)setTopic:(QTTopic *)topic{
    _topic = topic;
    /** 文字相关 */
    CGFloat textX = 10;
    CGFloat textY = 50;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2*textX - 2 *CellMargin;
    CGFloat textH = [topic.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil ].size.height;
  /** 最大的Y值 */
    CGFloat maxY = textY +textH + 10;
    /** 中间的内容 */
    if(topic.type != QTTopicTypeWord){
        CGFloat contentY = maxY;
        CGFloat contentX = textX;
        CGFloat contentW = textW;
        CGFloat widthScale = topic.width / contentW;
        CGFloat contentH = topic.height / widthScale;
        if (topic.type == QTTopicTypeVideo && contentH > 250) {
            contentH = 250  ;
            topic.bigImage = YES;
        }
        
        if (contentH > 2000) {
            contentH = 300;
            topic.bigImage = YES;
        }
        
        self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
        maxY = contentY + contentH + 10;
    }
    
    self.cellHeight = maxY + 40;
}

-(BOOL)isEqual:(QTTopicFrame *)object{
    return [self.topic.id isEqualToString:object.topic.id];
}

@end



