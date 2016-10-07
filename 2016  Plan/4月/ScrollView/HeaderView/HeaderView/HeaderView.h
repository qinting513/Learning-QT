//
//  HeaderView.h
//  HeaderView
//
//  Created by Qinting on 16/4/20.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  HeaderView;
@protocol HeaderViewDelegate <NSObject>

-(void)headerView:(HeaderView*)headerView clickButtonAtIndex:(NSInteger)index;

@end


@interface HeaderView : UIView

@property (nonatomic,strong) id<HeaderViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

-(id)initWithFrame:(CGRect)frame textArray:(NSArray *)textArray;

@end
