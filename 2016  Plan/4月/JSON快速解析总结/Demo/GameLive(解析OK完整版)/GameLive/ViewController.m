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
   
    [QTLiveNetManager getVideosCompletionHandle:^(QTVideoModel *model, NSError *error) {
        
    }];
    
    [QTLiveNetManager getCategoriesCompletionHandle:^(NSArray<CategoryModel *> *model, NSError *error) {
        
    }];
    
}



@end
