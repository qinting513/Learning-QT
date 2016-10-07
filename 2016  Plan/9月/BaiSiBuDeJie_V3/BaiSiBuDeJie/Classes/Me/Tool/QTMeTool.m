//
//  QTMeTool.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTMeTool.h"
#import "HTTPTool.h"

@implementation QTMeTool

+(void)meToolWithParam:(QTMeParam *)param success:(FetchSuccessBlock )success failure:(FetchFailureBlock)failure{

            [HTTPTool GET:MainURL params:param.mj_keyValues  success:^(id json) {
                /** 空合运算符 */
                !success ?:  success(  [ QTMeResult mj_objectWithKeyValues:json] );
            } failure:failure];
}

@end
