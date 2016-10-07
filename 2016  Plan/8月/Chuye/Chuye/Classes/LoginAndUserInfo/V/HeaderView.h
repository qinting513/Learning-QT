//
//  HeaderView.h
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 选择显示的类型 */
typedef NS_ENUM(NSUInteger,ShowType){
    ShowTypeWorks = 0,
    ShowTypeSketch,
    ShowTypeTransmit,
    ShowTypeJoin  //拿收藏的数据显示
};

typedef void(^ShowTypeBtnsClickAtIndex)(NSInteger index);

@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headerPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIButton *fansBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoritesBtn;

- (IBAction)editProfileBtnClick:(id)sender;

/** 作品 */
@property (weak, nonatomic) IBOutlet UIButton *worksBtn;
//草稿
@property (weak, nonatomic) IBOutlet UIButton *sketchBtn;
//
@property (weak, nonatomic) IBOutlet UIButton *transmitBtn;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;



@property (nonatomic,strong) ShowTypeBtnsClickAtIndex  showTypeBtnsClickAtIndex;

@end
