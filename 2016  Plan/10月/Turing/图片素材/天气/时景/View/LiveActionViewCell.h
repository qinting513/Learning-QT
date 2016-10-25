//
//  LiveActionViewCell.h
//  天气预报
//
//  Created by tarena22 on 16/9/3.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveActionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGIV;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end
