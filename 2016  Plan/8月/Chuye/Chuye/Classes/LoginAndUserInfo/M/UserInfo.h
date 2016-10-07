//
//  UserInfo.h
//  Chuye
//
               

//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

#define kIsLogin @"isLogin"
#define kLastLoginUser  @"lastLoginUserName"
#define kPassword @"password"

@interface UserInfo : NSObject

singleton_interface(UserInfo);

@property (nonatomic,strong) NSDictionary  *info;

/**  用户登录 */
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userPassword;
@property (nonatomic,strong) NSString *nickname;
/**  用户注册 */
@property (nonatomic,strong) NSString *registerName;
@property (nonatomic,strong) NSString *registerPassword;
//@property (nonatomic,assign,getter=isRegisterType) BOOL registerType;

/**  用户是否是第一次登录 */
@property (nonatomic,assign,getter=isEverLogin) BOOL everLogin;

/**  新浪登录 */
@property (nonatomic,assign,getter=isSinaLogin) BOOL sinaLogin;
@property (nonatomic,copy) NSString *sinaToken;
@property (nonatomic,strong) NSString *access_token;

/**  从沙盒获取用户数据 */
+(id)loadUserInfoFromSandBoxWithName:(NSString *)name;

/**  bao存用户数据 */
+(void)saveToSandBoxWithUserInfo:(NSDictionary *)info andUserName:(NSString *)key;

+(void)saveLastLoginUser:(NSString *)userName;
+(id)loadlastLogin;

@end
