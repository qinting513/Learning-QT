//
//  SetLockViewController.m
//  Honkib
//
//  Created by Jone' on 15/12/30.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "SetLockViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "ScreenLockVC.h"

#import "NSObject+Common.h"
#import "MBProgressHUD+Add.h"

#define showAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]


@interface SetLockViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSArray *_dataArr;
    UISwitch *_switch;
    NSInteger _status;
}

@end

@implementation SetLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightTextColor];
    if (_type==HJBLockTypeTouch) {
        _dataArr = @[@"指纹"];
    }else{
        _dataArr = @[@"手势"];
    }
    self.title = _dataArr[0];
    [self tableViewInit];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self lockStatusInit];
    
}
#pragma mark - tableview
- (void)tableViewInit {
    CGRect bound = [UIScreen mainScreen].bounds;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, bound.size.width, bound.size.height)];
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [UIView new];
    _switch = [[UISwitch alloc]init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
    if (indexPath.row==0) {
        _switch.frame = CGRectMake(tableView.frame.size.width-60, 8, 60.0f, 28.0f);
        [_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:_switch];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
        //修改手势
        ScreenLockVC *svc = [[ScreenLockVC alloc]init];
        svc.type = CoreLockTypeModifyPwd;
        [self.navigationController pushViewController:svc animated:YES];
    }
}
#pragma mark - set
- (void)lockStatusInit {
    _status = [NSObject loadIsSreenLockOpened];
    switch (_status) {
        case 0:
            _switch.on = NO;
            break;
        case 1:
            _switch.on = _type==HJBLockTypeTouch?YES:NO;
            break;
        case 2:{
            _switch.on = _type==HJBLockTypeGesture?YES:NO;
            if (_type==HJBLockTypeGesture) {
                _dataArr = @[@"手势",@"重设手势"];
                [_tableView reloadData];

            }
        }
            break;
        default:
            break;
    }
}
- (void)switchAction:(UISwitch *)sender {
    if (_type==HJBLockTypeTouch) {
        [self LockTouchIsOn:sender.on];
    }else{
        [self LockGestureIsOn:sender.on];
    }
}
- (void)LockTouchIsOn:(BOOL)on {
    if (on) {
        //开启指纹
        if (_status==2) {
            //已开手势，先关闭手势，在开启指纹
            [self showAlertWithTitle:@"继续开启指纹解锁\n将关闭手势解锁" content:@"" andType:1];
        }else{
            //直接开启指纹
            [self authenticateUser];
        }
    }else{
        //关闭指纹
        [self showAlertWithTitle:@"确定关闭指纹解锁？" content:@"" andType:0];
    }
}
- (void)LockGestureIsOn:(BOOL)on {
    if (on) {
        //开启手势
        if (_status==1) {
            //已开指纹，先关闭指纹，在开启手势
            [self showAlertWithTitle:@"继续开启手势解锁\n将关闭指纹解锁" content:@"" andType:2];
        }else{
           //直接开启手势
            [self statrGesture];
        }
    }else{
        //关闭手势
        [self showAlertWithTitle:@"" content:@"确定关闭手势解锁？" andType:0];
    }
}

- (void)showAlertWithTitle:(NSString *)title content:(NSString *)text andType:(NSInteger)type {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        _switch.on = !_switch.on;
    }];
    __weak typeof(self)weakSelf = self;
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        switch (type) {
            case 0:{
                //直接关闭指纹或手势
                [NSObject saveScreeenLockWithStatus:0];
                _switch.on = NO;
                if (_type==HJBLockTypeGesture) {
                    _dataArr = @[@"手势"];
                    [_tableView reloadData];
                    [NSObject saveGestureErrorTimesWithNum:0];
                }
            }
                break;
            case 1:{
                //关闭手势开启指纹
                [weakSelf authenticateUser];
                [NSObject saveGestureErrorTimesWithNum:0];
            }
                break;
            case 2:{
                //关闭指纹开启手势
                [weakSelf statrGesture];
//                [NSObject saveScreeenLockWithStatus:2];
//                _switch.on = NO;
            }
                break;
            default:
                break;
        }
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 开启手势，设置密码
- (void)statrGesture {
    ScreenLockVC *svc = [[ScreenLockVC alloc]init];
    svc.type = CoreLockTypeSetPwd;
    [self.navigationController pushViewController:svc animated:YES];

}
#pragma mark - 开启指纹
- (void)authenticateUser
{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"";
    //错误对象
    NSError* error = nil;
    NSString* result = @"通过Home键验证已有手机指纹";
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    //用户选择输入密码，切换主线程处理
                    [MBProgressHUD showSuccess:@"验证成功" toView:nil];
                    [NSObject saveScreeenLockWithStatus:1];
                    _switch.on = YES;
                }];
            }
            else
            {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    _switch.on = !_switch.on;
                    
                }];
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                        }];
                        break;
                    }case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"输错密码user failed to provide valid credentials");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户输错密码，切换主线程处理
                            [MBProgressHUD showError:@"验证失败" toView:nil];

                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        _switch.on = !_switch.on;
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                showAlert(@"你还没有设置指纹密码，请先设置指纹密码");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                showAlert(@"你还没有设置密码，请先设置密码");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                showAlert(@"你的Touch ID似乎不可用，请检查设备");
                break;
            }
        }
//        NSLog(@"%@",error.localizedDescription);

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
