//
//  UIImage+qt.m
//  RuntimeCategoryProperty
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "UIImage+qt.h"
#import <objc/runtime.h>

@implementation UIImage (qt)

-(int)num{
  id ob = objc_getAssociatedObject(self, _cmd);
    return [ob intValue];
}

-(void)setNum:(int)num{
    objc_setAssociatedObject(self, @selector(num), [NSNumber numberWithInt:num], OBJC_ASSOCIATION_ASSIGN);
    
}

-(void)getImageNum{
    NSLog(@"getImageNum: %d",self.num);
}
@end
