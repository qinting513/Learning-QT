//
//  HomeBaseViewController.h
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,CurrentVCType) {
    CurrentVCTypeAttention = 0,
    CurrentVCTypeRecommend,
    CurrentVCTypeDiscovery,
};

@interface HomeBaseViewController : UIViewController
@property (nonatomic,assign) CurrentVCType currentVCType;
@end
