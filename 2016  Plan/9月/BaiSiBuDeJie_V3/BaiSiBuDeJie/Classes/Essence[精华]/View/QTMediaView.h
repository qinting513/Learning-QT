//
//  QTMediaView.h
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTContentView.h"

@interface QTMediaView : QTContentView
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@end
