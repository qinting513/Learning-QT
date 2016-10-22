//
//  DetailUtil.m
//  Decoration
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DetailUtil.h"
#import "Detail.h"
#import "NSObject+Parse.h"

@implementation DetailUtil
+(id)parseDetail{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id model =  [NSJSONSerialization JSONObjectWithData:data options:0 error:0];
    return [Detail parse:model];
}
@end
