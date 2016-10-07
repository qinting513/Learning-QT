//
//  QTVerticalButton.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTVerticalButton.h"

@implementation QTVerticalButton

-(void) setup{
self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(void)awakeFromNib{
    [self setup];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        [self setup];
    }
    return  self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    /** adjust  image  */
    self.imageView.left = 0;
    self.imageView.top = 0;
    //图片自有宽高
//    self.imageView.width = self.width;
//    self.imageView.height = self.height;
    
    // adjust word
    self.titleLabel.left = 0;
    self.titleLabel.top = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
    
}

@end
