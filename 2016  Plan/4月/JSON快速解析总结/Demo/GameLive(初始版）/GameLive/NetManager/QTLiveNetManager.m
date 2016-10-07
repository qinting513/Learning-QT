 //
//  QTLiveNetManager.m
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTLiveNetManager.h"



@implementation QTLiveNetManager
/** Xcode7新特性，可以写成这样 NSArray<CategoryModel*> *model 
    返回值是数组类型，这个数组类型每个元素都是CategoryModel */
+ (id)getCategoriesCompletionHandle:( void (^)(id responseObj,NSError *error) )completionHandle{

    return [self GET:@"http://www.quanmin.tv/json/categories/list.json" parameters:nil progress:nil completionHandle:^( id responseObj, NSError *error) {
       
        /** 空和运算符  ？：前面的为假 则执行后面的语句，即completionHandle是有数据的时候，加个非符号，就是假的，就执行后面的语句 */
        !completionHandle ?:  completionHandle(responseObj,error);
        
    }];
}

+ (id)getVideosCompletionHandle:( void (^)( id responseObj, NSError *error) )completionHandle{
    
    return [self GET:@"http://c.m.163.com/nc/video/home/1-10.html" parameters:nil progress:nil completionHandle:^( id responseObj, NSError *error) {
        
           /** 空和运算符  ？：前面的为假 则执行后面的语句，即completionHandle是有数据的时候，加个非符号，就是假的，就执行后面的语句 */
        !completionHandle ?:  completionHandle(responseObj ,error);
        
    }];

}
@end
