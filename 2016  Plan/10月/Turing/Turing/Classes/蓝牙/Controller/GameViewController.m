//
//  ViewController.m
//  Snake
//
//  Created by tarena on 16/9/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "GameViewController.h"
#import "JCBluetoothManager.h"

@interface GameViewController ()
@property (nonatomic)CGPoint beginPoint;
@property (nonatomic, strong)UIView *controlView;
@property (weak, nonatomic) IBOutlet UIImageView *moveImage;
@property (weak, nonatomic) IBOutlet UIView *moveView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *myPan;
@property (nonatomic, assign) CGFloat prexOffset;
@property (nonatomic, assign) CGFloat preyOffset;
@end

@implementation GameViewController{
    UIView *_sendView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"蓝牙小车";
    self.moveView.layer.cornerRadius = 100;
    self.moveView.layer.masksToBounds = YES;
    self.moveView.alpha = .5;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendTextView)];
}

- (void)sendTextView{
    
}

- (IBAction)panDirection:(UIPanGestureRecognizer *)sender {
    CGPoint position = [sender translationInView:self.moveView];
    
    CGPoint center = self.moveImage.center;
    center.x += position.x;
    center.y += position.y;
    
    //    NSLog(@"x=%f  y=%f  state:%d",self.moveImage.center.x,self.moveImage.center.y,self.myPan.state);
    
    self.moveImage.center = center;
    
    CGPoint currentPoint = position;
    
    float x = currentPoint.x-self.beginPoint.x;
    float y = currentPoint.y-self.beginPoint.y;
    
    if (x && y) {
        float xOffset = fabs(x)/(fabs(x)+fabs(y));
        float yOffset = fabs(y)/(fabs(x)+fabs(y));
        if (x<0) {
            xOffset*=-1;
        }
        
        if (y<0) {
            yOffset*=-1;
        }
        
        /*当差值大于0.1时才发送偏移值*/
        if ( fabsf(fabsf(xOffset) - fabsf(self.prexOffset)) > 0.1 || fabsf(fabsf(yOffset) - fabsf(self.preyOffset)) > 0.1) {
            [self sendxOffset:xOffset yOffset:yOffset];
            self.prexOffset = xOffset;
            self.preyOffset = yOffset;
        }
        
        //        NSLog(@"偏移值x=%f  y=%f",xOffset,yOffset);
        
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.moveImage.center = CGPointMake(100, 100);
    }
    [sender setTranslation:CGPointZero inView:self.moveView];//得到的坐标都是相对于上一次的坐标，所有每次都要清零
}
- (void)sendxOffset:(CGFloat)xOffset yOffset:(CGFloat)yOffset
{
    [[JCBluetoothManager shareCBCentralManager]sendString:[NSString stringWithFormat:@"%f,%f",xOffset,yOffset]];
}
- (IBAction)directionBTN:(UIButton *)sender {
    sender.selected = YES;
    for (UIButton *btn in sender.superview.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn != sender) {
                btn.selected = NO;
            }
        }
    }
    switch (sender.tag) {
        case 0:
            [[JCBluetoothManager shareCBCentralManager]sendString:@"up"];
            break;
        case 1:
            [[JCBluetoothManager shareCBCentralManager]sendString:@"down"];
            break;
        case 2:
            [[JCBluetoothManager shareCBCentralManager]sendString:@"left"];
            break;
        case 3:
            [[JCBluetoothManager shareCBCentralManager]sendString:@"right"];
            break;
        default:
            break;
    }
}
- (IBAction)stop:(UIButton *)sender {
    [[JCBluetoothManager shareCBCentralManager]sendString:@"stop"];
    for (UIButton *btn in sender.superview.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = NO;
        }
    }
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

@end
