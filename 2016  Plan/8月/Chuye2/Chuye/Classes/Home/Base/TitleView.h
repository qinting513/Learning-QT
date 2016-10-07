//
//  TitleView.h
//  SwitchButton
//
//  Created by Qinting on 16/8/12.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//typedef NS_ENUM(NSInteger ,) ;

@class TitleView;
@protocol TitleViewDelegate <NSObject>

-(void)titleView:(TitleView*)view buttonClickAtIndex:(NSInteger)index;

@end

@interface TitleView : UIView

-(id)initWithFrame:(CGRect)frame allButtonTitles:(NSArray *)titles;

@property (nonatomic,weak) id<TitleViewDelegate> delegate;

/** 所有button显示的文字   */
@property (nonatomic,strong) NSArray  *allButtonTitles;

/** 标题字体大小 */
@property (nonatomic,strong) UIFont  *titleFont;

/** 标题字体大小 */
@property (nonatomic,strong) UIColor  *titleColor;
/** 下划线颜色 */
@property (nonatomic,strong) UIColor  *bottomViewColor;

/** 按钮的背景图片 */
//@property (nonatomic,strong) NSArray  *titleImageNames;

/** 设置最开始选中哪一个 */


@end
