//
//  QTPlaceholderTextView.h
//  PlaceholderTextView
//
//  Created by Qinting on 16/7/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

/** 因为textView继承于UIScrollView，所以有导航栏的时候 系统自动向下调整了64像素，
 self.automaticallyAdjustsScrollViewInsets  设置为NO，则不会自动调整
 */
/**
 能够输入文字的空间站，只有：
 1.UITextField
 > 只能显示单行文字
 > 有占位文字
 
 2.UITextView
 > 能显示任意行文字
 > 没有占位文字
 
 需求 文本输入控件拥有的功能：
 1.能显示多行文字
 2.有占位文字
 自定义控件 继承于UITextView
 */

#import <UIKit/UIKit.h>

@interface QTPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic ,copy) NSString   *placeholder;
/** 占位文字颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;

@end
