//
//  TwoViewController.h
//  ReactiveCocoa
//
//  Created by yz on 15/9/25.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface TwoViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

@end
