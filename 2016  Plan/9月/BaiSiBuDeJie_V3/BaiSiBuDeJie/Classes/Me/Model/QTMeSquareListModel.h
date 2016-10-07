//
//  QTMeSquareListModel.h
//  BaiSiBuDeJie
//
               

//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTMeSquareListModel : NSObject

/** 对应按钮点击后webView所加载的url */
@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *android;
/** 所支持的iPhone版本号 */
@property (nonatomic, copy) NSString *iphone;
/** 按钮的编号 */
@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *market;

@property (nonatomic, copy) NSString *ipad;
/** 按钮的名称 */
@property (nonatomic, copy) NSString *name;
/** 按钮的图片地址 */
@property (nonatomic, copy) NSString *icon;
@end
