什么是runtime？
1> runtime是一套底层的C语言API（包含很多强大实用的C语言数据类型、C语言函数）
2> 实际上，平时我们编写的OC代码，底层都是基于runtime实现的
* 也就是说，平时我们编写的OC代码，最终都是转成了底层的runtime代码（C语言代码）

runtime有啥用？
1> 能动态产生一个类、一个成员变量（比如用runtime给分类添加属性）、一个方法
2> 能动态修改一个类、一个成员变量、一个方法
3> 能动态删除一个类、一个成员变量、一个方法

常见的函数、头文件
#import <objc/runtime.h> : 成员变量、类、方法
Ivar * class_copyIvarList : 获得某个类内部的所有成员变量
Method * class_copyMethodList : 获得某个类内部的所有方法
Method class_getInstanceMethod : 获得某个实例方法（对象方法，减号-开头）
Method class_getClassMethod : 获得某个类方法（加号+开头）
method_exchangeImplementations : 交换2个方法的具体实现

#import <objc/message.h> : 消息机制
objc_msgSend(....)


#import <objc/runtime.h>
/** 通过runtime函数 重写setter 和 getter 方法
 Associated 结交 联合
 */
-(NSString *)name{
    //_cmd 当前方法的指针地址
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setName:(NSString *)name{
    //把name属性绑定到self的@selecor(name)方法的指针的地址key上
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

runtime动态添加属性的一个例子！（未读消息角标）
关于runtime 给分类添加一个属性 的应用，有一篇博客写得不错，http://www.cnblogs.com/wengzilin/p/4633937.html
或者直接看代码 https://github.com/weng1250/WZLBadge