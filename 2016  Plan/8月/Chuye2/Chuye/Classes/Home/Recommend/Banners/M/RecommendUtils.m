//
//  RecommendUtils.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "RecommendUtils.h"
#import "Recommend.h"
#import "Works.h"
#import "MoreTopics.h"
#import "NSObject+Parse.h"

@implementation RecommendUtils

+(id)parseRecomend{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Recommend" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dishesDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    Recommend*  recomend = [Recommend parse:dishesDic];
    return recomend;
}

+(id)parseWorks{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Works" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dishesDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    Works*  works = [Works parse:dishesDic];
    return works;
}

+(id)GET:(NSString *)url  completionHandler:(void (^)( NSArray *, NSError *))completionHandler
{
    NSMutableArray *arr  = [NSMutableArray array];
   return  [self  GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if(!error){
//            NSLog(@"model: %@",model);
            NSArray *modelArr = model[@"data"];
            for (NSDictionary *dic in modelArr) {
                [arr addObject:[RecommendDataAlbum parse:dic]];
            }
        }
       completionHandler(arr,nil);
    }];
   
}

+(id)GETMoreTopics:(NSString *)url  completionHandler:(void (^)( NSArray *, NSError *))completionHandler
{
    NSMutableArray *arr  = [NSMutableArray array];
    return  [self  GET:url parameters:nil progress:nil completionHandler:^(id model, NSError *error) {
        if(!error){
            //            NSLog(@"model: %@",model);
            NSArray *modelArr = model[@"data"];
            for (NSDictionary *dic in modelArr) {
                [arr addObject:[MoreTopicsData parse:dic]];
            }
        }
        completionHandler(arr,error);
    }];
    
}

@end
