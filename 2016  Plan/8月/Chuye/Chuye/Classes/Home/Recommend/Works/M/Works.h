//
//  Topics.h
//  Chuye
//
               

//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorksData,WorksDataUser;
@interface Works : NSObject

@property (nonatomic, strong) NSArray<WorksData *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface WorksData : NSObject

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, assign) NSInteger MID;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, strong) WorksDataUser *User;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) BOOL Praised;

@property (nonatomic, assign) NSInteger Solitaires;

@property (nonatomic, assign) NSInteger Interaction;

@property (nonatomic, assign) NSInteger Praise;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Uri;

@property (nonatomic, assign) NSInteger Share;

@property (nonatomic, assign) BOOL IsStick;

@property (nonatomic, assign) NSInteger Comments;

@end

@interface WorksDataUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, assign) NSInteger sex;

@end

