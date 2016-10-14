//
//  NavRootVC.m
//  ScreenLockDemo
//
//  Created by Jone' on 16/1/16.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "NavRootVC.h"
#import "UIDevice+Info.h"
#import "SetLockViewController.h"

#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

@interface NavRootVC ()

@property (nonatomic, strong) NSArray *dataArr;;

@end

@implementation NavRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor lightGrayColor];
    if (iOS8) {
        NSString *deviceInfo = [UIDevice doDevicePlatform];
        NSLog(@"该设备为：%@",deviceInfo);
        NSDictionary *deviceList = @{@"iPhone5s":@"1",@"iPhone6":@"1",@"iPhone6 Plus":@"1",@"iPhone6s":@"1",@"iPhone6s Plus":@"1",@"iPad Air 2":@"1",@"iPad mini 3G":@"1",@"iPad mini 4G":@"1",@"iPad Pro 1G":@"1",@"iPhone Simulator":@"1"};
        if (deviceList[deviceInfo]) {
            _dataArr = @[@"手势",@"指纹"];
        }else{
            _dataArr = @[@"手势"];
        }
    }else{
        _dataArr = @[@"手势"];
    }
    self.tableView.tableFooterView = [UIView new];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SetLockViewController *lvc = [SetLockViewController new];
    
    lvc.type = indexPath.row==0?HJBLockTypeGesture:HJBLockTypeTouch;
    [self.navigationController pushViewController:lvc animated:YES];
    
}

@end
