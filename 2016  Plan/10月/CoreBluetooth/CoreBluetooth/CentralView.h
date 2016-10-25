//
//  CentralView.h
//  CoreBluetooth
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CentralView : UIView
@property (weak, nonatomic) IBOutlet UITextView *receiveTextView;
@property (weak, nonatomic) IBOutlet UITextField *sendMsgTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendMsgButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;

+(id)loadView;
@end
