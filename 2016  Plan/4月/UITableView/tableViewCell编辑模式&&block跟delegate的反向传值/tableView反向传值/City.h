//
//  City.h
//  City_TableView
//
//  Created by tarena01 on 15/11/16.
//  Copyright (c) 2015年 tarena01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property(nonatomic,strong) NSString* cityName;
@property(nonatomic)NSInteger population;

-(id)initWithDictionary:(NSDictionary*)dict;
+(id)cityWithDictionary:(NSDictionary*)dict;

@end
