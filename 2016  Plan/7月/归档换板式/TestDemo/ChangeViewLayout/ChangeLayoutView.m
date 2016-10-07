//
//  ChangeLayoutView.m
//  换板式练习
//
//  Created by Qinting on 16/8/2.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ChangeLayoutView.h"

/** 
 什么是Bundle文件？
 简单理解，就是资源文件包。我们将许多图片、XIB、文本文件组织在一起，打包成一个Bundle文件。方便在其他项目中引用包内的资源。
 
 Bundle文件的特点？
 Bundle是静态的，也就是说，我们包含到包中的资源文件作为一个资源包是不参加项目编译的。也就意味着，bundle包中不能包含可执行的文件。它仅仅是作为资源，被解析成为特定的2进制数据。
 
 */

@interface ChangeLayoutView()
@property (nonatomic)int count;
@end
@implementation ChangeLayoutView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self ) {
        
        NSString * bundlePath = [[ NSBundle mainBundle] pathForResource:@"ChangeLayoutResource" ofType :@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
        
        NSString *path = [resourceBundle pathForResource:@"layout_6_0" ofType:@""];
        
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *subViews = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        //    遍历每一个View
        for (int i=0;i<subViews.count;i++) {
            UIView *view = subViews[i];
            //        创建IV位置和保存的View一致
            UIImageView *iv = [[UIImageView alloc]initWithFrame:view.frame];
            //        设置显示模式 保证宽高比并且填充
            iv.contentMode = UIViewContentModeScaleAspectFill;
            //超出范围不显示
            iv.clipsToBounds = YES;
            NSString *path = [resourceBundle pathForResource:[NSString stringWithFormat:@"%d.jpg",i] ofType:nil];
            iv.image = [UIImage imageWithContentsOfFile:path];
    
            [self addSubview:iv];
        }
        
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeLayout) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)changeLayout{
    //得到界面中显示的所有的IV
    NSArray *ivs = self.subviews;
    
    //得到新板式数据文件的地址
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource:@"ChangeLayoutResource" ofType :@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [resourceBundle  pathForResource:[NSString stringWithFormat:@"layout_6_%d",++self.count%4] ofType:@""];

    NSData *data = [NSData dataWithContentsOfFile:path];
    //得到板式view的数组
    NSArray *subViews = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    //遍历每一个图片
    for (int i=0; i<ivs.count; i++) {
        UIImageView *iv = ivs[i];
        //取出装着新板式数据的view
        UIView *view = subViews[i];
        
        [UIView animateWithDuration:1 animations:^{
            //把位置信息取出 给到图片
            iv.frame = view.frame;
        }];
        
    }
}

@end
