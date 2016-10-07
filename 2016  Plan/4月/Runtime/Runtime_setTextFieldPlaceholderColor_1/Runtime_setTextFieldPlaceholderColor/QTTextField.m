//
//  QTTextField.m
//  Runtime_setTextFieldPlaceholderColor
//
//  Created by Qinting on 16/5/29.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTTextField.h"

static NSString * const  PlaceholderLabelTextColor = @"_placeholderLabel.textColor";

@implementation QTTextField

//自定义TextFiled，重写draw方法
-(void)drawPlaceholderInRect:(CGRect)rect{
//    方式2
//    [self.placeholder drawInRect:CGRectMake(10, rect.size.height/4, rect.size.width, rect.size.height) withAttributes:@{
//                                                       NSForegroundColorAttributeName:[UIColor redColor],
//                                                       NSFontAttributeName : self.font
//                                                       }];

    
}

///** 通过运行时 找出 _placeholderLabel属性 */
//+(void)initialize{
//    unsigned int count;
//    /** 拷贝出所有成员变量的列表 */
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for ( int i = 0; i<count; i++) {
////        Ivar ivar = *(ivars +i);
//        /** 取出成员变量 */
//        Ivar ivar = ivars[i];
//        NSLog(@"%s",ivar_getName(ivar) );
//    }
//    free(ivars);
//}

//- (void)awakeFromNib{
//    /** 方式1: */
////    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
////    placeholderLabel.textColor = [UIColor redColor];
//    
//    /** 方式2: */
//    [self setValue:[UIColor grayColor] forKeyPath:PlaceholderLabelTextColor];
//    
//    /** 方式3:在storyboard右侧属性列表有个keyPath，去那里设置 */
//    
//    /** 设置光标颜色跟文字颜色一样 */
//    self.tintColor = self.textColor;
//}

/** 设置后一直是高亮的了 监听不了不成高亮的时候设置其他颜色 */
//-(void)setHighlighted:(BOOL)highlighted{
//    NSLog(@"become hlight");
//[self setValue:[UIColor whiteColor] forKeyPath:PlaceholderLabelTextColor];
//}

///** 当光标聚焦时 */
//-(BOOL)becomeFirstResponder{
//    [self setValue:[UIColor whiteColor] forKeyPath:PlaceholderLabelTextColor];
//    return [super becomeFirstResponder];
//}
//
///** 失去焦点时 */
//-(BOOL)resignFirstResponder{
//    [self setValue:[UIColor grayColor] forKeyPath:PlaceholderLabelTextColor];
//    return [super resignFirstResponder];
//}

//-(void)setPlaceholderColor:(UIColor *)placeholderColor{
//    _placeholderColor = placeholderColor;
//    [self setValue:placeholderColor  forKeyPath:PlaceholderLabelTextColor];
//}

@end
