//
//  MasterUser.h
//  Chuye
//
               

//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MasterUserData,MasterUserDataChuyeuser,MasterUserDataFromselfaimothers,MasterUserDataRelationstat;
@interface MasterUser : NSObject

@property (nonatomic, strong) MasterUserData *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface MasterUserData : NSObject

@property (nonatomic, strong) MasterUserDataFromselfaimothers *FromSelfAimOthers;

@property (nonatomic, strong) MasterUserDataChuyeuser *ChuyeUser;

@property (nonatomic, strong) MasterUserDataRelationstat *RelationStat;

@end

@interface MasterUserDataChuyeuser : NSObject

@property (nonatomic, copy) NSString *Nickname;

@property (nonatomic, copy) NSString *Introduction;

@property (nonatomic, copy) NSString *HeadPhoto;

@property (nonatomic, assign) NSInteger Sex;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) NSInteger Id;

@end

@interface MasterUserDataFromselfaimothers : NSObject

@end

@interface MasterUserDataRelationstat : NSObject

@property (nonatomic, assign) NSInteger BeenConcerned;

@property (nonatomic, assign) NSInteger FoucsOthers;

@end

