//
//  MeFooterView.m
//  CustomCell
//
//  Created by Qinting on 16/7/14.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MeFooterView.h"
#import "UIView+Extension.h"

@implementation MeFooterView

+(id)loadFooterView
{
    return  [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib
{
        NSLog(@"awakeFromNib");
    self.iconImageView.image = [UIImage imageNamed:@"0"];
//    [self.iconImageView circleImage];
//    [self.iconImageView circleImageWithCornerRadius:10 borderWidth:1 borderColor:[UIColor redColor]];
    
    //绘制的更高效
    self.iconImageView.image =[self.iconImageView round];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"initWithCoder");
        self.iconImageView.image = [UIImage imageNamed:@"0"];
        //    [self.iconImageView circleImage];
        [self.iconImageView circleImageWithCornerRadius:10 borderWidth:1 borderColor:[UIColor redColor]];
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        NSLog(@"init");
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"initWithFrame");
        self.iconImageView.image = [UIImage imageNamed:@"0"];
        //    [self.iconImageView circleImage];
        [self.iconImageView circleImageWithCornerRadius:10 borderWidth:1 borderColor:[UIColor redColor]];
    }
    return self;
}



@end
