//
//  ViewController.m
//  链式与函数式编程
//
//  Created by Qinting on 2016/10/29.
//  Copyright © 2016年 QT. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [Person new];
    [person run1];
    [person eat1];
    
    /** 函数式编程 */
    [[person run2] eat2];
    
    /** 链式编程 */
    person.run3().eat3();
    person.run4(1000).eat4(@"water").run4(100).eat4(@"sha");
    
    /** 使用场景：
     1.封装自己的库
     2.阅读别人写的库 比如Masonry
     
     不好的地方是：OC里都是用中括号，而链式编程用点号破坏了整体结构的一致性
     
     链式编程的特点：
     1. 方法的返回值是block。
     2. 这个block必须有返回值，并且这个返回值就是对象本身；block也有输入参数。
     
     
     函数式编程：
     就是当对象调用完一个函数之后，返回的还是这个对象本身，紧接着又可以继续调用此函数或者对象中定义的其他函数。
    函数式编程的代表：ReactiveCocoa框架。
     */
}

@end
