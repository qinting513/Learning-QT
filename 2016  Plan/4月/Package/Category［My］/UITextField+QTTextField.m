//
//  UITextField+QTTextField.m
//  RunningMan
//
//  Created by Qinting on 16/7/14.
//  Copyright © 2016年 WindManTeam. All rights reserved.
//

#import "UITextField+QTTextField.h"

@implementation UITextField (QTTextField)

-(void)setTextFieldLeftImageViewWithFrame:(CGRect)frame andImageName:(NSString*)imageName
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.frame = frame;
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
