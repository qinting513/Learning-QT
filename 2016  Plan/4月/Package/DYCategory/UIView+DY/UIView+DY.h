//
//  UIView+DY.h
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/6.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DY)

/**控件frame的X值*/
@property(nonatomic,assign)CGFloat frameX;
/**控件frame的Y值*/
@property(nonatomic,assign)CGFloat frameY;

/**控件center的X值*/
@property(nonatomic,assign)CGFloat centerX;
/**控件center的Y值*/
@property(nonatomic,assign)CGFloat centerY;

/**控件frame的W值*/
@property(nonatomic,assign)CGFloat frameW;
/**控件frame的H值*/
@property(nonatomic,assign)CGFloat frameH;

/**控件frame的size值*/
@property(nonatomic,assign)CGSize frameSize;


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com