//
//  Attention.h
//  Chuye
//
               

//  Created by Qinting on 16/8/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AttentionData,AttentionDataTotal,AttentionDataUser,AttentionDataLikes,AttentionDataComments,AttentionDataForwardUser;
@interface Attention : NSObject
@property (nonatomic, strong) NSArray<AttentionData *> *data;
@property (nonatomic, assign) NSInteger code;

+(id)parseAttention;

@end
@interface AttentionData : NSObject

@property (nonatomic, strong) AttentionDataTotal *Total;

@property (nonatomic, strong) NSArray<AttentionDataLikes *> *Likes;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *ThumbnailUrl;

@property (nonatomic, assign) NSInteger RelateId;

@property (nonatomic, copy) NSString *PreviewImgUrl;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) AttentionDataUser *User;

@property (nonatomic, strong) NSArray<AttentionDataComments *> *Comments;

@property (nonatomic, strong) AttentionDataForwardUser *ForwardUser;
@property (nonatomic, copy) NSString *ForwardMessage;
@end

@interface AttentionDataTotal : NSObject

@property (nonatomic, assign) NSInteger Share;

@property (nonatomic, assign) BOOL IsLike;

@property (nonatomic, assign) NSInteger Text;

@property (nonatomic, assign) NSInteger Like;

@property (nonatomic, assign) NSInteger Visit;

@end

@interface AttentionDataUser : NSObject

@property (nonatomic, copy) NSString *Introduction;

@property (nonatomic, copy) NSString *Nickname;

@property (nonatomic, copy) NSString *HeadPhoto;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger Sex;

@end

@interface AttentionDataLikes : NSObject

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, strong) AttentionDataUser *User;

@end



@interface AttentionDataComments : NSObject

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) NSInteger RelateId;

@property (nonatomic, strong) AttentionDataUser *ReplyUser;
@property (nonatomic, strong) AttentionDataUser *User;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *Id;

@end

@interface AttentionDataForwardUser : NSObject

@property (nonatomic, copy) NSString *Introduction;

@property (nonatomic, copy) NSString *Nickname;

@property (nonatomic, copy) NSString *HeadPhoto;

@property (nonatomic, assign) NSInteger Id;

@end

