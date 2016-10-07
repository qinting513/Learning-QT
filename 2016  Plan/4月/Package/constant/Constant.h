//
//  Constant.h
//  TRProject
//
//  Created by jiyingxin on 16/2/17.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

/** 注意在宏定义里不要加分号，要不然出错 */

#define kEaseMobKey @"1660626091#trlive"

#define kShareSDKAppKey @"104b1a1b239c0"
#define kShareSDKAppSecret @"44d7b4b687218177ecf039149215bbf5"

#define kBaiDuMapKey @"wmyVLnfC1LK3yUGEBkxG5NkS"

//屏幕宽度
#define kScreenW [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kScreenH [UIScreen mainScreen].bounds.size.height
//三原色的设置
#define kRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//Documents文件夹的路径
#define kDocPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
//appdelegate的实例对象
#define kAppdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//把self转化为 __weak __block的方式, 方便的在block中使用而不导致内存循环应用问题
//在宏中使用 \ 可以换行
#define WK(weakSelf) \
__block __weak __typeof(&*self)weakSelf = self;\

#define kBGColor kRGBA(234,234,234,1)

/** 全局的粉色 */
#define kNaviBarBGColor     kRGBA(251, 51, 41, 1)


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

#endif /* Constant_h */
