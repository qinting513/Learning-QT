//
//  UserModel.h
//  Chuye
//
               

//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>


@class UserModelData,UserModelDataWorks,UserModelDataWorksUser;
@interface UserModel : NSObject

@property (nonatomic, strong) UserModelData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface UserModelData : NSObject

@property (nonatomic, assign) NSInteger Drafts;

@property (nonatomic, strong) NSArray<UserModelDataWorks *> *Works;

@property (nonatomic, assign) NSInteger Favorites;

@property (nonatomic, assign) NSInteger Publishes;

@property (nonatomic, assign) NSInteger Forwards;

@end

@interface UserModelDataWorks : NSObject

@property (nonatomic, copy) NSString *Guid;

@property (nonatomic, copy) NSString *EditorVer;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *Thumbnail;

@property (nonatomic, strong) UserModelDataWorksUser *User;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) BOOL AllowInterfation;

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, copy) NSString *ThemeId;

@property (nonatomic, assign) NSInteger Public;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger PapawStatus;

@property (nonatomic, copy) NSString *Uri;

@property (nonatomic, copy) NSString *PublishAt;

@end

@interface UserModelDataWorksUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger sex;

@end

