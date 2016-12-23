//
//  main.c
//  SeqStack
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>
#include "SeqStack.h"

int main(int argc, const char * argv[]) {
    
  
    SeqStack *stack = NULL;
    stack = SeqStack_Create(10);
    if (stack == NULL) {
        return -1;
    }
    
    int a[10];
    //压栈
    for(int i = 0; i<10; i++)
    {
        a[i] = i + 1;
        SeqStack_Push(stack,&a[i]);
        printf("先进入的值:%d   ",a[i]);
    }
    printf("\n");
    // 求栈容量
    printf("SeqStack_Capacity: %d\n",SeqStack_Capacity(stack));
    printf("SeqStack_Size: %d\n",SeqStack_Size(stack));
    // (int *)SeqStack_Top(stack) 强制类型转换，因为存进去的就是int *指针；外面的*是取内容
    printf("top:%d\n", *( (int *)SeqStack_Top(stack)) );
    
    // 弹栈
    while (SeqStack_Size(stack) > 0 ) {
        int tmp = *( (int *)SeqStack_Pop(stack));
        printf("tmp:%d   ",tmp);
    }
    
    
    
    return 0;
}
