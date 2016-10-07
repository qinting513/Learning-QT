//
//  DishCell.m
//  CollectionView菜谱
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DishCell.h"

@implementation DishCell

-(void)setDish:(Dish *)dish{
    _dish = dish;
    
    self.nameLabel.text = dish.title;
    self.dishIV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dish.albums]]];
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

@end
