//
//  NSData+DES.h
//  SecurityTest
//
//  Created by honkib on 16/6/23.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DES)

/************************************************************
 函数描述 : 数据进行DES加密
 输入参数 : (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/

- (NSData *)DESEncryptWithKey:(NSString *)key;

/************************************************************
 函数描述 : 数据进行DES解密
 输入参数 : (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 **********************************************************/
- (NSData *)DESDecryptWithKey:(NSString *)key;


@end
