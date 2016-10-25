//
//  JCTuringPopView.h
//  图灵机器人
//
//  Created by Guo.JC on 16/9/1.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCTuringPopView : UIView

@property(nonatomic,copy)NSString *text;


-(instancetype)initWithShowText:(NSString *)text;
@end
