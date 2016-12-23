//
//  SeqStack.c
//  SeqStack
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "SeqStack.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "SeqList.h"

/****************** 线性表的顺序存储 **********************/

//创建栈  相当于创建线性表
SeqStack *SeqStack_Create(int capacity)
{
    return SeqList_Create(capacity);
}

//  销毁栈 相当于销毁线性表
void SeqStack_Destroy(SeqStack *stack)
{
    SeqList_Destroy(stack);
}

// 清空栈 相当于 清空线性表
void SeqStack_Clear(SeqStack *stack)
{
    SeqList_Clear(stack);
}

// 插入元素 相当于 向线性表的尾部 插入元素
int SeqStack_Push(SeqStack *stack,void *item)
{
    return SeqList_Insert(stack, item, SeqList_Length(stack));
}

SeqStack *SeqStack_Pop(SeqStack *stack)
{
    return SeqList_Delete(stack, SeqList_Length(stack) -1 );
}

SeqStack *SeqStack_Top(SeqStack *stack)
{
    return SeqList_Get(stack, SeqList_Length(stack)-1);
}

int SeqStack_Size(SeqStack *stack)
{
    return SeqList_Length(stack);
}

int SeqStack_Capacity(SeqStack *stack)
{
    return SeqList_Capacity(stack);
}
