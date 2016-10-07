//
//  WeiboTableViewController.h
//  WeiboDemo
//
//  Created by Qinting on 16/7/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BackBlock) (NSString *name, NSString *content);

@interface WeiboTableViewController : UITableViewController

@property (nonatomic,strong) BackBlock  backBlock;
@end
