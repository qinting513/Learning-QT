//
//  WeiboFrame.m
//  Weibo
//
//  Created by Qinting on 16/7/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "WeiboFrame.h"

#define kCellBorder 10
#define kMargin 20
//icon宽高
#define kIconWH 30
//image width height
#define kImageWH 200

@interface WeiboFrame()

@end
@implementation WeiboFrame

-(void)setWeibo:(Weibo *)weibo
{
    _weibo = weibo;
    NSLog(@"kScreenW:%f",kScreenW);
    CGFloat iconX = kCellBorder;
    CGFloat iconY = kCellBorder;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    CGFloat nameX = _iconF.origin.x+kIconWH+kCellBorder;
    CGFloat nameY = iconY;
    CGSize nameSize  =[_weibo.name sizeWithAttributes:@{NSFontAttributeName:kNameFont}];
    _nameF = CGRectMake(nameX,nameY,nameSize.width,nameSize.height);
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameF)+kCellBorder;
    CGSize timeSize  = [_weibo.time sizeWithAttributes:@{NSFontAttributeName: kTimeFont}];
    _timeF =CGRectMake(timeX, timeY,timeSize.width,timeSize.height);
    
    CGFloat sourceX = CGRectGetMaxX(_timeF)+kCellBorder;
    CGFloat sourceY = timeY;
    NSString * sourceText = [NSString stringWithFormat:@"来自:%@",_weibo.source];
    CGSize sourceSize = [sourceText sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
    _sourceF = CGRectMake(sourceX,sourceY,sourceSize.width,sourceSize.height);
    
//    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(_iconF), CGRectGetMaxY(_timeF) );

    CGSize contentSize  = [_weibo.content boundingRectWithSize:CGSizeMake(kScreenW - 2*kMargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kNameFont} context:nil].size;
    _contentF =  CGRectMake(kMargin, contentY,contentSize.width,contentSize.height);
    
    if (_weibo.image)
    {
        CGFloat imageX = iconX;
        CGFloat imageY = CGRectGetMaxY(_contentF) + kCellBorder;
        _imageF = CGRectMake(imageX,imageY,kImageWH,280);
        
        _cellHeight = CGRectGetMaxY(_imageF)+kCellBorder;
    }
    else
    {
        _cellHeight = CGRectGetMaxY(_contentF)+kCellBorder;
    }
    NSLog(@"%.2lf",_cellHeight);
}

@end
