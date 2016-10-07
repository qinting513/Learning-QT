//
//  QTMeTool.h
//  BaiSiBuDeJie
//
               

//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QTMeResult.h"
#import "QTMeParam.h"

typedef void(^FetchSuccessBlock)(QTMeResult *result);
typedef void(^FetchFailureBlock)(NSError *error);

@interface QTMeTool : NSObject

+(void)meToolWithParam:(QTMeParam *)param success:(FetchSuccessBlock )success failure:(FetchFailureBlock)failure;

@end
