//
//  JCTableViewCell.m
//  Turing
//
//  Created by Guo.JC on 16/9/17.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCBlutoothCell.h"


@interface JCBlutoothCell ()
@property (weak, nonatomic) IBOutlet UIImageView *signal;
@property (weak, nonatomic) IBOutlet UILabel *signalLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sevices;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end

@implementation JCBlutoothCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setBlutoothInfo:(JCBlutoothInfoModel *)blutoothInfo
{
    _blutoothInfo = blutoothInfo;
    
    NSNumber *RSSI = blutoothInfo.RSSI;
    
    self.signalLabel.text = [RSSI stringValue];
    
    self.name.text = blutoothInfo.peripheral.name;
    self.sevices.text = [NSString stringWithFormat:@"%d Sevices",((NSArray *)blutoothInfo.advertisementData[@"kCBAdvDataServiceUUIDs"]).count];
    
    /*计算蓝牙距离*/
    int iRssi = abs([RSSI intValue]);
    float power = (iRssi-59)/(10*2.0);
    float distance = pow(10, power);
    
    self.distance.text = [NSString stringWithFormat:@"%.3f米",distance];
    self.signal.image = [UIImage imageNamed:[NSString stringWithFormat:@"信号-%02d",5-((iRssi - 25)/15)]];
}

@end
