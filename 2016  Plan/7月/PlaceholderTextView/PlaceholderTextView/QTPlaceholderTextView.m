//
//  QTPlaceholderTextView.m
//  PlaceholderTextView
//
//  Created by Qinting on 16/7/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTPlaceholderTextView.h"
#import "UIView+Extension.h"

#define  QTNotiCenter  [NSNotificationCenter defaultCenter]
@interface QTPlaceholderTextView()
@end


/** 
 1.设置文字显示，并调整好rect
 2.设置监听，显示或隐藏placeholder
        》不在VC里设置代理，因为我要封装起来，让别人直接设置placeholder即可，况且占位文字是内部属性，
            什么时候该隐藏，直接在内部封装好即可，不用让外部类去设置什么时候消失跟出线
        》不用代理，因为在本类里设置代理 可能被VC里的代理覆盖，故用通知
            内部通知跟外部通知互不干扰
 3.写监听方法，监听到有文字输入时，调用setNeedsDisplay方法
 4.比较严谨的封装(考虑父类哪些属性可能会被修改)：哪些属性可能被修改，要重写setter方法，实时监听修改
 */
/** 
[self setNeedsDisplay];方法： 会在恰当的时刻自动调用drawRect方法
[self setNeedsLayout];方法： 会在恰当的时刻自动调用layoutSubViews方法
 */

@implementation QTPlaceholderTextView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        
        /** 设置默认颜色，如果别人不设置 则用默认的 */
        self.placeholderColor = [UIColor lightGrayColor];
        
        /** font默认是空的，需要设置个默认值 */
        self.font = [UIFont systemFontOfSize:15];
        [QTNotiCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification  object:nil];
    }
    return self;
}

-(void)dealloc{
    [QTNotiCenter removeObserver:self];

}

-(void)textDidChange
{
    NSLog(@"textDidChange");
    //此方法会自动drewRect
        [self setNeedsDisplay];
}

    /** 绘制占位文字，每次drawRect：之前系统都会自动清除掉之前绘制的内容 ，*/
-(void)drawRect:(CGRect)rect
{
    /** 如果有文字了，则不再去绘制,这样写法不严谨，还考虑到富文本 */
//    if(self.text.length || self.attributedText.length) return;
    if (self.hasText) return;
    
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    
    /** 处理rect */
    rect.origin.x = 3;
    rect.origin.y = 7;
    rect.size.width = self.width - 2*rect.origin.x;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs [NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:rect  withAttributes:attrs];
}

/** 重写setter方法，实时监听修改 */
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font{
    /** 这个属性是父类的，重写父类的 */
    [super setFont:font];
    [self setNeedsDisplay];
}

/** 通过代码改文字 不会发通知 */
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
@end
