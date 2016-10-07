//
//  DiscoveryUsers.h
//  Chuye
//
               

//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DiscoveryUsersData,DiscoveryUsersDataMasterUser,DiscoveryUsersDataWorks,DiscoveryUsersDataWorksUser;
@interface DiscoveryUsers : NSObject

@property (nonatomic, strong) NSArray<DiscoveryUsersData *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface DiscoveryUsersData : NSObject

@property (nonatomic, assign) NSInteger RID;

@property (nonatomic, strong) NSArray<DiscoveryUsersDataWorks *> *Works;

@property (nonatomic, strong) DiscoveryUsersDataMasterUser *User;

@end

@interface DiscoveryUsersDataMasterUser : NSObject

@property (nonatomic, copy) NSString *Nickname;

@property (nonatomic, copy) NSString *HeadPhoto;

@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, copy) NSString *Introduction;

@property (nonatomic, assign) NSInteger Id;

@end

@interface DiscoveryUsersDataWorks : NSObject

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, strong) DiscoveryUsersDataWorksUser *User;

@property (nonatomic, assign) BOOL Praised;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) NSInteger Interaction;

@property (nonatomic, assign) NSInteger Praise;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Uri;

@property (nonatomic, assign) NSInteger Share;

@property (nonatomic, assign) NSInteger Comments;

@end

@interface DiscoveryUsersDataWorksUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, assign) NSInteger sex;

@end

