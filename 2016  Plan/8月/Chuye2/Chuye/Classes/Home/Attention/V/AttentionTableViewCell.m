//
//  AttentionTableViewCell.m
//  Chuye
//
//  Created by Qinting on 16/8/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import "UIView+Extension.h"

@interface AttentionTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailUrlIV;
@property (weak, nonatomic) IBOutlet UIImageView *previewFirstImgView;
@property (weak, nonatomic) IBOutlet UIImageView *previewSecondImgView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIView *likesUserContainerView;
@property (weak, nonatomic) IBOutlet UIButton *loveBtn;
@property (weak, nonatomic) IBOutlet UIButton *totalShareBtn;
@property (weak, nonatomic) IBOutlet UIView *commentsContainerView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *userLikeBtns;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *commentLabels;

@end

@implementation AttentionTableViewCell

- (IBAction)loadMoreComents:(id)sender {
    
}
+(id)loadCell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


-(void)setData:(AttentionData *)data{
    _data = data;
    [self.thumbnailUrlIV sd_setImageWithURL:[NSURL URLWithString:data.ThumbnailUrl]
                           placeholderImage:[UIImage imageNamed:@"work_pic"]];
    NSArray *imgArr = [data.PreviewImgUrl componentsSeparatedByString:@","];
    if(imgArr.count >= 3)
    [self.previewFirstImgView sd_setImageWithURL:[NSURL URLWithString:imgArr[1]] placeholderImage:[UIImage imageNamed:@"work_pic"]];
        [self.previewSecondImgView sd_setImageWithURL:[NSURL URLWithString:imgArr.lastObject] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:data.User.HeadPhoto] placeholderImage:[UIImage imageNamed:@"work_pic"]];
    self.userNicknameLabel.text = data.User.Nickname;
    self.titleLabel.text = data.Title;
    self.totalLabel.text = [NSString stringWithFormat:@"● %ld 查看 / %ld分享 | %ld 收藏",data.Total.Visit,data.Total.Share,data.Total.Text];
    [self.totalShareBtn setTitle:[NSString stringWithFormat:@"%ld",data.Total.Like] forState:UIControlStateNormal];
    
    for (int i = 0; i< 7 ; i++) {
        UIButton *b =  self.userLikeBtns[i];
        AttentionDataLikes *userLike = data.Likes[i];
//        NSLog(@"----%@",userLike.User.HeadPhoto);
         [b setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:userLike.User.HeadPhoto]];
    }
    for(int i = 0; i< 2; i++){
        UILabel *la = self.commentLabels[i];
        AttentionDataComments *comment = data.Comments[i];
        NSString *comStr = [NSString stringWithFormat:@"%@:%@",comment.User.Nickname,comment.Content];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:comStr attributes:nil];
        NSRange range = NSMakeRange(0, comment.User.Nickname.length);
//        NSLog(@"range:%ld",data.Comments.count);
        [att addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
        la.attributedText = att;
    }
    [self.loadMoreCommentsBtn setTitle:[NSString stringWithFormat:@"查看全部%ld条评论",data.Comments.count] forState:UIControlStateNormal];
}


-(void)layoutSubviews{
    [super layoutSubviews];
//    self.userHeadImgView.layer.cornerRadius = self.userHeadImgView.frame.size.width * 0.5;
//    self.userHeadImgView.layer.masksToBounds = YES;
    
    [self.userHeadImgView circleImage];
    [self.totalShareBtn circleImage];
    for (UIButton *b in self.userLikeBtns) {
        [b circleImage];
    }
}



@end
