//
//  Recommend.h
//  Chuye
//
               

//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RecommendData,RecommendDataWorks,RecommendDataWorksUser,RecommendDataTopic,RecommendDataBanners,RecommendDataAlbum;

@interface Recommend : NSObject
//
@property (nonatomic, strong) RecommendData *data;
@property (nonatomic, assign) NSInteger code;
@end

@interface RecommendData : NSObject

@property (nonatomic, strong) NSArray<RecommendDataWorks *> *works;

@property (nonatomic, assign) BOOL WeChat;

@property (nonatomic, strong) NSArray<RecommendDataTopic *> *topic;

@property (nonatomic, strong) NSArray<RecommendDataBanners *> *banners;

@property (nonatomic, strong) NSArray<RecommendDataAlbum *> *album;

@end

@interface RecommendDataWorks : NSObject

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, assign) NSInteger MID;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, strong) RecommendDataWorksUser *User;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) NSInteger Praise;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Uri;

@property (nonatomic, assign) NSInteger Share;

@property (nonatomic, assign) NSInteger Comments;

@end

@interface RecommendDataWorksUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, assign) NSInteger sex;

@end

@interface RecommendDataTopic : NSObject

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *FeelingUrl;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, assign) NSInteger Id;

@end

@interface RecommendDataBanners : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Thumbnail;

@property (nonatomic, assign) NSInteger Sort;

@property (nonatomic, copy) NSString *EndTime;

@property (nonatomic, copy) NSString *BeginTime;

@end

@interface RecommendDataAlbum : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, copy) NSString *Thumbnail;

@property (nonatomic, copy) NSString *Summary;

@property (nonatomic, assign) NSInteger WorkAccess;

@property (nonatomic, assign) NSInteger WorkCount;

@property (nonatomic, copy) NSString *Title;

@end

