//
//  HeadView.m
//  Decoration
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HeadView.h"
#import "TeamMemberCell.h"
@interface HeadView()

@end

@implementation HeadView

+(instancetype)loadView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
    
}




@end
