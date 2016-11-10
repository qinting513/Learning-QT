//
//  RootViewController.m
//  AnimationSummary
//
//  Created by Qinting on 16/4/24.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "RootViewController.h"

#import <QuartzCore/QuartzCore.h>
//#define IMGTAG 10000


@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"动画展示";

    for (int i = 0; i<4;i++){  // 4列8行
        for (int j = 0; j<8;j++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(20 + 90 * i, 80 + 50 * j, 80, 40);
            [btn setTitle:[NSString stringWithFormat:@"i:%d   j:%d",i,j] forState:UIControlStateNormal];
            if ( i % 2 == 0) {
            [btn setBackgroundColor:[UIColor blueColor]];
            }else{
            [btn setBackgroundColor:[UIColor redColor]];
            }
            
            btn.tag =  i + j*4 +10000;
            [btn addTarget:self action:@selector(touchPress:) forControlEvents:UIControlEventTouchUpInside
             ];
            [self.view addSubview:btn];
        }
    }
}


-(void)touchPress:(UIButton*)btn{

    NSLog(@"%ld",btn.tag);
    NSInteger index = btn.tag;
  
    CATransition *tran = [CATransition animation];
    
    /**   btn.tag =  i + j*4 +10000;  */
    switch (index) {
        case 10000:
            tran.type = @"suckEffect"; //卷叶收缩
            break;
        case 10001:
            tran.type = @"rippleEffect"; //水溶解
            break;
        case 10002:
            tran.type = @"pageCurl"; //翻页
            tran.subtype = kCATransitionFromRight; //从左到右
            break;
        case 10003:
            tran.type = kCATransitionMoveIn;
            tran.subtype = kCATransitionFromBottom;
            break;
        case 10004:
            tran.type = kCATransitionPush;
            tran.subtype = kCATransitionFromLeft;
            break;
        case 10005:
            tran.type = kCATransitionReveal;
            tran.subtype = kCATransitionFromRight;
            break;
        case 10006:
            tran.type = kCATransitionReveal;
            tran.subtype = kCATransitionFromLeft;
            break;
        case 10007:
            tran.type = kCATransitionReveal;
            tran.subtype = kCATransitionFromTop;
            break;
            
        case 10008:
            tran.type = kCATransitionReveal;
            tran.subtype = kCATransitionFromBottom;
            break;
        case 10009:
            tran.type = @"cube";
            tran.subtype = kCATransitionFromBottom;
            break;
        case 10010:
            tran.type = @"oglFlip";
            tran.subtype = kCATransitionFromBottom;
            break;
        case 10011:
            tran.type = @"rippleEffect";
            break;
        case 10012:
            tran.type = @"cameraIrisHollowOpen";
            break;
        case 10013:
            tran.type = @"cameraIrisHollowClose";
            break;
        case 10014:
            tran.type = kCATransitionMoveIn;
            tran.subtype = kCATransitionFromTop;
            break;
        case 10015:
            tran.type = kCATransitionPush;
            tran.subtype = kCATransitionFromTop;
            break;
        case 10016:
            tran.type = @"pageCurl";
            tran.subtype = kCATransitionFromTop;
            break;
        case 10017:
            tran.type = @"pageCurl";
            tran.subtype = kCATransitionFromLeft;
            break;
        case 10018:
            tran.type = @"pageCurl";
            tran.subtype = kCATransitionFromBottom;
            break;
        case 10019:
            tran.type = @"oglFlip";
            tran.subtype = kCATransitionFromTop;
            break;
        case 10020:
            tran.type = @"oglFlip";
            tran.subtype = kCATransitionFromLeft;
            break;
        case 10021:
            tran.type = kCATransitionMoveIn;
            tran.subtype = kCATransitionFromLeft;
            
            break;
        case 10022:
            tran.type = kCATransitionMoveIn;
            tran.subtype = kCATransitionFromTop;
            
            break;
        case 10023:
            tran.type = kCATransitionMoveIn;
            tran.subtype = kCATransitionFromBottom;
            
            break;
        case 10024:
            tran.type = kCATransitionPush;
            tran.subtype = kCATransitionFromLeft;
            break;
        case 10025:
            tran.type = kCATransitionPush;
            tran.subtype = kCATransitionFromTop;
            break;
        case 10026:
            tran.type = kCATransitionPush;
            tran.subtype = kCATransitionFromBottom;
            break;
        case 10027:
            tran.type = @"cube";
            tran.subtype = kCATransitionFromRight;
            break;
        case 10028:
            tran.type = @"cube";
            tran.subtype = kCATransitionFromTop;
            break;
        case 10029:
            tran.type = @"cube";
            tran.subtype = kCATransitionFromLeft;
            break;
            
        default:
            break;

    }
    DetailViewController * detailVc = [[DetailViewController alloc]init];
    UIView * view = self.navigationController.view;
    
    [self.view.layer addAnimation:tran forKey:@"noUseKey"];
    tran.duration = 1.5;
    tran.delegate = self;
    [view.layer addAnimation:tran forKey:@"hehe"];
    
     [self.navigationController pushViewController:detailVc animated:YES];
}
@end
