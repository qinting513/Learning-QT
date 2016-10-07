//
//  Provinces.h
//  tableView
//
//  Created by tarena19 on 2015/10/23.
//  Copyright (c) 2015年 tarena19. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Provinces : NSObject

/** 头部标题 */
@property (nonatomic,copy) NSString* header;
/** 尾部标题 */
@property (nonatomic,copy) NSString* footer;
/** 城市数组 */
@property (nonatomic,strong) NSArray* cities;

-(id)initWithDictionary:(NSDictionary*)dict;
+(id)provinceWithDictionary:(NSDictionary*)dict;

//+(id)provinceWithHeader:(NSString*)header footer:(NSString*)footer cities:(NSArray*)cities;

@end
