//
//  RecommendUtils.h
//  Chuye
//
               

//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendUtils : NSObject
+(id)parseRecomend;
+(id)parseWorks;
+(id)GET:(NSString *)url  completionHandler:(void (^)( NSArray *, NSError *))completionHandler;
+(id)GETMoreTopics:(NSString *)url  completionHandler:(void (^)( NSArray *, NSError *))completionHandler;
@end
