//
//  QTPushGuideView.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/6/3.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTPushGuideView.h"

@implementation QTPushGuideView

+(void)show{

    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (! [currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        QTPushGuideView *guideView = [QTPushGuideView  guideView];
        guideView.frame = window.frame;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }    
}

- (IBAction)ISeeButtonClick:(UIButton *)sender {
    [self removeFromSuperview];
}

+ (id)guideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
