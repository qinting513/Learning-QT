//
//  ChoseView.h
//  BackView
//
//  Created by Qinting on 16/8/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoseView : UIView

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

+(id)loadView; 

@end
