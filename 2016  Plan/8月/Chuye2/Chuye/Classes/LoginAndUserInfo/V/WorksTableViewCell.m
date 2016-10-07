//
//  WorksTableViewCell.m
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "WorksTableViewCell.h"
@interface WorksTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerPhotoImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessShareLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;

@end

@implementation WorksTableViewCell

-(void)setWorks:(UserModelDataWorks *)works{
    _works = works;
    
    NSRange range = [works.CreateAt rangeOfString:@"T"];
    NSString *date = [works.CreateAt substringToIndex:range.location];
    NSArray *arr = [date componentsSeparatedByString:@"-"];
    if(arr.count >=3){
        self.dayLabel.text = arr[2];
        self.monthLabel.text  = arr[1];
    }
    
    [self.headerPhotoImageView sd_setImageWithURL:[NSURL URLWithString:works.Thumbnail] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.titleLabel.text = works.Title;
    self.accessShareLabel.text = [NSString stringWithFormat:@"•%ld赞 ⋅%ld评论",works.Access,works.Public];
    self.joinLabel.text = [NSString stringWithFormat:@"%ld参与",works.ID];
}



-(void)setData:(AddFriendDataWorks *)data{
    _data = data;
    
     NSRange range = [data.CreateAt rangeOfString:@"T"];
    NSString *date = [data.CreateAt substringToIndex:range.location];
    NSArray *arr = [date componentsSeparatedByString:@"-"];
//    NSLog(@"data.CreateAt  :%@   arr:%@",data.CreateAt ,arr);
    if(arr.count >=3){
        self.dayLabel.text = arr[2];
        self.monthLabel.text  = arr[1];
    }
    
    [self.headerPhotoImageView sd_setImageWithURL:[NSURL URLWithString:data.ThumbnailUrl] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.titleLabel.text = data.Title;
    self.accessShareLabel.text = [NSString stringWithFormat:@"•%ld・%ld赞 ⋅%ld评论",data.Access,data.Praise,data.Comments];
    self.joinLabel.text = [NSString stringWithFormat:@"•%ld 分享",data.Share];
}

-(void)setUserDataWorks:(DiscoveryUsersDataWorks *)userDataWorks{
    _userDataWorks = userDataWorks;
    NSRange range = [userDataWorks.CreateAt rangeOfString:@"T"];
    NSString *date = [userDataWorks.CreateAt substringToIndex:range.location];
    NSArray *arr = [date componentsSeparatedByString:@"-"];
    //    NSLog(@"data.CreateAt  :%@   arr:%@",data.CreateAt ,arr);
    if(arr.count >=3){
        self.dayLabel.text = arr[2];
        self.monthLabel.text  = arr[1];
    }
    
    [self.headerPhotoImageView sd_setImageWithURL:[NSURL URLWithString:userDataWorks.ThumbnailUrl] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.titleLabel.text = userDataWorks.Title;
    self.accessShareLabel.text = [NSString stringWithFormat:@"•%ld・%ld赞 ⋅%ld评论",userDataWorks.Access,userDataWorks.Praise,userDataWorks.Comments];
    self.joinLabel.text = [NSString stringWithFormat:@"•%ld 分享",userDataWorks.Share];
}

@end
