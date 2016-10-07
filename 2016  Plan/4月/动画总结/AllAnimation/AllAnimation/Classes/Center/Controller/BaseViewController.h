//
//  BaseViewController.h
//  AllAnimation
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "TitleButton.h"

@interface BaseViewController : ViewController

/**
 *  当前控制器点标题
 *
 *  @return 标题
 */
- (NSString *)controllerTitle;

/**
 *  初始化View
 */
-(void)initView;

/**
 *  按钮操作区的数组元素
 *
 *  @return 数组
 */
-(NSArray *)operateTitleArray;


/**
 *  每个按钮的点击时间
 *
 *  @param btn btn
 */
-(void)clickBtn:(UIButton*)btn;

@end
