//
//  UIImage+icon.m
//  RunningMan
//
//  Created by tarena01 on 16/2/1.
//  Copyright © 2016年 WindManTeam. All rights reserved.
//

#import "UIImage+icon.h"

#define bgImagePath stringByAppendingPathComponent:@"bg.png"]

@implementation UIImage (icon)

+(void)saveImageByName:(NSString*)name andImage:(UIImage*)image
{
dispatch_async(dispatch_get_global_queue(0, 0), ^{
    NSString *doc =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject ];
    NSString *imageName = [NSString stringWithFormat:@"%@.png",name];
    NSString *imagePath = [doc stringByAppendingPathComponent:imageName];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:imagePath atomically:YES];
});

}

+(UIImage*)getImageByName:(NSString*)name
{
        NSString *doc =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject ];
        NSString *imageName = [NSString stringWithFormat:@"%@.png",name];
        NSString *imagePath = [doc stringByAppendingPathComponent:imageName];
        NSData *data = [[NSData alloc]initWithContentsOfFile:imagePath];
        UIImage *image = [UIImage imageWithData:data];
        return image;
}

@end
