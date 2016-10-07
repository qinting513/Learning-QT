//
//  TRFoldView.h
//  TableVIewFold
//
//  Created by yyh on 16/9/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TRFoldingSectionHeaderDelegate <NSObject>

- (void)foldingSectionHeaderTappedAtIndex:(NSInteger)index andIsOpen:(BOOL)isOpen;

@end
@interface TRFoldView : UIView
@property (nonatomic, weak)id<TRFoldingSectionHeaderDelegate> tapDelegate;
-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag andIsOpen:(BOOL)isOpen;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
