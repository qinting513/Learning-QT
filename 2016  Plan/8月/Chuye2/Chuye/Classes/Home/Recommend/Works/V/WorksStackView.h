//
//  WorksStackView.h
//  Chuye
//
//  Created by Qinting on 16/8/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recommend.h"
#import "Works.h"
#import "Discovery.h"


@interface WorksStackView : UIView
+(id)loadXib;
@property (nonatomic,strong) RecommendDataWorks  *work;
@property (nonatomic,strong) DiscoveryDataWorks  *discoveryDataWorks;
@property (nonatomic,strong) WorksData  *worksData;
@property (weak, nonatomic) IBOutlet UIButton *stackViewBtn;
@end
