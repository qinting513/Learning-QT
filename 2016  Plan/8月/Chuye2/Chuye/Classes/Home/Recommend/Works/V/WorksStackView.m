//
//  WorksStackView.m
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "WorksStackView.h"
#import "UIImageView+WebCache.h"

@interface WorksStackView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation WorksStackView

-(void)setWork:(RecommendDataWorks *)work{
    _work = work;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:work.ThumbnailUrl] placeholderImage:[UIImage imageNamed:@"work_pic"]];

    self.contentLabel.text = work.Title;
    self.nameLabel.text = work.User.nickname;
}

+(id)loadXib{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(void)setWorksData:(WorksData *)worksData{
    _worksData = worksData;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:worksData.ThumbnailUrl]
                      placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.contentLabel.text = worksData.Title;
    self.nameLabel.text = worksData.User.nickname;

}

-(void)setDiscoveryDataWorks:(DiscoveryDataWorks *)discoveryDataWorks{
    _discoveryDataWorks = discoveryDataWorks;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:discoveryDataWorks.ThumbnailUrl]
                      placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.contentLabel.text = discoveryDataWorks.Title;
    self.nameLabel.text = discoveryDataWorks.User.nickname;
}

@end
