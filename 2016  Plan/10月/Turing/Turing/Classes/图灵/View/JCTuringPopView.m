//
//  JCTuringPopView.m
//  图灵机器人
//
//  Created by Guo.JC on 16/9/1.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCTuringPopView.h"

@implementation JCTuringPopView
{
    UIImageView *_popBG;
    UILabel *_popLabel;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.alpha = 0;
        self.frame = CGRectMake(80, 0, 150, 30);
        self.backgroundColor = [UIColor clearColor];
        
        _popBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_icon_blue"]];
        _popBG.backgroundColor = [UIColor clearColor];
        [self addSubview:_popBG];
        [_popBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.right.and.bottom.equalTo(self);
        }];
        
        _popLabel = [UILabel new];
        _popLabel.backgroundColor = [UIColor clearColor];
        _popLabel.textColor = [UIColor whiteColor];
        _popLabel.font = [UIFont systemFontOfSize:10];
        _popLabel.numberOfLines = 0;
        _popLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_popLabel];
        [_popLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self).offset(2);
            make.right.equalTo(self).offset(-2);
            make.bottom.equalTo(self).offset(-6);
        }];
    }
    return self;
}


-(void)setText:(NSString *)text
{
    _text = text;
    
    /*计算出label高度*/
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 8)];
    textLabel.font = [UIFont systemFontOfSize:10];
    textLabel.numberOfLines = 0;
    
    //第一种方式
    //    CGSize size = [text sizeWithFont:label.font constrainedToSize: CGSizeMake(label.frame.size.width, MAXFLOATlineBreakMode:NSLineBreakByWordWrapping];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    CGSize size =  [text boundingRectWithSize:CGSizeMake(textLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    self.frame = CGRectMake(100, -20, 150, size.height+10);
    _popLabel.text = text;
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 1;
    }];
}

-(instancetype)initWithShowText:(NSString *)text
{
    if (self = [super init]) {
        
        self.alpha = 0;
        self.frame = CGRectMake(100, -20, 150, 30);
        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 8)];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.numberOfLines = 0;
        
        //第一种方式
        //    CGSize size = [text sizeWithFont:label.font constrainedToSize: CGSizeMake(label.frame.size.width, MAXFLOATlineBreakMode:NSLineBreakByWordWrapping];
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
        
        CGSize size =  [text boundingRectWithSize:CGSizeMake(textLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        
        self.frame = CGRectMake(100, -20, 150, size.height+8);
        self.backgroundColor = [UIColor clearColor];
        
        _popBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_icon_blue"]];
        _popBG.backgroundColor = [UIColor clearColor];
        _popBG.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self addSubview:_popBG];
        
        _popLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.height - 8)];
        _popLabel.backgroundColor = [UIColor clearColor];
        _popLabel.textColor = [UIColor whiteColor];
        _popLabel.font = [UIFont systemFontOfSize:10];
        _popLabel.numberOfLines = 0;
        _popLabel.textAlignment = NSTextAlignmentLeft;
        _popLabel.text = text;
        
        [self addSubview:_popLabel];
    }
    return self;
}
@end
