//
//  UIView+Round.h
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Round)
-(void)circleImage;
-(void)circleImageWithBorderWidth:(CGFloat)borderWidth  borderColor:(UIColor*)borderColor;
-(void)circleImageWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth  borderColor:(UIColor*)bordColor;
- (UIImage*)round;
@end
