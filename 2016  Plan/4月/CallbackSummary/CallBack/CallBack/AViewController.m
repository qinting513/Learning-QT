//
//  AViewController.m
//  CallBack
//
//  Created by Qinting on 16/4/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"


/** 
 
 A：代理方，    B：委托方
  1. 用delegate方式 回调
  2. 用block方式    回调
 
 */

/** 1.遵守协议 */
@interface AViewController () <BVCDelegate>  //代理方

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[BViewController class]]) {
        BViewController *bvc = segue.destinationViewController;
        /** 2.设置代理 */
//        bvc.delegate = self;
        /** 写法1: */

        bvc.block = ^(NSString *str,NSString *str2){
            self.label.text = str;
        };

    }
    
}

/** 3.实现协议 */
-(void)bViewController:(BViewController *)bvc saveMesage:(NSString *)msg{
    self.label.text = msg;
}

-(void)dealloc {
    NSLog(@"xiaohhuile");
}

@end
