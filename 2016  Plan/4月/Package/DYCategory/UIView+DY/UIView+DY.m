//
//  UIView+DY.h
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/6.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import "UIView+DY.h"

@implementation UIView (DY)
- (void)setFrameX:(CGFloat)frameX
{
    CGRect frame=self.frame;
    frame.origin.x=frameX;
    self.frame=frame;
}
- (CGFloat)frameX
{
    return self.frame.origin.x;
}
- (void)setFrameY:(CGFloat)frameY
{
    CGRect frame=self.frame;
    frame.origin.y=frameY;
    self.frame=frame;
}
- (CGFloat)frameY
{
    return self.frame.origin.y;
}
- (void)setFrameW:(CGFloat)frameW
{
    CGRect frame=self.frame;
    frame.size.width=frameW;
    self.frame=frame;
}
- (CGFloat)frameW
{
    return self.frame.size.width;
}
- (void)setFrameH:(CGFloat)frameH
{
    CGRect frame=self.frame;
    frame.size.height=frameH;
    self.frame=frame;
}
- (CGFloat)frameH
{
    return self.frame.size.height;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setFrameSize:(CGSize)frameSize
{
    CGRect aRect = self.frame;
    aRect.size = frameSize;
    self.frame = aRect;
}
- (CGSize)frameSize
{
    return self.frame.size;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com