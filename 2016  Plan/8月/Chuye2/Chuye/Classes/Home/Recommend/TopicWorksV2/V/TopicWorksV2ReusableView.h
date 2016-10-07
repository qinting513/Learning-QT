//
//  TopicWorksV2ReusableView.h
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreTopics.h"
@interface TopicWorksV2ReusableView : UICollectionReusableView
@property (nonatomic,strong) MoreTopicsData  *data;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end
