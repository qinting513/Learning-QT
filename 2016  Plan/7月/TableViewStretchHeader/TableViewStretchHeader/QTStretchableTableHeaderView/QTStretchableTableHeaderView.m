//
//  QTStretchableTableHeaderView.m
//  TableViewStretchHeader
//
//  Created by Qinting on 16/7/13.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTStretchableTableHeaderView.h"

@interface QTStretchableTableHeaderView()
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}
@end

@implementation QTStretchableTableHeaderView

@synthesize tableView = _tableView;
@synthesize view = _view;

-(void)stretchHeaderForTableView:(UITableView *)tableView withView:(UIView *)view subView:(UIView *)subView
{
    _tableView = tableView;
    _view = view;
    
    initialFrame = view.frame;
    defaultViewHeight = initialFrame.size.height;
    
    UIView *emptyView = [[UIView alloc]initWithFrame:initialFrame];
    tableView.tableHeaderView = emptyView;
    
    [_tableView addSubview:_view];
    [_tableView addSubview:subView];
}
/** 当滚动的时候自动调用此方法 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
//    CGRect  f   = _view.frame;
//    f.size.width = _tableView.frame.size.width;
//    _view.frame  = f;

    //往下拉时，scrollView.contentOffset.y  小于0  且 值越来越大
    if(scrollView.contentOffset.y < 0)
    {
        CGFloat offsetY = scrollView.contentOffset.y  * -1;

        initialFrame.origin.y = - offsetY * 1;
        initialFrame.origin.x = - offsetY * 0.5;
        
        initialFrame.size.width  = _tableView.frame.size.width + offsetY;
        initialFrame.size.height = defaultViewHeight + offsetY;
        
        _view.frame = initialFrame;
    }

}

- (void)resizeView
{
    NSLog(@"resizeView");
    initialFrame.size.width = _tableView.frame.size.width;
    _view.frame = initialFrame;
}


@end
