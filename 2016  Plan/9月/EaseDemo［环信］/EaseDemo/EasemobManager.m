//
//  EasemobManager.m
//  EaseDemo
//
//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "EasemobManager.h"

#import <MBProgressHUD.h>
@interface EasemobManager()<IChatManagerDelegate,IEMChatProgressDelegate,EMChatManagerChatDelegate>
//@property (nonatomic,strong) MBProgressHUD  *hud;
@end
@implementation EasemobManager
static EasemobManager * _manager;
+(EasemobManager*)sharedManager{
    @synchronized (self) {
        if(!_manager){
            _manager = [[EasemobManager alloc]init];
              [[EaseMob sharedInstance].chatManager addDelegate:_manager  delegateQueue:nil];
            
        }
    }
    return _manager;
}

//- (MBProgressHUD *)hud {
//    if( !_hud) {
//        _hud = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow] ;
//    }
//    return  _hud;
//}

- (NSMutableArray *)requestArray {
    if(_requestArray == nil) {
        _requestArray = [[NSMutableArray alloc] init];
    }
    return _requestArray;
}

-(instancetype)init{
    self = [super init];
    if (self ) {
        
    }
    return self;
}

#pragma  mark  - 接收到好友请求
//好友添加申请
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if(!message) message = @"来来来，相互伤害！";
    [self.requestArray addObject:@{@"userName":username,@"message":message }];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FriendStatusChange" object:nil];
}

#pragma  mark  - 添加好友请求的同意或拒绝
/*!
 @method
 @brief 好友请求被接受时的回调
 @discussion
 @param username 之前发出的好友请求被用户username接受了
 */
- (void)didAcceptedByBuddy:(NSString *)username{
    //需要让好友列表页面更新
//    self.hud.label.text = [NSString stringWithFormat:@"%@允许添加你",username];
//    [self.hud showAnimated:YES];
//    [self.hud hideAnimated:YES afterDelay:2.0f];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FriendStatusChange" object:nil];
}

/*!
 @method
 @brief 好友请求被拒绝时的回调
 @discussion
 @param username 之前发出的好友请求被用户username拒绝了
 */
- (void)didRejectedByBuddy:(NSString *)username{
    NSLog(@"之前发出的好友请求被用户username拒绝了");
//    self.hud.label.text = [NSString stringWithFormat:@"%@拒绝添加你",username];
//    [self.hud hideAnimated:YES afterDelay:2.0f];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"FriendStatusRejectAdd" object:nil];
}

//允许添加
-(void)allowFriendRequest:(NSString *)name allowBlock:(void(^)())allowBlock{
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:name error:&error];
    if (isSuccess && !error) {
        NSLog(@"发送同意成功");
        !allowBlock ?: allowBlock();
    }
}
-(void)denyFriendRequest:(NSString *)name  denyBlock:(void(^)())denyBlock{
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager rejectBuddyRequest:name reason:@"你太丑了" error:&error];
    if (isSuccess && !error) {
        NSLog(@"发送拒绝成功");
        !denyBlock?: denyBlock();
    }
}

#pragma mark - 注册登录
-(void)registerWithName:(NSString *)name pwd:(NSString *)pwd{
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:name   password:pwd withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功");
        }
    } onQueue:nil];
}

-(void)loginWithName:(NSString *)name pwd:(NSString *)pwd loginSuccessBlock:(void(^)())loginSuccessBlock{
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:name password:pwd   completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            NSLog(@"登录成功");
            // 登录成功后，自动去取好友列表
            // SDK获取结束后，会回调
            // - (void)didFetchedBuddyList:(NSArray *)buddyList error:(EMError *)error方法。
            [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
            !loginSuccessBlock ? : loginSuccessBlock();
        }
    } onQueue:nil];
}


-(void)isAutoLoginWithUsername:(NSString*)userName password:(NSString *)pwd  loginSuccessBlock:(  void(^)()   )loginSuccessBlock{
    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    if (!isAutoLogin) {
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userName
                                                            password:pwd
                                                          completion:^(NSDictionary *loginInfo, EMError *error) {
                                                              !loginSuccessBlock ?:loginSuccessBlock();
                                                          } onQueue:nil];
    }else{
                  !loginSuccessBlock ?:loginSuccessBlock();
    }
}

-(void)logout:(void(^)())logoutBlock{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            NSLog(@"退出");
            !logoutBlock ?: logoutBlock();
        }
    } onQueue:nil];
}

-(void)addFriendWithName:(NSString *)name andMessage:(NSString *)msg{
    EMError *error = nil;
    //        如果您已经发过，并且对方没有处理，您将不能再次发送。
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:name message:msg  error:&error];
    if (isSuccess && !error) {
        NSLog(@"发送添加请求成功");
    }else{
        NSLog(@"发送添加请求： %@",error);
    }
}

-(void)deleteFriendWithName:(NSString *)name deleteSuccessBlock:(void(^)())deleteOKBlock{
    EMError *error = nil;
    // 删除好友
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager removeBuddy:name  removeFromRemote:YES error:&error];
    if (isSuccess && !error) {
        NSLog(@"删除成功");
        !deleteOKBlock ?: deleteOKBlock();
    }
}

-(void)dealloc{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

#pragma mark - 接收消息
-(void)didReceiveMessage:(EMMessage *)message{
    NSLog(@"收到的消息：%@",message);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveMessageNotification" object:message];
}

#pragma mark - 发送消息
-(EMMessage *)sendMessageWithText:(NSString *)text andUsername:(NSString *)username{
    EMChatText *txtChat = [[EMChatText alloc] initWithText:text];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:txtChat];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:username  bodies:@[body]];
    message.messageType = eMessageTypeChat; // 设置为单聊消息
    //message.messageType = eConversationTypeGroupChat;// 设置为群聊消息
    //message.messageType = eConversationTypeChatRoom;// 设置为聊天室消息
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:self];
    return message;
}

-(EMMessage *)sendImageWithImage:(UIImage *)img andUserName:(NSString *)userName{

    EMChatImage *imgChat = [[EMChatImage alloc] initWithUIImage:img displayName:@"displayName"];
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithChatObject:imgChat];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:userName  bodies:@[body]];
    message.messageType = eMessageTypeChat; // 设置为单聊消息
        [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:self];
    return message;
}

-(EMMessage *)sendVoiceWithVoiceData:(NSData*)data   duration:(NSTimeInterval)aDuration  andUserName:(NSString *)userName{
    EMChatVoice *voice = [[EMChatVoice alloc] initWithData:data displayName:@"audio.amr"];
    voice.duration = aDuration;
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithChatObject:voice];
    
    // 生成message
    EMMessage *message = [[EMMessage alloc] initWithReceiver:userName bodies:@[body]];
    NSLog(@"message:  %@",message);
    message.messageType = eMessageTypeChat; // 设置为单聊消息
        [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:self];
    return message;
}


-(void)setProgress:(float)progress forMessage:(EMMessage *)message forMessageBody:(id<IEMMessageBody>)messageBody{
        NSLog(@"发送进度：%f",progress);
}

/*!
 @method
 @brief 将要接收离线消息的回调
 @discussion
 @result
 */
- (void)willReceiveOfflineMessages{
    NSLog(@"=====================%s",__func__);
}

/*!
 @method
 @brief 接收到离线非透传消息的回调
 @discussion
 @param offlineMessages 接收到的离线列表
 @result
 */
- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveOfflineMessagesNotification" object:offlineMessages];
}

/*!
 @method
 @brief 离线非透传消息接收完成的回调
 @discussion
 @param offlineMessages 接收到的离线列表
 @result
 */
- (void)didFinishedReceiveOfflineMessages{
    NSLog(@"=====================%s",__func__);
}
//离线透传消息会走以下回调：

/*!
 @method
 @brief 接收到离线透传消息的回调
 @discussion
 @param offlineCmdMessages 接收到的离线透传消息列表
 @result
 */
- (void)didReceiveOfflineCmdMessages:(NSArray *)offlineCmdMessages{
    NSLog(@"=====================%s:%@",__func__,offlineCmdMessages);
}

/*!
 @method
 @brief 离线透传消息接收完成的回调
 @discussion
 @param offlineCmdMessages 接收到的离线透传消息列表
 @result
 */
- (void)didFinishedReceiveOfflineCmdMessages{
    NSLog(@"=====================%s",__func__);
}

/*!
 @method
 @brief 未读消息数改变时的回调
 @discussion 当EMConversation对象的enableUnreadMessagesCountEvent为YES时，会触发此回调
 @result
 */
- (void)didUnreadMessagesCountChanged{
NSLog(@"=====================%s",__func__);
}
@end
