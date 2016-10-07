//
//  Product.m
//  tableView添加搜索框
//
//  Created by tarena01 on 15/11/18.
//  Copyright (c) 2015年 qt. All rights reserved.
//

#import "Product.h"

@implementation Product

+(NSArray*)demoData
{

    Product* p1 = [[Product alloc]init];
    p1.name = @"iphone6";
    p1.type = ProductTypeDevices;
    
    Product* p2 = [[Product alloc]init];
    p2.name = @"iphone6s";
    p2.type = ProductTypeDevices;
    
    Product* p3 = [[Product alloc]init];
    p3.name = @"iphone6 Plus";
    p3.type = ProductTypeDevices;
    
    Product* p4 = [[Product alloc]init];
    p4.name = @"OS X EI Captain";
    p4.type = ProductTypeSoftware;
    
    Product* p5 = [[Product alloc]init];
    p5.name = @"Air Port Time Capsule";
    p5.type = ProductTypeOther;
    
    Product* p6 = [[Product alloc]init];
    p6.name = @"ios";
    p6.type = ProductTypeSoftware;
    
    Product* p7 = [[Product alloc]init];
    p7.name = @"中华小当家";
    p7.type = ProductTypeOther;

    return @[p1,p2,p3,p4,p5,p6,p7];
}
@end
