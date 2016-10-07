//
//  TransmitTableViewCell.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TransmitTableViewCell.h"
@interface TransmitTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessShareLabel;

@end
@implementation TransmitTableViewCell

-(void)setTransmitData:(TransmitData *)transmitData{
    _transmitData = transmitData;
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:transmitData.Thumbnail]
                               placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.nicknameLabel.text = transmitData.User.nickname;
    self.titleLabel.text = transmitData.Title;
    self.accessShareLabel.text = [NSString stringWithFormat:@"@%ld/%ld",transmitData.Access,transmitData.Share];
}

@end
