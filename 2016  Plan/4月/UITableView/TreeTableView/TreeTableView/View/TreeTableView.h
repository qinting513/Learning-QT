//
//  TreeTableView.h
//  TreeTableView
//
//  Created by Qinting on 16/4/24.
//  Copyright © 2016年 Qinting. All rights reserved.
//
#import <UIKit/UIKit.h>



@class Node;

@protocol TreeTableViewDelegate <NSObject>

- (void)cellClick:(Node*)node;

@end

@interface TreeTableView : UITableView

@property (nonatomic,weak) id<TreeTableViewDelegate> treeTableViewDelegate;

-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray*)data;

@end
