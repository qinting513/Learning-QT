//
//  TopicView.m
//  Chuye
//
//  Created by Qinting on 16/8/16.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TopicView.h"
#import "Recommend.h"
@interface TopicView()

@property (weak, nonatomic) IBOutlet UIView *menuView;

@end

@implementation TopicView

+(id)loadXib{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)setTopics:(NSArray *)topics{
    for (UIButton *b in _menuView.subviews) {
        RecommendDataTopic *t = topics[b.tag];
        [b setTitle:[NSString stringWithFormat:@"# %@ #",t.Title]  forState:UIControlStateNormal];
        [b addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickBtn:(UIButton*)btn {
    self.clickBtnBlock(btn.tag);
}

- (IBAction)moreBtnClick:(UIButton *)sender {
    self.clickMoreBtnBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
