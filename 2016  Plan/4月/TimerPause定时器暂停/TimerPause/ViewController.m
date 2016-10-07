//
//  ViewController.m
//  TimerPause
//
//  Created by Qinting on 16/4/14.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "NSTimer+pause.h"

@interface ViewController ()
- (IBAction)startTimer:(id)sender;

- (IBAction)pauseTimer:(id)sender;

- (IBAction)continueTimer:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startTimerBtn;

@property (weak, nonatomic) IBOutlet UILabel *showResultLabel;
- (IBAction)closeTimer:(id)sender;

@property(nonatomic,strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)startTimer:(id)sender {
    self.startTimerBtn.enabled = NO;
    self.showResultLabel.tag = 0;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRepeat) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (IBAction)pauseTimer:(id)sender {
    [self.timer pauseTimer];
}

- (IBAction)continueTimer:(id)sender {
    [self.timer resumeTimer];
}

-(void)timerRepeat{
    self.showResultLabel.text = @(self.showResultLabel.tag).stringValue;
    self.showResultLabel.tag ++;
}

- (IBAction)closeTimer:(id)sender {
    self.startTimerBtn.enabled = YES;
     self.showResultLabel.text = @"0";
    [self.timer invalidate];
    self.timer = nil;
}
@end
