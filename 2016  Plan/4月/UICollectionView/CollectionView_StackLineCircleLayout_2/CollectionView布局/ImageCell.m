//
//  ImageCell.m
//  CollectionView布局
//
//  Created by Qinting on 16/7/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 5.0;
    self.imageView.layer.borderWidth = 5.0;
    self.imageView.layer.masksToBounds = YES;
}

-(void)setImageName:(NSString *)imageName
{
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
