//
//  Discovery.h
//  Chuye
//
               

//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DiscoveryData,DiscoveryDataWorks,DiscoveryDataWorksUser;

@interface Discovery : NSObject

@property (nonatomic, strong) DiscoveryData *data;
@property (nonatomic, assign) NSInteger code;

@end
@interface DiscoveryData : NSObject

@property (nonatomic, assign) NSInteger RID;

@property (nonatomic, strong) NSArray<NSString *> *users;

@property (nonatomic, strong) NSArray<DiscoveryDataWorks *> *works;

@end

@interface DiscoveryDataWorks : NSObject

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, assign) NSInteger Praise;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, assign) NSInteger Comments;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) DiscoveryDataWorksUser *User;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger Share;

@end

@interface DiscoveryDataWorksUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, assign) NSInteger sex;

@end

