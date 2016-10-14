//
//  SetLockViewController.h
//  Honkib
//
//  Created by Jone' on 15/12/30.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    HJBLockTypeGesture = 0,
    HJBLockTypeTouch,
}LockType;

@interface SetLockViewController : UIViewController

@property (nonatomic, assign) LockType type;

@end
