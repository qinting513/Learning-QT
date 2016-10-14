//
//  SecurityUtil.h
//  WebClickTest
//
//  Created by honkib on 16/6/29.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject

#pragma mark - DES
//将string转成带密码的string
/**
 *  DES加密(NSString *)
 *
 *  @return (NSString *)
 */
+ (NSString *)encryptDESString:(NSString *)string app_key:(NSString *)key;

/**
 *  DES解密(NSString *)
 *  @return (NSString *)
 */
+ (NSString *)decryptDESString:(NSString *)string app_key:(NSString *)key;

/**
 *  RSA公钥加密(NSString *)
 *
 *  @return (NSString *)
 */
+ (NSString *)encryptRSAPublicKeyWithString:(NSString *)conntct;
/**
 *  RSA私钥解密(NSString *)
 *
 *  @return (NSString *)
 */
+ (NSString *)decryptRSAPrivateKeyWithString:(NSString *)content;
/**
 *  RSA私钥MD5签名(NSString *)
 *
 *  @return (NSString *)
 */
+ (NSString *)signByMD5WithString:(NSString *)content;
/**
 *  RSA公钥MD5验签(NSString *content NSString *signStr)
 *
 *  @return (BOOL )
 */
+ (BOOL)verifyByMD5String:(NSString *)content withSign:(NSString *)signStr;

@end
