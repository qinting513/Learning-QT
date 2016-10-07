//
//  RecommendCategoryCell.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "RecommendCategoryCell.h"

@interface RecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation RecommendCategoryCell

+(UITableViewCell *)cellWithTableView:(UITableView*)tableView{
    static NSString *cellID = @"RecommendCategoryCell";
  RecommendCategoryCell*   cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RecommendCategoryCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.font = [UIFont systemFontOfSize:15];
}

-(void)setCategory:(RecommendCategory *)category{
    _category = category;
    self.textLabel.text = category.name;
}

/** 选中时的颜色 */
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected?ColorWith(192, 62, 66):[UIColor darkGrayColor];
}

@end
