//
//  LiveTableViewCell.h
//  LiveApp
//
//  Created by Qinting on 2016/10/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveItem.h"
@interface LiveTableViewCell : UITableViewCell
@property (nonatomic,strong) LiveItem  *liveItem;
@end
