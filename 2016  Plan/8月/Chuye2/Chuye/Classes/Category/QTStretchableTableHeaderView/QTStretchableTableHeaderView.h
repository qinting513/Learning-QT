//
//  QTStretchableTableHeaderView.h
//  TableViewStretchHeader
//
               

//  Created by Qinting on 16/7/13.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QTStretchableTableHeaderView : NSObject

/** 用于显示的tableView */
@property (nonatomic,strong) UITableView *tableView;

/** 背景图片等View */
@property (nonatomic,strong) UIView  *view;

/**
 *  拉伸图片。须调用的方法
 *
 *  @param tableView   要在哪个tableView的头部拉伸图片，就将那个tableView传入
 *  @param view      拉伸的背景图片
 *  @param subView   tableView的头部 背景图片上添加的View容器，方便添加其他控件进行扩展
 */
- (void)stretchHeaderForTableView:(UITableView*)tableView
                         withView:(UIView*)view
                          subView:(UIView*)subView;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;
- (void)resizeView;

@end

/*
 *使用时要实现以下两个代理方法
 *- (void)scrollViewDidScroll:(UIScrollView *)scrollView
 *- (void)viewDidLayoutSubviews
 */