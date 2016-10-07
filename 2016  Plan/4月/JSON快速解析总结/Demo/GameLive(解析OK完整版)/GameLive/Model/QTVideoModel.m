//
//  QTVideoModel.m
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTVideoModel.h"

@implementation QTVideoModel
//重写方法，来配置修改的属性名
+ (NSDictionary*)modelContainerPropertyGenericClass{
    
    return @{
             @"videoList" : [QTVideoVideolistModel class],
             @"videoSidList" : [QTVideoVideosidlistModel class],
             
             };
}
@end

@implementation QTVideoVideolistModel : NSObject
//重写方法，来配置修改的属性名
+ (NSDictionary*)modelCustomPropertyMapper{
    
    return @{
             @"pTime":@"ptime",
             @"videoSource":@"videosource",
             @"sectionTitle":@"sectiontitle",
             @"playerSize":@"playersize",
             @"replyId":@"replyid",
             @"desc":@"description",
             };
}

+ (NSDictionary*)modelContainerPropertyGenericClass{
    
    return @{
             @" videoTopic " : [QTVideoVideotopicModel class],
             };
}

@end

@implementation QTVideoVideotopicModel : NSObject


@end

@implementation QTVideoVideosidlistModel : NSObject

//重写方法，来配置修改的属性名
+ (NSDictionary*)modelCustomPropertyMapper{
    
    return @{
             @"imgSrc":@"imgsrc",
           
             };
    
}
@end
