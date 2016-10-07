//
//  Transmit.h
//  Chuye
//
               

//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TransmitData,TransmitDataUser;

@interface Transmit : NSObject

@property (nonatomic, strong) NSArray<TransmitData *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface TransmitData : NSObject

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger Solitaires;

@property (nonatomic, assign) NSInteger MiaoCount;

@property (nonatomic, assign) NSInteger Comments;

@property (nonatomic, assign) NSInteger Miao;

@property (nonatomic, assign) NSInteger Fid;

@property (nonatomic, assign) NSInteger Share;

@property (nonatomic, assign) BOOL AllowInterfation;

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, assign) BOOL Praised;

@property (nonatomic, strong) TransmitDataUser *User;

@property (nonatomic, copy) NSString *Uri;

@property (nonatomic, assign) NSInteger PapawStatus;

@property (nonatomic, assign) NSInteger Giftable;

@property (nonatomic, copy) NSString *SignupId;

@property (nonatomic, assign) NSInteger Interaction;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, copy) NSString *Thumbnail;

@property (nonatomic, assign) NSInteger Public;

@property (nonatomic, assign) NSInteger Praise;

@property (nonatomic, copy) NSString *Guid;

@end

@interface TransmitDataUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, assign) NSInteger sex;

@end

