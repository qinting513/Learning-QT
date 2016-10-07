//
//  ViewController.m
//  GameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "QTLiveNetManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 获取网络数据
    [QTLiveNetManager getVideosCompletionHandle:^(id responseObj,NSError *error) {
        
    }];
    
    [QTLiveNetManager getCategoriesCompletionHandle:^(id responseObj, NSError *error) {
        
    }];
    
}



@end
