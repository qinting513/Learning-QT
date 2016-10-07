//
//  WorksCell.m
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "WorksCell.h"
#import "WorksStackView.h"
#import "RecommendBannerViewController.h"

#define  kRowMargin  20
#define  kColMargin  20


@interface WorksCell ()
@property (nonatomic,strong)   WorksStackView *lastSv;
@end

@implementation WorksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    for(int i = 0; i< 6; i++)
    {
        WorksStackView *sv = [WorksStackView loadXib];
        sv.tag = i;
        /** 每行有3个sv */
        CGFloat  width = ( kScreenW - 4 * kColMargin) / 3;
        CGFloat height = 150 + width *0.2 ;
        CGFloat x = kColMargin + (width + kColMargin) * (i % 3);
        CGFloat y = kRowMargin + (height + kRowMargin) * (i / 3);
        sv.frame = CGRectMake(x, y, width, height);
        sv.userInteractionEnabled = YES;
        [self.contentView addSubview:sv];
        if(i == 5){
            self.lastSv = sv;
        }
        [sv.stackViewBtn addTarget:self action:@selector(clickStackView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)clickStackView:(UIButton *)btn{
        RecommendDataWorks *work = self.works[btn.superview.tag];
        self.clickTopic(work.Uri);
}

+(WorksCell*)createCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
 static NSString *cellID = @"WorksCell";
    WorksCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath ];
    return cell;
}

-(void)setWorks:(NSArray *)works{
    _works = works;
    for(WorksStackView * sv in self.contentView.subviews)
    {
        sv.work = works[sv.tag];
    }
self.cellHeight(CGRectGetMaxY(self.lastSv.frame) + kRowMargin);
}



@end
