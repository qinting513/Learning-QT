//
//  ComprehensiveCaseController.m
//  AllAnimation
//
//  Created by Qinting on 16/4/25.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ComprehensiveCaseController.h"
#import "DCPathButton.h"
#import "DWBubbleMenuButton.h"
#import "MCFireworksButton.h"

@interface ComprehensiveCaseController ()<DCPathButtonDelegate>

/** 路径动画 */
@property (nonatomic,strong) DCPathButton *pathAnimationView;

/** 钉钉按钮 */
@property (nonatomic , strong) DWBubbleMenuButton *dingdingAnimationMenu;

/** 点赞 */
@property (nonatomic , strong) MCFireworksButton *goodBtn;

@property (nonatomic , assign) BOOL selected;

@end

@implementation ComprehensiveCaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)initView{
    [super initView];
    [self pathAnimation];
}

-(NSArray *)operateTitleArray{
    return @[@"Path",@"钉钉",@"点赞"];
}
-(NSString *)controllerTitle{
return @"综合动画";
}

-(void)clickBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self pathAnimation];
            break;
        case 1:
            //钉钉
            [self dingdingAnimation];
            break;
        case 2:
            [self clickGoodAnimation];
            break;
        default:
            break;
    }
}

#pragma mark - Path
/** 仿Path菜单动画 */
-(void)pathAnimation{

    if(_dingdingAnimationMenu){
        _dingdingAnimationMenu.hidden = YES;
    }
    
    if(_goodBtn){
        _goodBtn.hidden = YES;
    }
    
    if (!_pathAnimationView) {
        [self configureDCPathButton];
    }else{
        _pathAnimationView.hidden = NO;
    }
}


-(void)configureDCPathButton{
// Configure center button
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]   hilightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    _pathAnimationView = dcPathButton;
    
    //Configure item
    dcPathButton.delegate = self;
    
    // Configure item buttons
    //
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [dcPathButton addPathItems:@[itemButton_1, itemButton_2, itemButton_3, itemButton_4, itemButton_5]];
    
    [self.view addSubview:dcPathButton];

}

#pragma  mark - DCPathButtonDelegate
-(void)itemButtonTappedAtIndex:(NSUInteger)index{
    NSLog(@"You tap at :%ld",index);
}

#pragma mark - 钉钉菜单动画
/**
 * 仿照钉钉菜单动画
 */
-(void)dingdingAnimation{
    //要是点击了钉钉，其他的药隐藏
    if (_pathAnimationView) {
        _pathAnimationView.hidden = YES;
    }
    
    if(_goodBtn){
        _goodBtn.hidden = YES;
    }
    
    if(!_dingdingAnimationMenu){
        UILabel *homeLabel = [self createHomeButtonView];
        
        DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc]initWithFrame:
        CGRectMake(self.view.frame.size.width - homeLabel.frame.size.width - 20.f,
                   self.view.frame.size.height - homeLabel.frame.size.height - 20.f,
                   homeLabel.frame.size.width, homeLabel.frame.size.height)];
        upMenuView.homeButtonView = homeLabel;
        [upMenuView addButtons:[self createDemoButtonArray]];
        
        _dingdingAnimationMenu = upMenuView;
        [self.view addSubview: upMenuView];
    }else{
        _dingdingAnimationMenu.hidden = NO;
    }
}


- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"A", @"B", @"C", @"D", @"E", @"F"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(dwBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}


-(UILabel*)createHomeButtonView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    label.text = @"Tap";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:0 green:00 blue:0 alpha:0.5];
    label.layer.cornerRadius = label.frame.size.height * 0.5;
    label.clipsToBounds = YES;
    
    return label;
}

-(void)dwBtnClick:(UIButton *)btn{
    NSLog(@"点击的钉钉 按钮%ld",btn.tag);
}

//----------------------分割线--------------------------

#pragma  mark - 点赞
/** 
 * 仿照 facebook 点赞动画
 */

-(void)clickGoodAnimation{
    if (_pathAnimationView) {
        _pathAnimationView.hidden = YES;
    }
    
    if (_dingdingAnimationMenu) {
        _dingdingAnimationMenu.hidden = YES;
    }
    
    //如果没有则创建
    if (!_goodBtn) {
        _goodBtn = [[MCFireworksButton alloc]initWithFrame:
                    CGRectMake(SCREEN_WIDTH*0.5 - 25, SCREEN_HEIGHT * 0.5 - 25, 50, 50)];
        /** 设置图片 设置缩放范围 */
        _goodBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        _goodBtn.particleScale = 0.05;
        _goodBtn.particleScaleRange = 0.02;
        [_goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
        
        [_goodBtn addTarget:self  action:@selector(handleGoodBtnClick:)
                           forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_goodBtn];
    }else{
        _goodBtn.hidden = NO;
    }

}

-(void)handleGoodBtnClick:(UIButton *)btn{
   _selected = !_selected;
    if (_selected) {
        [_goodBtn popOutsideWithDuration:0.5];
        [_goodBtn setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        
    }else{
        [_goodBtn popInsideWithDuration:0.4];
        [_goodBtn setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    }
}

@end
