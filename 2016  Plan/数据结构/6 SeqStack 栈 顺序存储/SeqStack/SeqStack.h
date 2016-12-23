//
//  SeqStack.h
//  SeqStack
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef SeqStack_h
#define SeqStack_h

#include <stdio.h>

typedef void SeqStack;

SeqStack *SeqStack_Create(int capacity);

void SeqStack_Destroy(SeqStack *stack);

void SeqStack_Clear(SeqStack *stack);

int SeqStack_Push(SeqStack *stack,void *item);

void *SeqStack_Pop(SeqStack *stack);

void *SeqStack_Top(SeqStack *stack);

int SeqStack_Size(SeqStack *stack);

int SeqStack_Capacity(SeqStack *stack);

#endif /* SeqStack_h */
