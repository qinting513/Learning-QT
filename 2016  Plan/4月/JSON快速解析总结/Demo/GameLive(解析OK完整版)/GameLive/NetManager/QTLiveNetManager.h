//
//  QTLiveNetManager.h
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
#import "QTVideoModel.h"

@interface QTLiveNetManager : NSObject

/** 获取栏目列表 */
+ (id)getCategoriesCompletionHandle:( void (^)(NSArray<CategoryModel*> *model,NSError *error) )completionHandle;

/** 获取Video列表 */
+ (id)getVideosCompletionHandle:( void (^)( QTVideoModel *model,NSError *error) )completionHandle;
@end
