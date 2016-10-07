//
//  TemplateViewController.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "TemplateViewController.h"
#import "MainTabBarController.h"
#import "FavoritesViewController.h"
#import "Favorites.h"
#import "UserInfoUtils.h"

@interface TemplateViewController ()
@property (nonatomic,strong) Favorites  *favorites;
@end

@implementation TemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.favorites = [UserInfoUtils parseFavorites];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FavoritesViewController *vc = [sb instantiateViewControllerWithIdentifier:@"FavoritesViewController"];
    vc.favorites = self.favorites;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}







@end
