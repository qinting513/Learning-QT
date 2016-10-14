//
//  ScreenLockVC.h
//  LockScreenDemo
//
//  Created by Jone on 15/12/28.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    //设置密码
    CoreLockTypeSetPwd=0,
    
    //输入并验证密码
    CoreLockTypeVeryfiPwd,
    
    //修改密码
    CoreLockTypeModifyPwd,
    
}CoreLockType;


@interface ScreenLockVC : UIViewController

@property (nonatomic,assign) CoreLockType type;

@property (nonatomic, assign) BOOL isTouch;

+(BOOL)hasPwd;



@end
