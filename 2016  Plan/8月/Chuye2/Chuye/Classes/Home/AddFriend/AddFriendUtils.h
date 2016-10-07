//
//  AddFriendUtils.h
//  Chuye
//
               

//  Created by Qinting on 16/8/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
//typedef void(^CompletionHandle) (id model);
@interface AddFriendUtils : NSObject
+(id)GETFriends:(NSString *)url  completionHandler:(void(^)(id mode,NSError *err))completionHandler;
@end
