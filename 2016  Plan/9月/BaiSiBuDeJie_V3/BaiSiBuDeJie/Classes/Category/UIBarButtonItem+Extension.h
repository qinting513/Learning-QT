//
//  UIBarButtonItem+Extension.h
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithImage:(NSString *)imageName highlightImageName:(NSString *)hlImageName
                       target:(id)target action:(SEL)action;
@end
