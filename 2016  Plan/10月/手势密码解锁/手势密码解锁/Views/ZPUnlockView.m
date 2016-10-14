//
//  ZPUnlockView.m
//  手势密码解锁
//
//  Created by ios on 15-12-4.
//  Copyright (c) 2015年 ios. All rights reserved.
//
#import "ZPFmdbTool.h"
#import "ZPUnlockView.h"
@interface ZPUnlockView ()
//所有按钮
@property(nonatomic,strong)NSMutableArray *buttonsArray;
//被选中按钮
@property(nonatomic,strong)NSMutableArray *selectedbuttonsArray;

//当前点
@property(nonatomic,assign)CGPoint currentPoint;

//起始点
@property(nonatomic,assign)CGPoint startPoint;

//终结的点
@property(nonatomic,assign)CGPoint endPoint;

@end

@implementation ZPUnlockView

- (NSMutableArray *)buttonsArray{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
- (NSMutableArray *)selectedbuttonsArray{
    if (!_selectedbuttonsArray) {
        _selectedbuttonsArray = [NSMutableArray array];
    }
    return _selectedbuttonsArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i=0; i<9; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = i+1;
            btn.userInteractionEnabled = NO;
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];

            [self.buttonsArray addObject:btn];
            [self addSubview:btn];
        }
       }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
   
        // 设置每个按钮的frame
        CGFloat marginSartX = 20;
        CGFloat margin = 15;
    
        // 列（和行）的个数
        int columns = 3;
        // 计算水平方向和垂直方向的间距
        CGFloat W = (self.frame.size.width - (columns+1) * margin) / columns;
        CGFloat H = W;
        
        for (int i = 0; i < self.buttonsArray.count; i++) {
            UIButton* btn = self.buttonsArray[i];
            
            int row = i / columns;
            int col = i % columns;
            
            CGFloat x = margin + col * (W + margin);
            CGFloat y = marginSartX+margin + row * (H + margin);
            
            btn.frame = CGRectMake(x, y, W, H);
            
        }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    self.startPoint = point;
    for (int i=0; i<self.buttonsArray.count; i++) {

        UIButton *btn = self.buttonsArray[i];
        //判断给定的点是否被一个CGRect包含
        if (CGRectContainsPoint(btn.frame, point)&&!btn.selected){
            btn.selected = YES;

            [self.selectedbuttonsArray addObject:btn];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    self.currentPoint = point;

    for (int i=0; i<self.buttonsArray.count; i++) {
        UIButton *btn = self.buttonsArray[i];
        if (CGRectContainsPoint(btn.frame, point)&&!btn.selected){
            btn.selected = YES;
            [self.selectedbuttonsArray addObject:btn];
            
            break;
            
        }
    }
    [self setNeedsDisplay];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    

    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    for (int i=0; i<self.buttonsArray.count; i++) {
        UIButton *btn = self.buttonsArray[i];
        
    
        if (CGRectContainsPoint(btn.frame, point)&&!btn.selected) {
            btn.selected = YES;
            [self.selectedbuttonsArray addObject:btn];
        }
    }
    [self setNeedsDisplay];
    for (UIButton *btn in self.buttonsArray) {
        if (CGRectContainsPoint(btn.frame, self.startPoint)) {
            [self judgePassword];
            break;
        }
        
    }
    
   
}
- (void)drawRect:(CGRect)rect {
    if (self.selectedbuttonsArray.count==0)return;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    
    [[UIColor blueColor] set];

    for (int i=0;i<self.selectedbuttonsArray.count; i++) {
        UIButton *btn = self.selectedbuttonsArray[i];
        if (i==0) {
            [path moveToPoint:btn.center];
        }else {
            [path addLineToPoint:btn.center];
        }
        
    }
    
        [path addLineToPoint:self.currentPoint];

        
    
    [path stroke];
    
    
}


//判断是否密码正确
- (void)judgePassword{
    NSMutableString *mstr = [NSMutableString string];
    [self.selectedbuttonsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = obj;
        [mstr appendFormat:@"%@",@(btn.tag)];
    }];
    
    
    NSString *str = [[ZPFmdbTool sharedDatabaseQueue]querylastPassword];
        if ([mstr isEqualToString:str]) {
            for (UIButton *btn in self.selectedbuttonsArray) {
                btn.selected = NO;
                
            }
            [self.selectedbuttonsArray removeAllObjects];
            
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];

            
        }else if(str){

            [self.selectedbuttonsArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                    btn.enabled = NO;
                    btn.selected = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    btn.enabled = YES;

                });
            }];
            [self.selectedbuttonsArray removeAllObjects];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            [self.selectedbuttonsArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
                btn.enabled = NO;
                btn.selected = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    btn.enabled = YES;
                    
                });
            }];
            [self.selectedbuttonsArray removeAllObjects];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码为空" delegate:nil cancelButtonTitle:@"去设置" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
}
@end
