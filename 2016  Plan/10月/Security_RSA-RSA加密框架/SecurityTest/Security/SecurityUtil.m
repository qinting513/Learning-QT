//
//  SecurityUtil.m
//  WebClickTest
//
//  Created by honkib on 16/6/29.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "SecurityUtil.h"
#import "NSData+DES.h"
#import "HBRSAHandler.h"

#define publicKeyPath [[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@"pem"]

#define privateKeyPath [[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@"pem"]

@implementation SecurityUtil


#pragma mark - DES加密
//将string转成带密码的String
+ (NSString *)encryptDESString:(NSString *)string app_key:(NSString *)key {
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data DESEncryptWithKey:key];

    return [encryptedData base64EncodedStringWithOptions:0];
}

#pragma mark - DES解密
//将带密码的string转成string
+ (NSString *)decryptDESString:(NSString *)string  app_key:(NSString *)key {
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    NSData *nsdataDecoded = [data initWithBase64EncodedData:data options:0];
    //使用密码对data进行解密
    NSData *decryData = [data DESDecryptWithKey:key];
    //将解了密码的nsdata转化为nsstring
    return [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
}

#pragma mark - RSA

+ (HBRSAHandler *)shareHandler {
    static HBRSAHandler *handler;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        handler = [HBRSAHandler new];
        [handler importKeyWithType:KeyTypePublic andPath:publicKeyPath];
        [handler importKeyWithType:KeyTypePrivate andPath:privateKeyPath];
    });
    
    return handler;
}

#pragma mark - RSA_公钥加密

+ (NSString *)encryptRSAPublicKeyWithString:(NSString *)conntct {
    return [[self shareHandler] encryptWithPublicKey:conntct];
}

#pragma mark - RSA_私钥解密

+ (NSString *)decryptRSAPrivateKeyWithString:(NSString *)content {
    return [[self shareHandler] decryptWithPrivateKey:content];
}
#pragma mark - RSA_私钥加签名
+ (NSString *)signByMD5WithString:(NSString *)content {
    return [[self shareHandler] signMD5String:content];
}
#pragma mark - RSA_公钥验签
+ (BOOL)verifyByMD5String:(NSString *)content withSign:(NSString *)signStr {
    return [[self shareHandler] verifyMD5String:content withSign:signStr];
}
@end
