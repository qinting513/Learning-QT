//
//  AlbumCell.m
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AlbumCell.h"
@interface AlbumCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation AlbumCell

+(AlbumCell*)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"AlbumCell";
    AlbumCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if(cell == nil){
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}


-(void)setAlbum:(RecommendDataAlbum *)album{
    _album = album;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.album.Thumbnail]
                           placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.titleLabel.text = album.Title;
    NSRange range =  [ album.CreateAt rangeOfString:@"T"];
    NSString *time = [album.CreateAt substringToIndex:range.location];
//    NSLog(@"time: %@",time);
    self.timeLabel.text = [NSString stringWithFormat:@"%@   %ld 篇  %ld万 浏览",time, album.WorkCount,album.WorkAccess];
}


@end
