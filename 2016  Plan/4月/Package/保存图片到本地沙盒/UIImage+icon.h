//
//  UIImage+icon.h
//  RunningMan
//
//  Created by tarena01 on 16/2/1.
//  Copyright © 2016年 WindManTeam. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (icon)

/** 保存图片到本地沙盒 */
+(void)saveImageByName:(NSString*)name andImage:(UIImage*)image;

/** 通过图片名获取本地图片 */
+(UIImage*)getImageByName:(NSString*)name;

@end
