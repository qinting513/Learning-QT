//
//  QTPerson.h
//  Runtime
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTPerson : NSObject  <NSCoding>

@property (nonatomic,assign) int      age;
@property (nonatomic,copy)   NSString *name;

@end
