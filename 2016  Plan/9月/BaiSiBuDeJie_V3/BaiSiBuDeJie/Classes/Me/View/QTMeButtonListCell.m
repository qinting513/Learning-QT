//
//  QTMeButtonListCell.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTMeButtonListCell.h"
//#import "QTVerticalButton.h"
#import "QTMeSquareListModel.h"
#import "QTButtonView.h"

@implementation QTMeButtonListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+(instancetype) cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"QTMeButtonListCell";
    QTMeButtonListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[QTMeButtonListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)setSquareLists:(NSArray *)squareLists{
    if (squareLists.count == 0) {
        return;
    }
    NSArray *array = [self removeRepeatComponentInArray:squareLists];
    _squareLists = array ;
    
    for(int i = 0; i < self.squareLists.count; i++){
        QTButtonView  *btnView = [QTButtonView  buttonView];
        btnView.frame = [self rectForBtnAtIndex:i  totalNum:self.squareLists.count];
        btnView.tag = i;
//        btnView.backgroundColor = [UIColor redColor];
        QTMeSquareListModel *model = self.squareLists[i];
        if( [btnView.subviews.firstObject isKindOfClass:[UIImageView class] ]){
            UIImageView *imageView = btnView.subviews.firstObject;
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"header_cry_icon"]];
            imageView.userInteractionEnabled = YES;
        }
    
        if([btnView.subviews.lastObject isKindOfClass:[UILabel class]]){
            UILabel *nameLabel = btnView.subviews.lastObject;
                   nameLabel.text = model.name;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = btnView.bounds;
        button.backgroundColor = [UIColor clearColor];
        [btnView addSubview:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btnView];
    }
}

- (void)buttonClick:(UIButton *)button{
        MYLog(@"Tap View:%ld", button.tag);
    QTMeSquareListModel *model = self.squareLists[button.tag];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"你点击了" message:model.name  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

/**
 *  获得每个操作按钮的frame
 *
 *  @param index    当前按钮的位置,从0开始
 *  @param totleNum 所有按钮的总数
 *
 *  @return 按钮的frame
 */
-(CGRect)rectForBtnAtIndex : (NSUInteger)index totalNum : (NSUInteger)totleNum{
    //每一行最多显示4个
    NSUInteger maxColumnNum = 4;
    //每个按钮的列间距
    CGFloat columnMargin = 2;
    //每个按钮的行间距
    CGFloat rowMargin = 2;
    //行数
    // NSUInteger row = totleNum/maxColumnNum;
    //每个按钮的宽度
    CGFloat width = (SCREEN_WIDTH - columnMargin*5)/4;
    //每个按钮的高度
    CGFloat height = 90;
    
    //每个按钮的偏移
    CGFloat offsetX = columnMargin+(index%maxColumnNum)*(width+columnMargin);
    CGFloat offsetY = rowMargin+(index/maxColumnNum)*(height+rowMargin);
    
    return CGRectMake(offsetX, offsetY, width, height);
}

// <QTMeSquareListModel *>
- (NSArray *)removeRepeatComponentInArray:(NSArray  *)array{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (QTMeSquareListModel *m in array) {
        [dict setObject:m forKey:m.name];
    }
    NSArray *arr = [dict allValues];
    return arr;
}

@end
