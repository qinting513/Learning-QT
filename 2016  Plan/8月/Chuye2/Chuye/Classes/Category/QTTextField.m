//
//  QTTextField.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/6/2.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTTextField.h"
static NSString * const PlaceholderLabelTextColor = @"_placeholderLabel.textColor";

@implementation QTTextField


-(void)awakeFromNib{
    [self setValue:[UIColor grayColor]  forKeyPath:PlaceholderLabelTextColor ];
    self.tintColor = self.textColor;
}

-(BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:PlaceholderLabelTextColor];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:PlaceholderLabelTextColor];
    return [super resignFirstResponder];
}

@end
