//
//  AlbumCell.h
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recommend.h"

@interface AlbumCell : UITableViewCell
@property (nonatomic,strong) RecommendDataAlbum  *album;
+(AlbumCell*)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
