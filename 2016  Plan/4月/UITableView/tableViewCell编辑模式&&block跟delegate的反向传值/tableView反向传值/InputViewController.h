//
//  InputViewController.h
//  tableView反向传值
//
//  Created by tarena01 on 15/11/17.
//  Copyright (c) 2015年 tarena01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

/** block */
typedef void(^ReturnCityBlock)(City *city);

@protocol InputViewControllerDelegate;

@interface InputViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITextField *populationTF;

@property (nonatomic,strong)id<InputViewControllerDelegate> delegate;

@property (nonatomic,strong) ReturnCityBlock returnCityBlock;

- (IBAction)clickSaveBtn:(UIButton *)sender;

@end

@protocol InputViewControllerDelegate <NSObject>

-(void)inputViewOController:(InputViewController*)inputVC didReturnCity:(City*)city;

@end