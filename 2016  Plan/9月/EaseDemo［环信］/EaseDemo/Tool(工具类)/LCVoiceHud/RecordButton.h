//
//  LYRecordButton.h
//  ITSNS
//
//  Created by Ivan on 16/1/13.
//  Copyright © 2016年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCVoice.h"
//NSString *const RecordDidFinishNotification = @"RecordDidFinishNotification";
@interface RecordButton : UIButton
@property (nonatomic, strong)LCVoice *voice;
@end
