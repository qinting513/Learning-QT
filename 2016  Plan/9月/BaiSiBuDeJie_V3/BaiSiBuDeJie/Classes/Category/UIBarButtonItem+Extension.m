//
//  UIBarButtonItem+Extension.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)imageName highlightImageName:(NSString *)hlImageName
                           target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hlImageName] forState:UIControlStateHighlighted];
    [button addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    
    /** 注意一定要设置 frame，要不然不显示，用给结构体的方式赋值 */
    button.bounds =(CGRect){CGPointZero,  [button currentBackgroundImage].size};
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
