//
//  AddFriend.h
//  Chuye
//
               

//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddFriendData,AddFriendDataUser,AddFriendDataWorks,AddFriendDataWorksUser;
@interface AddFriend : NSObject

@property (nonatomic, strong) NSArray<AddFriendData *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface AddFriendData : NSObject

@property (nonatomic, assign) NSInteger RID;

@property (nonatomic, strong) NSArray<AddFriendDataWorks *> *Works;

@property (nonatomic, strong) AddFriendDataUser *User;

@end

@interface AddFriendDataUser : NSObject

@property (nonatomic, copy) NSString *Nickname;

@property (nonatomic, copy) NSString *HeadPhoto;

@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, copy) NSString *Introduction;

@property (nonatomic, assign) NSInteger Id;

@end

@interface AddFriendDataWorks : NSObject

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, strong) AddFriendDataWorksUser *User;

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

@interface AddFriendDataWorksUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, assign) NSInteger sex;

@end

