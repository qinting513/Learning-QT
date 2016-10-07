//
//  ViewController.m
//  GCDSocket
//
//  Created by Qinting on 16/5/15.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController () <GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *serverIPTextField;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;
@property (weak, nonatomic) IBOutlet UITextView *chartTextView;

@property (nonatomic,strong)  GCDAsyncSocket *clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)connectToServer:(id)sender {
    self.clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    uint16_t port = 8888;
    NSError *error = nil;
    
    if (![self.clientSocket connectToHost:self.serverIPTextField.text onPort:port  error:&error]) {
        //返回是否连接成功
        NSLog(@"客户端连接服务器端失败:%@", error.userInfo);
    }else{
        NSLog(@"正在连接－－－－－－");
    }
}

- (IBAction)sendMsg:(id)sender {
    NSData  *msg = [self.msgTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:msg withTimeout:-1 tag:100];
}

#pragma mark - socket 代理
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"连接服务器成功,可以发送消息");
    
    //执行接收数据(等待接收服务器的数据)
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *msgStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    self.chartTextView.text = [NSString stringWithFormat:@"%@ %@", self.chartTextView.text,msgStr];
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"客户端发送数据成功");
}

@end
