//
//  QTLabel.m
//  UIMenuControllerDemo
//
//  Created by Qinting on 16/7/10.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTLabel.h"

/** 步骤
 1.xib或代码创建时初始化：打开用户交互，添加tap
 2.tap事件方法里 2步骤： 
    1》 成为第一响应者
    2》 添加UIMenuController
 3.重写2个方法， canBecomeFirstResponder， canPerformAction
 4. 写canPerformAction对应的哪些操作 比如拷贝 粘贴等
 
 */

@implementation QTLabel

/** 不管是代码创建，还是xib创建QTLabel都可以使用， 所以重写这2个方法  */
/** 通过xib 创建label */
-(void)awakeFromNib
{
    [self setup];
}

/** 通过代码 创建label */
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/** 初始化，一点击就可以弹出那些操作 */
-(void)setup
{
    //1.打开用户交互
    self.userInteractionEnabled = YES;
    //2. 添加点击Tap   或者可以设置为长按的 LongPress
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapHandle:)] ];
}

-(void)tapHandle:(id)sender
{
//NSLog(@"tap");
    //1. 让label有资格成为第一响应者，作用：告诉UIMenuController 支持哪些操作，这些操作如何处理
    [self becomeFirstResponder];
    
    //2. 添加UIMenuController
    UIMenuController  * menu = [UIMenuController sharedMenuController];
 
    [menu setMenuVisible:YES animated:YES];
       /*3.告诉它能显示可见 在哪些  区域,给它一个矩形框，
            它就自己决定显示在上下左右边 
        targetRect: 是menu需要指向的矩形框
        targetView : targetRect会以targetView的左上角为矩形框的坐标原点
        2种写法：self.bounds以自己左上角为坐标原点
                          self.frame 以父控件左上角为坐标原点
        */
//    [menu setTargetRect:self.bounds inView:self];
    [menu setTargetRect:self.frame inView:self.superview];
    /** 以父视图为参考，(0, 0, 100, 100)的矩形区域 的旁边显示  */
//    [menu setTargetRect:CGRectMake(0, 0, 100, 100) inView:self.superview];
}

/** 因为有些控件默认不能成为第一响应者，
       重写这个方法，让其成为第一响应者 */
- (BOOL)canBecomeFirstResponder
{
    return  YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(UIMenuController*)sender
{
//    NSLog(@"%@",NSStringFromSelector(action));
    /** 当此方法只写 return YES;  点击copy cut等操作的时候就会崩溃 */
    if ( action == @selector(cut:)  || action == @selector(copy:)  || action == @selector(paste:) ){
         return YES;
    }
    return NO;
}


- (void)cut:(UIMenuController*)sender
{
        /** 将自己的文字保存到剪切板 */
    [self copy:sender];
    //剪切 将文字清除
    self.text  = nil;
}

-(void)copy:(UIMenuController*)sender
{
    /** 将自己的文字保存到剪切板 */
    UIPasteboard * p = [UIPasteboard generalPasteboard];
    p.string = self.text;
}

-(void)paste:(UIMenuController*)sender
{
    UIPasteboard * p  = [UIPasteboard generalPasteboard];
    self.text = p.string;
}

@end
