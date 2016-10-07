//
//  QTButtonView.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTButtonView.h"

@implementation QTButtonView

+ (id)buttonView
{
     return    [[[NSBundle mainBundle] loadNibNamed:@"QTButtonView" owner: nil options:nil] lastObject];
}

@end
