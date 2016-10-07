//
//  AttentionTableViewCell.h
//  Chuye
//
//  Created by Qinting on 16/8/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Attention.h"
@interface AttentionTableViewCell : UITableViewCell
@property (nonatomic,strong) AttentionData  *data;
+(id)loadCell;

@property (weak, nonatomic) IBOutlet UIButton *loadMoreCommentsBtn;
@end
