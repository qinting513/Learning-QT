//
//  QTContentView.h
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTTopic.h"

@interface QTContentView : UIView

@property (nonatomic,strong) QTTopic *topic;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
