//
//  NewsCell.m
//  Demo3_自定义Cell
//
//  Created by Qinting on 16/4/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell ()
//新闻图片
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
//新闻标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//新闻访问量
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@end


@implementation NewsCell



+(instancetype)cellForTableView:(UITableView *)tableView {
    //从队列中取出 自定义的Cell
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        //通过xib创建了一个数组，数组有xib种所有的view，而我们当前的xib中有一个Cell，所以把数组最后一个元素取出，就是我们要用的Cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
//通过 传进来的 新闻对象 设置 显示的内容
-(void)setData:(News *)news {
    self.newsImageView.image = [UIImage imageNamed:news.newsImage];
    self.titleLabel.text = news.title;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%ld",news.commentCount];
}

//通过xib加载时自动调用该方法，相当于纯代码中的init方法，通过纯代码创建对象时该方法是不会调用的
- (void)awakeFromNib {
    // Initialization code //初始化 代码
}
//单元格选中 和 反选时会被调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
