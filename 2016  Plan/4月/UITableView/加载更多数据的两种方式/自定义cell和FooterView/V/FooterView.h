//
//  FooterView.h
//  Demo3_自定义Cell
//
//  Created by Qinting on 16/4/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
//委托的协议
@class FooterView;
@protocol FooterDelegate <NSObject>
-(void)loadData:(FooterView*)footer;
@end

@interface FooterView : UIView
@property(nonatomic,strong)id<FooterDelegate> delegate;
//数据加载完 回复按键
-(void)didLoadNewsData;

@end





