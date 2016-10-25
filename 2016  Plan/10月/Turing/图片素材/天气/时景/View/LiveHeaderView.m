//
//  LiveHeaderView.m
//  天气预报
//
//  Created by tarena22 on 16/9/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "LiveHeaderView.h"

@implementation LiveHeaderView
-(void)awakeFromNib
{
    UIScrollView *smallSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 375, 150)];
    
    for (int i=0; i<5; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*375, 0, 375, 150)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"ad0%d",i+1]];
        self.scrollView = smallSV;
        [smallSV addSubview:iv];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
}
@end
