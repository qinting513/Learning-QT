//
//  DishCell.h
//  CollectionView菜谱
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dish.h"
@interface DishCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dishIV;

@property (nonatomic, strong)Dish *dish;

@end
