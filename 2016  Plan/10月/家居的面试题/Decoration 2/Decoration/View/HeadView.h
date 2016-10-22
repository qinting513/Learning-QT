//
//  HeadView.h
//  Decoration
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *masterIV;
@property (weak, nonatomic) IBOutlet UILabel *masterLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *liveBtn;
@property (weak, nonatomic) IBOutlet UIImageView *masterBgIV;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


+(instancetype)loadView;
@end
