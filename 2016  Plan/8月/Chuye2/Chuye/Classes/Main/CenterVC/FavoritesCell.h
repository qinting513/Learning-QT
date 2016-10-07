//
//  FavoritesCell.h
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIButton *pageButton;
/** baocun */
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;

/**  */
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *transmitLabel;

@end
