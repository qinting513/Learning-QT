//
//  CategoryModel.h
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 
 解析规则：
 1.遇到字典则新建类
 2.修改不规则命名
 */

/** 使用YYKit 可以不用重写setValue forUndefineKey方法,在pch引入yykit头文件 */

/** ESJSONFormat 使用注意
 1.要确保录入的插件的内容是JSON类型的第一个 是字典
 2.类名要有层次感，这样有效防止类名重复
*/


/** 情况1:  根是数组的情况 */
@interface CategoryModel : NSObject




@end
