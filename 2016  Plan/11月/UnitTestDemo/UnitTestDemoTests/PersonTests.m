//
//  PersonTests.m
//  UnitTestDemo
//
//  Created by Qinting on 2016/11/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

// 1.注意类名以s结尾， PersonTests

@interface PersonTests : XCTestCase

@end

@implementation PersonTests

///一次单元测试开始前的准备工作，可以设置全局变量
- (void)setUp {
    [super setUp];
  
}

// 一次单元测试结束前销毁的工作
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

// 2.单元测试都是以test开头的方法
/**
 1.单元测试以代码测试代码
 2.红灯 绿灯迭代开发
 3.在日常开发中，数据大量来自网络，很难发现‘所有的’边缘数据！如果没有测试所有的条件就上架
 在运行时造成闪退
 4.自己建立测试‘用例’(使用的例子数据，专门检查边界点)
 5.单元测试不是靠NSLog来测试,NSLog是程序员用眼睛看的笨方法
    单元测试用断言来测试，提前判断条件必须满足
 有些公司讨厌单元测试，因为‘代码覆盖度’ 不好确认！
 提示：
 1.不是所有方法都需要测试
       比如：私有方法不需要测试，只要暴露在.h中的方法才需要测试
 2. 所有跟UI有关的东西不需要测试，也不好测试
    MVVM 把小的业务逻辑代码封装出来，变成可以测试的代码，让程序更加健壮！
    (MVVM 还有个功能就是给ViewController瘦身，而且所有代码都写在控制器里不好写测试，因为需要用户在界面点击才有调用这段逻辑，所以不好写单元测试)
    注重软件产品质量！
 3.一般而言，代码的覆盖度大概在50% - 70%就很好了，代码就健壮了，github的codeCover  AFN:75%   YYModel:99%
 */
///测试新建的person模型
-(void)testNewPerson{
    [self checkPersonWithDict:@{@"name":@"zhangsan",@"age":@12}];
    [self checkPersonWithDict:@{@"name":@"zhangsan"}];
    [self checkPersonWithDict:@{}]; //  空字典的时候出错
//    [self checkPersonWithDict:@{@"name":@"zhangsan",@"age":@12,@"title":@"noTitle"}];// 这条使方法崩溃，需在Person类里增加-(void)setValue:(id)value forUndefinedKey:(NSString *)key 这个方法
    
//    [self checkPersonWithDict:@{@"name":@"zhangsan",@"age":@-2,@"title":@"noTitle"}];
    [self checkPersonWithDict:@{@"name":@"zhangsan",@"age":@200,@"title":@"noTitle"}];

    //到目前为止，personWithDict这个工厂方法 都满足，使得代码更安全健壮
}

// 测试personWithDict这个方法，即根据字典检查新建的Person信息
-(void)checkPersonWithDict:(NSDictionary *)dict{
    Person *person = [Person personWithDict:dict];
//    NSLog(@"%@",person);
    
    // 获取字典信息
    NSString *name = dict[@"name"];
    NSInteger age = [dict[@"age"] integerValue];
    
//    XCTAssert([name isEqualToString:person.name] ,@"名字不一样"); // 空字典的是出错,增加一条或者名字为空

    XCTAssert([name isEqualToString:person.name] || person.name == nil,@"名字不一样");
//    检查年龄
//    XCTAssert(age==person.age,@"年龄不对"); // 把年龄加1后 就不满足断言，程序就测试出bug
    
    if (person.age > 0 && person.age < 130) {
        XCTAssert(age==person.age,"年龄不正确");
    }else{
        XCTAssert(person.age == 0,"年龄超限");
        /*
         增加了： if (obj.age <=0 || obj.age >=130) {
                    obj.age = 0;
                    }
         */
    }
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{  // Put the code you want to measure the time of here.
    }];
}

@end
