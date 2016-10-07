//
//  Weibo.h
//  WeiboDemo
//
               

//  Created by Qinting on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weibo : NSObject

@property (nonatomic,copy) NSString  *icon;
@property (nonatomic,copy) NSString  *name;
@property (nonatomic,copy) NSString  *time;
@property (nonatomic,copy) NSString  *source;
@property (nonatomic,copy) NSString  *content;
@property (nonatomic,copy) NSString  *image;

-(id)initWithDict:(NSDictionary*)dict;
+(id)weiboWithDict:(NSDictionary*)dict;

@end
