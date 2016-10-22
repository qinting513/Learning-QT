//
//  ProgressHeadCell.h
//  Decoration
//
//  Created by Qinting on 2016/10/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *verticalLineView;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *progressNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalLineHeight;


@end
