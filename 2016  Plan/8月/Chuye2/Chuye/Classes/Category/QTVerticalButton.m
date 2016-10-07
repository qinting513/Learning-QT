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
    CGRect frame = self.imageView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    self.imageView.frame = frame;
 
    //图片自有宽高
//    self.imageView.width = self.width;
//    self.imageView.height = self.height;
    
    // adjust word
    CGRect f = self.titleLabel.frame;
    f.origin.x = 0;
    f.origin.y = self.imageView.frame.size.height + 5;
    f.size.width = self.frame.size.width;
    f.size.height = self.frame.size.height - self.imageView.frame.size.height;
    self.titleLabel.frame = f;
    
}

@end
