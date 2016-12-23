//
//  main.c
//  LinkStack
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//


#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "TLinkStack.h"

int main(int argc, const char * argv[]) {
    
    
    LinkStack *stack = NULL;
    stack = LinkStack_Create();
    if (stack == NULL) {
        return -1;
    }
    
    int a[10];
    //压栈
    for(int i = 0; i<10; i++)
    {
        a[i] = i + 1;
        LinkStack_Push(stack,&a[i]);
        printf("进栈的值:%d   ",a[i]);
    }
    printf("\n");
    // 求栈容量
    printf("LinkStack_Size: %d\n",LinkStack_Size(stack));
    // (int *)LinkStack_Top(stack) 强制类型转换，因为存进去的就是int *指针；外面的*是取内容
    printf("top:%d\n", *( (int *)LinkStack_Top(stack)) );// 求栈顶的值
    
    // 弹栈
    while (LinkStack_Size(stack) > 0 ) {
        int tmp = *( (int *)LinkStack_Pop(stack));
        printf("tmp:%d   ",tmp);
    }
    
    LinkStack_Destroy(stack);
    
    
    return 0;
}

