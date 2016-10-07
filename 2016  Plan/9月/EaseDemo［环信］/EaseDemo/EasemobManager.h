//
//  EasemobManager.h
//  EaseDemo
//
               

//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EaseMob.h>

@interface EasemobManager : NSObject
@property (nonatomic,strong) NSMutableArray  *requestArray;

+(EasemobManager*)sharedManager;

-(void)registerWithName:(NSString *)name pwd:(NSString *)pwd;
-(void)loginWithName:(NSString *)name pwd:(NSString *)pwd loginSuccessBlock:(void(^)())loginSuccessBlock;
//如果登录过了 则自动跳到好友列表界面
-(void)isAutoLoginWithUsername:(NSString*)userName password:(NSString *)pwd  loginSuccessBlock:(void(^)())loginSuccessBlock;
-(void)logout:(void(^)())logoutBlock;
//向好友发送添加请求
-(void)addFriendWithName:(NSString *)name andMessage:(NSString *)msg;
-(void)deleteFriendWithName:(NSString *)name deleteSuccessBlock:(void(^)())deleteOKBlock;

/**
 *  允许好友的添加请求
 */
-(void)allowFriendRequest:(NSString *)name allowBlock:(void(^)())allowBlock;
-(void)denyFriendRequest:(NSString *)name  denyBlock:(void(^)())denyBlock;

/** 发送一个消息 */
-(EMMessage *)sendMessageWithText:(NSString *)text andUsername:(NSString *)username;
/** 发送图片 */
-(EMMessage *)sendImageWithImage:(UIImage *)img andUserName:(NSString *)userName;
/** 发送语音 */
-(EMMessage *)sendVoiceWithVoiceData:(NSData*)data   duration:(NSTimeInterval)aDuration  andUserName:(NSString *)userName;


@end
