//
//  NSData+DES.m
//  SecurityTest
//
//  Created by honkib on 16/6/23.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "NSData+DES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (DES)



- (NSData *)DESEncryptWithKey:(NSString *)key
{
    NSData *data = nil;
    
    NSUInteger dataLength = [self length];
    unsigned char buffer[10240];//最长密文长度
    memset(buffer, 0, sizeof(char));
//    const void *iv = (const void *)[key UTF8String];
    static Byte iv[8]={1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [self bytes], dataLength,
                                          buffer, 10240,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
    }
    return data;
}



- (NSData *)DESDecryptWithKey:(NSString *)key
{
    NSData *plaindata = nil;
    
    unsigned char buffer[10240];//最长密文长度
    memset(buffer, 0, sizeof(char));
//    const void *iv = (const void *)[key UTF8String];
    static Byte iv[8]={1,2,3,4,5,6,7,8};

    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [self bytes], [self length],
                                          buffer, 10240,
                                          &numBytesDecrypted);
    if(cryptStatus == kCCSuccess) {
        plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
    }
    return plaindata;
}



//+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
//
//{
//    
//    NSString *ciphertext = nil;
//    
//    const char *textBytes = [plainText UTF8String];
//    
//    NSUInteger dataLength = [plainText length];
//    
//    unsigned char buffer[1024];
//    
//    memset(buffer, 0, sizeof(char));
//    static Byte iv[] = {1,2,3,4,5,6,7,8};
//    size_t numBytesEncrypted = 0;
//    
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                                          
//                                          kCCOptionPKCS7Padding,
//                                          
//                                          [key UTF8String], kCCKeySizeDES,
//                                          
//                                          iv,
//                                          
//                                          textBytes, dataLength,
//                                          
//                                          buffer, 1024,
//                                          
//                                          &numBytesEncrypted);
//    
//    if (cryptStatus == kCCSuccess) {
//        
//        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
//        NSLog(@"...%@",data.description);
////        ciphertext = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        ciphertext = [NSData base64EncodingWithData:data];
//    }
//    
//    return ciphertext;
//    
//}
//
//static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//
//+ (NSString *)base64EncodingWithData:(NSData *)data;
//
//{
//    
//    if (data.length == 0)
//        
//        return @"";
//    
//    
//    
//    char *characters = malloc(data.length*3/2);
//    
//    
//    
//    if (characters == NULL)
//        
//        return @"";
//    
//    
//    
//    int end = data.length - 3;
//    
//    int index = 0;
//    
//    int charCount = 0;
//    
//    int n = 0;
//    
//    
//    
//    while (index <= end) {
//        
//        int d = (((int)(((char *)[data bytes])[index]) & 0x0ff) << 16)
//        
//        | (((int)(((char *)[data bytes])[index + 1]) & 0x0ff) << 8)
//        
//        | ((int)(((char *)[data bytes])[index + 2]) & 0x0ff);
//        
//        
//        
//        characters[charCount++] = encodingTable[(d >> 18) & 63];
//        
//        characters[charCount++] = encodingTable[(d >> 12) & 63];
//        
//        characters[charCount++] = encodingTable[(d >> 6) & 63];
//        
//        characters[charCount++] = encodingTable[d & 63];
//        
//        
//        
//        index += 3;
//        
//        
//        
//        if(n++ >= 14)
//            
//        {
//            
//            n = 0;
//            
//            characters[charCount++] = ' ';
//            
//        }
//        
//    }
//    
//    
//    
//    if(index == data.length - 2)
//        
//    {
//        
//        int d = (((int)(((char *)[data bytes])[index]) & 0x0ff) << 16)
//        
//        | (((int)(((char *)[data bytes])[index + 1]) & 255) << 8);
//        
//        characters[charCount++] = encodingTable[(d >> 18) & 63];
//        
//        characters[charCount++] = encodingTable[(d >> 12) & 63];
//        
//        characters[charCount++] = encodingTable[(d >> 6) & 63];
//        
//        characters[charCount++] = '=';
//        
//    }
//    
//    else if(index == data.length - 1)
//    {
//        
//        int d = ((int)(((char *)[data bytes])[index]) & 0x0ff) << 16;
//        
//        characters[charCount++] = encodingTable[(d >> 18) & 63];
//        
//        characters[charCount++] = encodingTable[(d >> 12) & 63];
//        
//        characters[charCount++] = '=';
//        
//        characters[charCount++] = '=';
//        
//    }
//    
//    NSString * rtnStr = [[NSString alloc] initWithBytesNoCopy:characters length:charCount encoding:NSUTF8StringEncoding freeWhenDone:YES];
//    
//    return rtnStr;
//    
//}

@end
