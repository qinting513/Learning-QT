//
//  Recommend.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Recommend.h"
#import "NSObject+Parse.h"

@implementation Recommend
+(NSDictionary *)objectInArray{
    return @{@"data":[RecommendData class]};
}
@end
@implementation RecommendData
+(NSDictionary *)objectInArray{
   return @{  @"works":[RecommendDataWorks class],
                     @"topic":[RecommendDataTopic class],
                    @"banners":[RecommendDataBanners class],
                    @"album":[RecommendDataAlbum class]
              };
}

@end


@implementation RecommendDataWorks
+(NSDictionary *)objectInArray{
    return @{@"User":[RecommendDataWorksUser class]};
}
@end


@implementation RecommendDataWorksUser

@end


@implementation RecommendDataTopic

@end


@implementation RecommendDataBanners

@end


@implementation RecommendDataAlbum

@end

