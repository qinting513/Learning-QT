//
//  MoreTopics.h
//  Chuye
//
               

//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MoreTopicsData;
@interface MoreTopics : NSObject

@property (nonatomic, strong) NSArray<MoreTopicsData *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface MoreTopicsData : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, copy) NSString *FeelingUrl;

@property (nonatomic, assign) NSInteger WorkCount;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger SubscribeCount;

@property (nonatomic, copy) NSString *Description;

@end

