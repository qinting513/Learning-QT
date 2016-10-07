//
//  TRFoldView.m
//  TableVIewFold
//
//  Created by yyh on 16/9/7.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRFoldView.h"
#define trFoldLineWidth       0.3f
#define trFoldingMargin       8.0f
#define trFoldingIconSize     24.0f
@interface TRFoldView ()

@property (nonatomic, strong) CAShapeLayer *sepertorLine;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic ,assign) BOOL isOpen;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@end
@implementation TRFoldView
-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag andIsOpen:(BOOL)isOpen
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
        [self setupSubviewsWithArrowPosition:isOpen];
        self.isOpen = isOpen;
        [self shouldExpand:isOpen];
    }
    return self;
}
-(UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapped:)];
    }
    return _tapGesture;
}
-(UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.text = @"类型";
        _descriptionLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descriptionLabel;
}
-(void)setupSubviewsWithArrowPosition:(BOOL)arrowPosition
{
    CGFloat labelWidth = (self.frame.size.width - trFoldingMargin*2 - trFoldingIconSize)/2;
    CGFloat labelHeight = self.frame.size.height;
    CGRect arrowRect = CGRectMake(0, (self.frame.size.height - trFoldingIconSize)/2, trFoldingIconSize, trFoldingIconSize);
    CGRect titleRect = CGRectMake(trFoldingMargin + trFoldingIconSize, 0, labelWidth, labelHeight);
    CGRect descriptionRect = CGRectMake(trFoldingMargin + trFoldingIconSize + labelWidth,  0, labelWidth, labelHeight);
    self.backgroundColor = [UIColor colorWithRed:0.423 green:0.448 blue:0.867 alpha:1.000];
    
    [self.arrowImageView setFrame:arrowRect];
    [self.titleLabel setFrame:titleRect];
    [self.descriptionLabel setFrame:descriptionRect];
    [self.sepertorLine setPath:[self getSepertorPath].CGPath];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addGestureRecognizer:self.tapGesture];
    [self addSubview:self.arrowImageView];
    [self.layer addSublayer:self.sepertorLine];
    
//    if (_isOpen) {
//        
//        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
//        
//    } else {
//        
//        self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
//    }
    
    
}
-(UIBezierPath *)getSepertorPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height - trFoldLineWidth)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - trFoldLineWidth)];
    return path;
}
-(CAShapeLayer *)sepertorLine
{
    if (!_sepertorLine) {
        _sepertorLine = [CAShapeLayer layer];
        _sepertorLine.strokeColor = [UIColor whiteColor].CGColor;
        _sepertorLine.lineWidth = trFoldLineWidth;
    }
    return _sepertorLine;
}
-(void)onTapped:(UITapGestureRecognizer *)gesture
{
    _isOpen = !_isOpen;
    [self shouldExpand:_isOpen];
    [_tapDelegate foldingSectionHeaderTappedAtIndex:self.tag andIsOpen:self.isOpen];
}
-(UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"Arrow"];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImageView;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = @"分区";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(void)shouldExpand:(BOOL)shouldExpand
{
    [UIView animateWithDuration:0.2
                     animations:^{
                         if (shouldExpand) {
                             self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI/2);
                         } else {
                             self.arrowImageView.transform = CGAffineTransformIdentity;
                         }
                     } completion:^(BOOL finished) {
                         if (finished == YES) {
                             self.sepertorLine.hidden = shouldExpand;
                         }
                     }];
    
}

@end
