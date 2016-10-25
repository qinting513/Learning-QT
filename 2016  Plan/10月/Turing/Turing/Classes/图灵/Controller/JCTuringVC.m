//
//  ViewController.m
//  图灵机器人
//
//  Created by Guo.JC on 16/8/31.
//  Copyright © 2016年 Guo.JC. All rights reserved.
//

#import "JCTuringVC.h"
#import "JCTuringPopView.h"
#import "ISRDataHelper.h"

@interface JCTuringVC ()<IFlySpeechSynthesizerDelegate,IFlySpeechRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *showText;
@property (weak, nonatomic) IBOutlet UIImageView *robot;
@property(nonatomic,strong)IFlySpeechRecognizer *iFlySpeechRecognizer;
@property(nonatomic,strong)NSString *result;
@property (weak, nonatomic) IBOutlet UITextField *inputTV;

@end

@implementation JCTuringVC{
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
    UIView *popView;
    UILabel *popLaebl;
    JCTuringPopView *JCpopView;
}

#pragma mark 发送文本至图灵
- (IBAction)sendMessege:(UIButton *)sender {
    [JCTuRingUtils sendMessegeToTuringWith:self.inputTV.text andComplete:^(id obj) {
        JCpopView.text = obj;
        [[JCVoiceUtils sharedVoice]textTransferVoiceWithText:obj];
        if ([obj isEqualToString:kOpenWeather]) {//打开天气
            [NSThread sleepForTimeInterval:1];
            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[1];
        }
        if ([obj isEqualToString:kOpenTime]) {//打开时景
            [NSThread sleepForTimeInterval:1];
            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[2];
        }
        if ([obj isEqualToString:kOpenMe]) {//打开我
            [NSThread sleepForTimeInterval:1];
            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[3];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[JCVoiceUtils sharedVoice ]textTransferVoiceWithText:@"欢迎使用图灵智能,我是图灵机器人大秦"];
    
    JCpopView = [[JCTuringPopView alloc]init];
    JCpopView.text = @"欢迎使用图灵智能,我是图灵机器人大秦";
    [self.robot addSubview:JCpopView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(voiceTransSeccess:) name:@"语音转化完成" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(speakFinish) name:@"speakEnd" object:nil];
}
#pragma mark 语音播放结束
-(void)speakFinish
{
    [UIView animateWithDuration:1 animations:^{
        JCpopView.alpha = 0;
        self.showText.text = @"";
    }];
}

#pragma mark 语音转换完成处理
-(void)voiceTransSeccess:(NSNotification*)noti
{
    NSString *result = noti.object;
    self.showText.text = result;
//    [[JCVoiceUtils sharedVoice]textTransferVoiceWithText:result];
    [JCTuRingUtils sendMessegeToTuringWith:result andComplete:^(id obj) {//发送至图灵
        JCpopView.alpha = 1;
        JCpopView.text = obj;
        [[JCVoiceUtils sharedVoice]textTransferVoiceWithText:obj];
        if ([obj isEqualToString:kOpenWeather]) {//打开天气
            [NSThread sleepForTimeInterval:1];
            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[1];
        }
        if ([obj isEqualToString:kOpenTime]) {//打开时景
            [NSThread sleepForTimeInterval:1];
            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[2];
        }
        if ([obj isEqualToString:kOpenMe]) {//打开我
            [NSThread sleepForTimeInterval:1];
            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[3];
        }
    }];
}
#pragma mark 拖动机器人
- (IBAction)panTuring:(UIPanGestureRecognizer *)sender {
    
    CGPoint position = [sender translationInView:self.view];
    
    CGPoint center = self.robot.center;
    center.x += position.x;
    center.y += position.y;
    self.robot.center = center;
    
    [sender setTranslation:CGPointZero inView:self.view];
}
#pragma mark 点击Eva
- (IBAction)tapEva:(UITapGestureRecognizer *)sender {
    static int i = 0;
    
    switch (i) {
        case 0:
        {
            [UIView animateWithDuration:.5 animations:^{
                self.robot.image = [UIImage imageNamed:@"wall-e_robot_Away"];
                i++;
            }];
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:.5 animations:^{
                self.robot.image = [UIImage imageNamed:@"wall-e_robot_Awake"];
                i++;
            }];
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:.5 animations:^{
                self.robot.image = [UIImage imageNamed:@"wall-e_robot_Flap_1"];
                i++;
            }];
        }
            break;
            
        default:
            break;
    }
    if (i == 3) {
        i = 0;
    }
    
}

#pragma mark 点击说话
- (IBAction)start:(id)sender {
    
    [[JCVoiceUtils sharedVoice] startVoiceTransToText];
}
- (IBAction)longPressStartSpech:(UILongPressGestureRecognizer *)sender {
    
//    if (!popView) {
//        popView = [[UIView alloc]initWithFrame:CGRectMake(70, -30, 10, 80)];
//        popView.backgroundColor = [UIColor clearColor];
//        UIImageView *popBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_icon_blue"]];
//        popBG.backgroundColor = [UIColor grayColor];
//        popBG.frame = CGRectMake(0, 0, popView.bounds.size.width, popView.bounds.size.height);
//        [popView addSubview:popBG];
//        popLaebl = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, popView.frame.size.width - 4, popView.frame.size.height - 8)];
//        popLaebl.backgroundColor = [UIColor clearColor];
//        popLaebl.textColor = [UIColor clearColor];
//        [popView addSubview:popLaebl];
//    }

    [self.robot addSubview:popView];
    
    self.showText.text = @"开始翻译";
//    [_iFlySpeechRecognizer cancel];
//    //设置音频来源为麦克风
//    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
//    //设置听写结果格式为json
//    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
//    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
//    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
//    [_iFlySpeechRecognizer setDelegate:self];
//    [_iFlySpeechRecognizer startListening];
}
//4.IFlySpeechSynthesizerDelegate 实现代理



- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    self.result =[NSString stringWithFormat:@"%@%@", self.showText.text,resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    self.showText.text = [NSString stringWithFormat:@"%@%@", self.showText.text,resultFromJson];
    
    if (isLast){
        NSLog(@"听写结果(json)：%@测试", self.result);
    }
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_textView.text=%@",isLast,self.showText.text);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputTV resignFirstResponder];
}

//是否支持旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //只支持竖屏
    return UIInterfaceOrientationMaskPortrait;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"speakEnd" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"语音转化完成" object:nil];
}
@end
