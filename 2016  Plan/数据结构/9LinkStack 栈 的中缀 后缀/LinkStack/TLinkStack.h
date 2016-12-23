//
//  TLinkStack.h
//  SeqStack
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef TLinkStack_h
#define TLinkStack_h

#include <stdio.h>

typedef void LinkStack;

LinkStack *LinkStack_Create();

void LinkStack_Destroy(LinkStack *stack);

void LinkStack_Clear(LinkStack *stack);

int LinkStack_Push(LinkStack *stack,void *item);

void *LinkStack_Pop(LinkStack *stack);

void *LinkStack_Top(LinkStack *stack);

int LinkStack_Size(LinkStack *stack);

#endif /* TLinkStack_h */
