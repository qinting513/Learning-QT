//
//  QTMeTagListModel.h
//  BaiSiBuDeJie
//
               

//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTMeTagListModel : NSObject

/** 主题id ，用于webView请求时的id */
@property (nonatomic, copy) NSString *theme_id;
/** 主题名字 */
@property (nonatomic, copy) NSString *theme_name;

@end
