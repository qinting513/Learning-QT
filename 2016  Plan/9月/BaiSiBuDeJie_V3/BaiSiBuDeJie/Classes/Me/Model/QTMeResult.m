//
//  QTMeResult.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTMeResult.h"
#import "QTMeSquareListModel.h"
#import "QTMeTagListModel.h"

@implementation QTMeResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"square_list" : [QTMeSquareListModel class],
                     @"tag_list" : [QTMeTagListModel class]
             };
}

@end
