//
//  ChatViewController.h
//  EaseDemo
//
//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EaseMob.h>

//typedef NS_ENUM(NSInteger, MessageType){
//    MessageTypeText,
//    MessageTypeImage,
//    MessageTypeVoice,
//    MessageTypeVideo,
//    MessageTypeLocation,
//    MessageTypeFile,
//};

@interface ChatViewController : UIViewController
@property (nonatomic,strong)     NSString *toUser;
@end
