//
//  ChoseView.m
//  BackView
//
//  Created by Qinting on 16/8/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ChoseView.h"



@implementation ChoseView


+(id)loadView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
