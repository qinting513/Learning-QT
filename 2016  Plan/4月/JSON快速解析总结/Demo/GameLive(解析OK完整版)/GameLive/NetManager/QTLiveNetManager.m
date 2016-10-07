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
+ (id)getCategoriesCompletionHandle:( void (^)(NSArray<CategoryModel*> *model,NSError *error) )completionHandle{

    return [self GET:@"http://www.quanmin.tv/json/categories/list.json" parameters:nil progress:nil completionHandle:^( id responseObj, NSError *error) {
        
        /** 如果根的类型是数组类型，就用modelArrayWithClass方法 */
        NSArray<CategoryModel *> *tempArray = [NSArray modelArrayWithClass:[CategoryModel class] json:responseObj];
        /** 空和运算符  ？：前面的为假 则执行后面的语句，即completionHandle是有数据的时候，加个非符号，就是假的，就执行后面的语句 */
        !completionHandle ?:  completionHandle(tempArray,error);
        /** 在此打断点，查看tempArray 是不是每个元素都是CategoryModel类型 */
    }];
}

+ (id)getVideosCompletionHandle:( void (^)( QTVideoModel *model,NSError *error) )completionHandle{
    
    return [self GET:@"http://c.m.163.com/nc/video/home/1-10.html" parameters:nil progress:nil completionHandle:^( id responseObj, NSError *error) {
        
        
        QTVideoModel * model = [ QTVideoModel modelWithJSON:responseObj];        /** 空和运算符  ？：前面的为假 则执行后面的语句，即completionHandle是有数据的时候，加个非符号，就是假的，就执行后面的语句 */
        !completionHandle ?:  completionHandle(model ,error);
        /** 在此打断点，查看tempArray 是不是每个元素都是QTVideoModel 类型 */
    }];

}
@end
