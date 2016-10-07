//
//  ViewController.m
//  CSocket
//
//  Created by Qinting on 16/5/15.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSStreamDelegate>
{
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)login:(id)sender {
}

- (IBAction)connectToServer:(id)sender {
    // 1.实现3次握手
    NSString *host = @"127.0.0.1";
    int port = 12345;
    // 2.定义输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
     // 3.分配输入输出流
    CFStreamCreatePairWithSocketToCFHost(NULL, (__bridge  CFHostRef)host, port, &readStream, &writeStream);
    
    
    // 4.把C语言的输入输出流转成OC对象
    _inputStream = (__bridge NSInputStream*) readStream;
    _outputStream = (__bridge NSOutputStream*)writeStream;
    
    //5.设置代理
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    // 6.添加到主运行循环
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    // 7.打开输入输出流
    [_inputStream open];
    [_outputStream open];
    
}

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
        case NSStreamEventNone: {
            NSLog(@" 没有事件发生");
            break;
        }
        case NSStreamEventOpenCompleted: {
            NSLog(@"打开成功");
            break;
        }
        case NSStreamEventHasBytesAvailable: {
            NSLog(@"可以读取数据");
            break;
        }
        case NSStreamEventHasSpaceAvailable: {
            NSLog(@"可以发送数据 ");
            break;
        }
        case NSStreamEventErrorOccurred: {
            NSLog(@" 错误事件发生，连接失败");
            break;
        }
        case NSStreamEventEndEncountered: {
            NSLog(@"正常的断开连接");
            break;
        }
    }
    
}



@end
