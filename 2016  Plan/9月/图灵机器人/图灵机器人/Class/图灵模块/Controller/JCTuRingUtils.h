//
//  JCTuRingUtils.h
//  图灵机器人
//
//  Created by Guo.JC on 16/8/31.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BLOCK) (id obj);

@interface JCTuRingUtils : NSObject
+(void)sendMessegeToTuringWith:(NSString *)text andComplete:(BLOCK)callback;
@end
