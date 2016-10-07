//
//  QTPictureView.m
//  BaiSiBuDeJie
//
//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTPictureView.h"

@interface QTPictureView ()
@property (weak, nonatomic) IBOutlet M13ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageButton;

@end

@implementation QTPictureView

+ (id)pictureView{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.progressView.secondaryColor  = [UIColor lightGrayColor];
    self.progressView.primaryColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
}

-(void)setTopic:(QTTopic *)topic{
    [super setTopic:topic];
 
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image2] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden  = NO;
        [self.progressView setProgress:receivedSize * 1.0 / expectedSize animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    self.gifImageView.hidden = ![topic.image2.pathExtension.lowercaseString isEqualToString:@"gif"];
    if (topic.isBigImage) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.seeBigImageButton.hidden = NO;
    }else{
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.seeBigImageButton.hidden = YES;
    }
    
}


@end
