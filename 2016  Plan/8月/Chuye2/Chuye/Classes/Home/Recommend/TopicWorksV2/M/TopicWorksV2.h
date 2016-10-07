//
//  TopicWorksV2.h
//  Chuye
//
               

//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>



@class TopicWorksV2Data,TopicWorksV2DataList,TopicWorksV2DataListUser;

@interface TopicWorksV2 : NSObject
@property (nonatomic, strong) TopicWorksV2Data *data;
@property (nonatomic, assign) NSInteger code;

+(id)parseTopicWorksV2;

@end

@interface TopicWorksV2Data : NSObject

@property (nonatomic, strong) NSArray<TopicWorksV2DataList *> *list;

@end

@interface TopicWorksV2DataList : NSObject

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, strong) TopicWorksV2DataListUser *User;

@property (nonatomic, assign) BOOL Praised;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger Skip;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) NSInteger Solitaires;

@property (nonatomic, assign) NSInteger Interaction;

@property (nonatomic, assign) NSInteger Praise;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Uri;

@property (nonatomic, assign) NSInteger Share;

@property (nonatomic, assign) NSInteger Comments;

@end

@interface TopicWorksV2DataListUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger sex;

@end

