//
//  QTTopicCell.h
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTTopicFrame.h"

@interface QTTopicCell : UITableViewCell

@property (nonatomic,strong) QTTopicFrame *topicFrame;

+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
