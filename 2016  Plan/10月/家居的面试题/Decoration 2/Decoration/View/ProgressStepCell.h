//
//  ProgressStepCell.h
//  Decoration
//
//  Created by Qinting on 2016/10/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressStepCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *verticalLineView;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@property (weak, nonatomic) IBOutlet UIView *containView;


@end
