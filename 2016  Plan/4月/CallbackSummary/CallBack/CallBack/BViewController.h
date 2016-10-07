//
//  BViewController.h
//  CallBack
//
//  Created by Qinting on 16/4/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BViewController; //委托方

@protocol BVCDelegate <NSObject>

/** 1.声明协议 */
-(void)bViewController:(BViewController*)bvc saveMesage:(NSString *)msg;

@end


/** b1: 定义一个block 类似于上面声明协议 */
typedef void(^ReturnTextBlock)(NSString *str,NSString *str2);

@interface BViewController : UIViewController

/** b2:声明一个block属性  */
@property (nonatomic,copy) ReturnTextBlock block;   //void(^)(NSString *str,NSString *str2){  }



/** 2.公开一个代理属性 */
@property (nonatomic,assign) id<BVCDelegate> delegate;

@end
