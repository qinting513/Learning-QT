//
//  Product.h
//  tableView添加搜索框
//
//  Created by tarena01 on 15/11/18.
//  Copyright (c) 2015年 qt. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义枚举 用于记录商品的类别
typedef NS_ENUM(NSInteger, ProductType)
{
    ProductTypeDevices,
    ProductTypeSoftware,
    ProductTypeOther

};
//商品类包括商品名和商品类型
@interface Product : NSObject

@property (nonatomic,strong) NSString* name;
@property (nonatomic) ProductType type;

+(NSArray*)demoData;
@end
