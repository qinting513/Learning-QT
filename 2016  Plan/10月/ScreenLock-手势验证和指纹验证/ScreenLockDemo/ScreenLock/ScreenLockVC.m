//
//  ScreenLockVC.m
//  LockScreenDemo
//
//  Created by Jone' on 15/12/28.
//  Copyright © 2015年 Jone. All rights reserved.
//

#import "ScreenLockVC.h"
#import "CoreLockConst.h"
#import "CLLockLabel.h"
#import "CLLockView.h"

#import "NSObject+Common.h"

#import <LocalAuthentication/LocalAuthentication.h>

#define MAXERRORNUM 5 /**< 最多错误次数 */

#define showAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

@interface ScreenLockVC ()

@property (weak, nonatomic) IBOutlet UIView *gestureView;/**< 手势锁视图 */
@property (weak, nonatomic) IBOutlet CLLockLabel *gestureTitleLab;/**< 提示信息 */
@property (weak, nonatomic) IBOutlet CLLockView *lockView;/**< 手势锁 */
@property (weak, nonatomic) IBOutlet UIButton *fogetGestureBtn;/**< 忘记手势按钮 */
@property (weak, nonatomic) IBOutlet UIView *touchView;/**< 指纹按钮视图 */

@property (nonatomic,copy) NSString *msg;
@property (nonatomic,assign) NSInteger errorNum; /**< 错误次数 */

@end

@implementation ScreenLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self labelWithType];

    [self event];
    [self isToucShow];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (_isTouch) {
        [self authenticateUser];
    }
}

- (void)isToucShow {
    if (!_isTouch) {
        _touchView.hidden = YES;
    }else{
        _gestureTitleLab.hidden = YES;
        _lockView.hidden = YES;
        _lockView.userInteractionEnabled = NO;
        [_fogetGestureBtn setTitle:@"使用账号密码登陆" forState:UIControlStateNormal];
    }
}


#pragma mark - gesture
-(void)labelWithType{
    _msg = CoreLockModifyNormalTitle;
    _fogetGestureBtn.hidden = YES;
    if(_type == CoreLockTypeSetPwd){//设置密码
        self.lockView.type = _type;
        self.title = @"设置密码";
        _msg = CoreLockPWDTitleFirst;
        
    }else if (_type == CoreLockTypeVeryfiPwd){//验证密码
        self.lockView.type = _type;
        self.title = @"验证密码";
        _msg = CoreLockVerifyNormalTitle;
        _fogetGestureBtn.hidden = NO;
        
    }else if (_type == CoreLockTypeModifyPwd){//修改密码
        self.lockView.type = _type;
        self.title = @"修改密码";
        _msg = CoreLockModifyNormalTitle;
    }

    [self.gestureTitleLab showNormalMsg:_msg];
    [self errorNumInit];
}
-(void)errorNumInit {
    _errorNum = [NSObject loadGestureErrorTimes];
    if (_errorNum!=0) {
        [self.gestureTitleLab showWarnMsg:[NSString stringWithFormat:@"%@,你还可以输入%ld次",CoreLockVerifyErrorPwdTitle,MAXERRORNUM-_errorNum]];
        if (_errorNum >= MAXERRORNUM) {
            _lockView.userInteractionEnabled = NO;
            _fogetGestureBtn.hidden = NO;
            showAlert(@"手势密码错误次数达到上限，请使用账号密码登陆");

        }
    }
}

-(void)event{
    __weak typeof(self) weakSelf = self;

    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    /*
     *  设置密码
     */
    
    /** 开始输入：第一次 */
    self.lockView.setPWBeginBlock = ^(){
        [weakSelf.gestureTitleLab showNormalMsg:CoreLockPWDTitleFirst];
    };
    /** 开始输入：确认 */
    self.lockView.setPWConfirmlock = ^(){
        [weakSelf.gestureTitleLab showNormalMsg:CoreLockPWDTitleConfirm];
    };
    /** 密码长度不够 */
    self.lockView.setPWSErrorLengthTooShortBlock = ^(NSUInteger currentCount){
        [weakSelf.gestureTitleLab showWarnMsg:[NSString stringWithFormat:@"请连接至少%@个点",@(CoreLockMinItemCount)]];
    };
    /** 两次密码不一致 */
    self.lockView.setPWSErrorTwiceDiffBlock = ^(NSString *pwd1,NSString *pwdNow){
        [weakSelf.gestureTitleLab showWarnMsg:CoreLockPWDDiffTitle];
    };
    /** 第一次输入密码：正确 */
    self.lockView.setPWFirstRightBlock = ^(){
        [weakSelf.gestureTitleLab showNormalMsg:CoreLockPWDTitleConfirm];
    };
    /** 再次输入密码一致 */
    self.lockView.setPWTwiceSameBlock = ^(NSString *pwd){
        NSLog(@"pwd = %@",pwd);
        //存储密码
        [userdefaults setObject:pwd forKey:@"gesture"];
        //清除错误次数
        [NSObject saveGestureErrorTimesWithNum:0];
        //禁用交互
        self.view.userInteractionEnabled = NO;
        if(CoreLockTypeModifyPwd == _type||CoreLockTypeSetPwd == _type){
            
            [weakSelf disMissVC];
        }
      
    };
   
    /*
     *  验证密码
     */
    
    /** 开始 */
    self.lockView.verifyPWBeginBlock = ^(){
        [weakSelf.gestureTitleLab showNormalMsg:CoreLockVerifyNormalTitle];
    };
    /** 验证 */
    self.lockView.verifyPwdBlock = ^(NSString *pwd){
        NSLog(@"验证->pwd:%@",pwd);
        
    BOOL res = [pwd isEqualToString:[userdefaults objectForKey:@"gesture"]];
        
    [self verifyPwdWith:res];
    return res;

};
    
    /*
     *  修改
     */
    
    /** 开始 */
    self.lockView.modifyPwdBlock =^(){
        
        [weakSelf.gestureTitleLab showNormalMsg:_msg];
    };
    
    
}

- (void)verifyPwdWith:(BOOL)isRight {

    if(isRight){//密码一致
        [self.gestureTitleLab showNormalMsg:CoreLockVerifySuccesslTitle];
        _errorNum = 0;
        [NSObject saveGestureErrorTimesWithNum:_errorNum];
        
        if(CoreLockTypeVeryfiPwd == _type){
            //验证成功
            self.view.userInteractionEnabled = NO;
            [self disMissVC];
        }else if (CoreLockTypeModifyPwd == _type){
            //修改密码
            [self.gestureTitleLab showNormalMsg:CoreLockPWDTitleFirst];
            _msg = CoreLockPWDTitleFirst;
        }
    }else{//密码不一致
        _errorNum++;
        [self.gestureTitleLab showWarnMsg:[NSString stringWithFormat:@"%@,你还可以输入%ld次",CoreLockVerifyErrorPwdTitle,MAXERRORNUM-_errorNum]];
        [NSObject saveGestureErrorTimesWithNum:_errorNum];
        if (_errorNum >= MAXERRORNUM) {
            NSLog(@"密码错误次数达到上限");
            _lockView.userInteractionEnabled = NO;
            _fogetGestureBtn.hidden = NO;
            showAlert(@"手势密码错误次数达到上限，请使用账号密码登陆");
        }
    }

}

/*
 *  是否设置过初始密码？
 */
+(BOOL)hasPwd{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *pwd = [userdefaults objectForKey:@"gesture"];;
    //NSString *pwd = [CoreArchive strForKey:CoreLockPWDKey];
    
    return pwd !=nil;
}

- (void)disMissVC {
    __weak typeof(self) weakSelf = self;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.navigationController) {
            [weakSelf.navigationController popViewControllerAnimated:YES];

        }else{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

- (IBAction)fogetGestureBtnClick:(UIButton *)sender {
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - authenticateUser

- (IBAction)touchIDBtnClick:(UIButton *)sender {
    [self authenticateUser];
}

- (void)authenticateUser
{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    //context.localizedFallbackTitle = @"输入密码";
    //错误对象
    NSError* error = nil;
    NSString* result = @"通过Home键验证已有手机指纹";
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                //验证成功，主线程处理UI
                NSLog(@"success 验证成功");
                __weak typeof(self) weakSelf = self;

                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    //切换主线程
                    [weakSelf disMissVC];
                }];
            }
            else
            {
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
                            showAlert(@"验证失败");

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
        
        NSLog(@"%@",error.localizedDescription);
        //[self showAlert];
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
