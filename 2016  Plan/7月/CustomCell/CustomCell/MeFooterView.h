//
//  MeFooterView.h
//  CustomCell
//
//  Created by Qinting on 16/7/14.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeFooterView : UIView

/** 提供一个类方法，加载xib文件 */
+(id)loadFooterView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
