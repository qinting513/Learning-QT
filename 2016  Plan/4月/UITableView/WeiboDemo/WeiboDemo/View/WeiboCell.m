//
//  WeiboCell.m
//  WeiboDemo
//
//  Created by Qinting on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WeiboCell.h"




@interface WeiboCell ()

@property (nonatomic,strong) UIImageView  *iconImageView;
@property (nonatomic,strong) UILabel  *nameLabel;
@property (nonatomic,strong) UILabel  *timeLabel;
@property (nonatomic,strong) UILabel  *sourceLabel;
@property (nonatomic,strong) UILabel  *contentLabel;
@property (nonatomic,strong) UIImageView  *imageImageView;

@end

@implementation WeiboCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        self.iconImageView = [UIImageView new];
        [self addSubview:self.iconImageView];
        
        self.nameLabel = [UILabel new];
        [self addSubview:self.nameLabel];
        
        self.timeLabel = [UILabel new];
        self.timeLabel.font = kTimeFont;
        [self addSubview:self.timeLabel];
        
        self.sourceLabel = [UILabel new];
        self.sourceLabel.font = kTimeFont;
        [self addSubview:self.sourceLabel];
        
        self.contentLabel = [UILabel new];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font  = kContentFont;
        [self addSubview:self.contentLabel];
        
        self.imageImageView = [UIImageView new];
        [self addSubview:self.imageImageView];
    }
    return self;
}

-(void)setWeiboF:(WeiboFrame *)weiboF
{
    _weiboF = weiboF;
    [self setupData];
    [self setupFrame];
}

-(void)setupData{
    self.iconImageView.image = [UIImage imageNamed:_weiboF.weibo.icon];
    self.nameLabel.text =_weiboF.weibo.name;
    self.timeLabel.text = _weiboF.weibo.time;
    self.sourceLabel.text = [NSString stringWithFormat:@"来自:%@", _weiboF.weibo.source];
    self.contentLabel.text =_weiboF.weibo.content;
    self.imageImageView.image = [UIImage imageNamed:_weiboF.weibo.image];
}

-(void)setupFrame{
    
    self.iconImageView.frame =_weiboF.iconF;
    
    self.nameLabel.frame = _weiboF.nameF;
    
    self.timeLabel.frame = _weiboF.timeF;
    
    self.sourceLabel.frame = _weiboF.sourceF;
    
    self.contentLabel.frame = _weiboF.contentF;
    
    self.imageImageView.frame = _weiboF.imageF;
  }

@end
