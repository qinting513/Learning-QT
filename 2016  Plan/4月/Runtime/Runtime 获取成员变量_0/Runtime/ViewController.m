//
//  ViewController.m
//  Runtime
//
//  Created by Qinting on 16/4/9.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "QTPerson.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)testMsgSend{
    /**   就是一直打不出有参数的objc_msgSend方法
     objc_msgSend()报错Too many arguments to function call ,expected 0,have3
     解决办法： Build Setting--> Apple LLVM 6.0 - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO
     */
    
    /** 
     1. 先导入头文件#import <objc/message.h>
     2. objc_msgSend 我们平常说的发消息 就是调用方法 */
    QTPerson *p = [[QTPerson alloc] init];
    
    [p setAge:10]; //这条语句最终转化成下面一条运行时语句，对象p发消息调用setter方法
     objc_msgSend(p, @selector(setAge:), 20);
    
    objc_msgSend(p, @selector(setName:),@"zhangsan");
    
    NSLog(@"name:%@ --- age:%d",p.name, p.age);

}

/** 获取所有的成员变量 */
- (void) testGetAllProperties{

    //step1: Ivar : Instance var
    unsigned int count = 0;
    /** 
     step3: 可以改造成字典转模型，
         通过字典dict[name] --可以取出变量名这个key对应的value
         通过 [self setvalue:dict[name] forKey:name]; 将字典取出的值赋给模型的变量
     */
    
    //step2: 获取所有的成员变量
    Ivar *ivars = class_copyIvarList([QTPerson class], &count);
    for(int i = 0; i<count; i++){
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"%d -- %s -- %s",i,name,type);
    }
    
    /**   还可以偷偷修改属性的值
     QTPerson *person = [QTPerson new];
     Ivar m_name = members[0];
     object_setIvar(person, m_name, @"zhanfen");
     */
}

/** 获取所有方法列表 */
- (void)testGetMethod
{
    unsigned int count = 0;
    Method *memberFuncs = class_copyMethodList([QTPerson class], &count);//所有在.m文件显式实现的方法都会被找到
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(memberFuncs[i]);
        NSString *methodName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"member method:%@", methodName);
    }
}

- (void)tryAddingFunction
{
    //添加新的方法试试(这种方法等价于对QTPerson类添加Category对方法进行扩展)：
    class_addMethod([QTPerson class], @selector(method: andString:), (IMP)myAdd,"666");
//    class_addMethod(<#Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
}
//具体的实现，即IMP所指向的方法   IMP  接口信息处理器  Interface Message Processor
int myAddingFunction(id self, SEL _cmd, int var1, NSString *str)
{
    NSLog(@"I am added funciton:%@",str);
    return 10;
}

int myAdd(id self, SEL _cmd,int a , NSString *str){
    NSLog(@"======add :%@",str);
    return a +str.intValue;
}

#pragma mark - 

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self testMsgSend];
    
    //runtime价值1:可以遍历类的所有成员变量来做一些事情（字典转模型）
    //runtime价值2:可以归档所有成员变量 －－在person类中
   [self tryAddingFunction];
        QTPerson *person = [[QTPerson alloc] init];
     [person method:10  andString:@"111"];

   [person release];
}













//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self testMsgSend];
//    
//    //runtime价值1:可以遍历类的所有成员变量来做一些事情（字典转模型）
//    //runtime价值2:可以归档所有成员变量 －－在person类中
//    [self testGetAllProperties];
//    
//    [self tryAddingFunction];
//    
//    [self testGetMethod];
//    
//    //尝试调用新增的方法
//    QTPerson *person = [[QTPerson alloc] init];
//    [person method:10  andString:@"111"];//当你敲入person实例后，是无法获得method的提示的，只能靠手敲。而且编译器会给出"-method" not found的警告，可以忽略
//    [person release];
//    /** 注意：method::方法的确被添加进类中了。有童鞋会问，如果在其他类文件中实例化QTPerson类，还能调用到-method方法吗？答案是可以的，我试验过，在MRC下尽管无法获得代码提示，但请坚定不移地敲入[person method:xx :xx]方法！(在ARC下会报no visible @interface 错误,所以切换到MRC模式下了) */
//}
@end
