//
//  WeiboCell.h
//  WeiboDemo
//
//  Created by Qinting on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
#import "WeiboFrame.h"

@interface WeiboCell : UITableViewCell

@property (nonatomic,strong) WeiboFrame   *weiboF;

@property (nonatomic,assign) CGFloat  cellHeight;

@end
