//
//  QTTopicCell.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTTopicCell.h"
#import "QTVideoView.h"
#import "QTVoiceView.h"
#import "QTPictureView.h"

#define  CellMargin 10
@interface QTTopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
/** 内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** VIP头像 */
@property (weak, nonatomic) IBOutlet UIImageView *vipView;

/** 踩按钮 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 按钮 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论按钮 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 顶  按钮 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

/** 视频内容 */
@property (nonatomic,strong) QTVideoView *videoView;

/** 音频内容  */
@property (nonatomic,strong) QTVoiceView *voiceView;

/** 图片内容 */
@property (nonatomic,strong) QTPictureView *pictureView;

@end

@implementation QTTopicCell
#pragma mark - create Cell
/** 创建cell */
+(instancetype)cellWithTableView:(UITableView *)tableView{
   static NSString *cellID = @"QTTopicCell";
    QTTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

/** MVVM赋值 */
-(void)setTopicFrame:(QTTopicFrame *)topicFrame{
    _topicFrame = topicFrame;
    QTTopic *topic = topicFrame.topic;

    /** 顶部中间 */
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topic.image2] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createAtLabel.text = topic.created_at;
    self.contentLabel.text = topic.text;
    self.vipView.hidden = !topic.isSina_v;
    
    /** 底部按钮 */
    [self setButton:self.dingButton count:topic.love placeholder:@"顶"];
    [self setButton:self.caiButton count:topic.hate placeholder:@"踩"];
    [self setButton:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setButton:self.commentButton count:topic.comment placeholder:@"评论"];
    
    /** 中间内容 */
    QTContentView *contentView = nil;
    if (topic.type == QTTopicTypePicture) {
        contentView = self.pictureView;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if(topic.type == QTTopicTypeVideo){
        contentView = self.videoView;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }if (topic.type == QTTopicTypeVoice) {
        contentView = self.voiceView;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    contentView.hidden = NO;
    contentView.frame = topicFrame.contentFrame;
    contentView.topic = topic;
}

-(void)setButton:(UIButton *)button count:(int)count placeholder:(NSString *)placeholder{
    if (count > 1000) {
        placeholder = [NSString stringWithFormat:@"%.1fK",count/1000.0];
        placeholder = [placeholder stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count != 0) {
        placeholder = [NSString stringWithFormat:@"%d",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

#pragma mark - lazy
- (QTVideoView *)videoView {
	if(_videoView == nil) {
        _videoView = [QTVideoView videoView];
        [self.contentView addSubview:_videoView];
	}
	return _videoView;
}

- (QTVoiceView *)voiceView {
	if(_voiceView == nil) {
		_voiceView = [QTVoiceView voiceView];
        [self.contentView addSubview:_voiceView];
	}
	return _voiceView;
}

- (QTPictureView *)pictureView {
	if(_pictureView == nil) {
		_pictureView = [QTPictureView pictureView];
        [self.contentView addSubview:_pictureView];
	}
	return _pictureView;
}

-(void)setFrame:(CGRect)frame{
     //    frame.origin.x = CellMargin;
    //    frame.size.width -= 2*CellMargin;
    frame.origin.y += CellMargin;
    frame.size.height -= 2*CellMargin;
    
    [super setFrame:frame];
}

- (IBAction)caiBtnClick:(id)sender {
//    self.caiButton.selected = !self.selected;
//    [self.caiButton setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:UIControlStateSelected];
//    NSLog(@"%@",self.caiButton.currentTitle);
}
- (IBAction)dingBtnClick:(id)sender {
}


@end
