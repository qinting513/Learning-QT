//
//  DiscoveryHeaderReusableView.h
//  Chuye
//
//  Created by Qinting on 16/8/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Discovery.h"
@interface DiscoveryHeaderReusableView : UICollectionReusableView
@property (nonatomic,strong)  NSArray* users;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allBtns;
@end
