//
//  AppDelegate.m
//  UIAnimation
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface  ViewController : UIViewController <iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;

@property (nonatomic,assign) BOOL wrap;

- (IBAction)switchCarouselType;
/** toggle 触发   wrap 包 展开*/
- (IBAction)toggleWrap;

@end
