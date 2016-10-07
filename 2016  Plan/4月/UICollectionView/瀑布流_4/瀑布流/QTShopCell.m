//
//  QTShopCell.m
//  04-瀑布流
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "QTShopCell.h"
#import "QTShop.h"
#import "UIImageView+WebCache.h"

@interface QTShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation QTShopCell

- (void)setShop:(QTShop *)shop
{
    _shop = shop;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = shop.price;
}
@end
