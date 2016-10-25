//
//  CentralView.m
//  CoreBluetooth
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "CentralView.h"

@implementation CentralView

+(id)loadView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
