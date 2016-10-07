//
//  UIImage+Compose.h
//  Chuye
//
//  Created by Qinting on 16/8/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compose)
+(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;
@end
