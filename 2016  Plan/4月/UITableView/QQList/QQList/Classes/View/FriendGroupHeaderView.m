//
//  FriendGroupHeaderView.m
//  QQList
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "FriendGroupHeaderView.h"
#import "FriendGroupModel.h"

@interface FriendGroupHeaderView()

@property (nonatomic,strong) UIButton *nameButton;
@property (nonatomic,strong) UILabel *countLabel;

@end

@implementation FriendGroupHeaderView

/** 创建自定义可重用的headerView */
+(instancetype)headerViewWithTableView:(UITableView*)tableView{
static NSString *reuseID = @"group";
    FriendGroupHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseID];
    if (headerView == nil) {
        headerView = [[self alloc]initWithReuseIdentifier:reuseID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self ) {
        self.nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.nameButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        self.nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.nameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.nameButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.nameButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [self.nameButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        
        [self.nameButton addTarget:self action:@selector(nameButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //图片不缩放
        self.nameButton.imageView.contentMode = UIViewContentModeCenter;
        //超出部分不剪裁
        self.nameButton.imageView.clipsToBounds = NO;
        [self addSubview:self.nameButton];
        //个数的label
        UILabel *countLabel = [[UILabel alloc]init];
//        [self.countLabel addSubview:countLabel];
        self.countLabel = countLabel;
        self.countLabel.textAlignment = NSTextAlignmentRight;
        self.countLabel.font = [UIFont systemFontOfSize:14];
        self.countLabel.textColor = [UIColor grayColor];
        [self addSubview:self.countLabel];
    }
    return self;
}

-(void)nameButtonClick{
    self.friendGroup.expend = !self.friendGroup.expend;
    
    if (self.friendGroup.isExpend) { //展开
        self.nameButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{ //合并
        self.nameButton.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
    if ([self.delegate respondsToSelector:@selector(friendGroupHeaderViewDidClickNameBtn:)]) {
        [self.delegate friendGroupHeaderViewDidClickNameBtn:self];
    }
    
}




//往headerView添加子控件时会调用
//改变了headerView的frame 时会调用
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameButton.frame = self.bounds;
    
    CGFloat countX = self.bounds.size.width - 10 -150;
    self.countLabel.frame = CGRectMake(countX, 0, 150, 44);

}

// 3 给子控件赋值
-(void)setFriendGroup:(FriendGroupModel *)friendGroup{
    _friendGroup = friendGroup;
    [self.nameButton setTitle:friendGroup.name forState:UIControlStateNormal];
    self.countLabel.text = [NSString stringWithFormat:@"%d/%lu",friendGroup.online,(unsigned long)friendGroup.friends.count];

    //解决重用带来的问题
    if (self.friendGroup.isExpend) { //展开
        self.nameButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{ //合并
        self.nameButton.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
}


@end
