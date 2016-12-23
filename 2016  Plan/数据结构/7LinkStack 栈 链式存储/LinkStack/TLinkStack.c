//
//  TLinkStack.c
//  SeqStack
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "TLinkStack.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "LinkList.h"

/****************** 线性表的顺序存储 **********************/

typedef struct _tag_LinkStackNode { // 链表的业务节点,LinkListNode
    // 通过 链表的业务节点，把链表连接起来
    LinkListNode node; // 第一个域（第一个元素）
    void *item;// 栈的业务节点
}TLinkStackNode;


//创建栈  相当于创建线性表
LinkStack *LinkStack_Create()
{
    return LinkList_Create();
}

//  销毁栈 相当于销毁线性表
void LinkStack_Destroy(LinkStack *stack)
{
    LinkStack_Clear(stack);
    LinkList_Destroy(stack);
}

// 清空栈 相当于 清空线性表
//清空栈  涉及元素的生命周期问题
// 所有入栈节点都是malloc，清空时要释放所有节点内存
void LinkStack_Clear(LinkStack *stack)
{
    if (stack == NULL) {
        return;
    }
    while (LinkList_Length(stack) > 0) {
        LinkStack_Pop(stack);
    }
}

// 插入元素 相当于 向线性表的尾部 插入元素
//void *item 栈的业务节点 --> 链表的业务节点
int LinkStack_Push(LinkStack *stack,void *item)
{
    int ret = 0;
    TLinkStackNode *tmp = NULL;
    tmp = (TLinkStackNode*)malloc(sizeof(TLinkStackNode)); // 分配内存空间，以致于不会被清理掉
    if(tmp == NULL) return -1;
    memset(tmp , 0, sizeof(TLinkStackNode)); // 初始化
    tmp->item = item; // 把栈的业务节点包含进链表的业务节点
    
    ret = LinkList_Insert(stack, (LinkListNode*)tmp, 0); // 头插法，通过链表业务节点 把栈的元素连接起来
    if (ret != 0) {
        printf("func LinkStack_Push() error : %d",ret);
        if (tmp != NULL) {
            free(tmp);// 如果失败，则需清理掉内存
        }
        return ret;
    }
    return ret;
}

// 从栈中弹出元素 相当于 删除线性表第一个元素
void *LinkStack_Pop(LinkStack *stack)
{
    void *item = NULL;
    TLinkStackNode *tmp = NULL;
    tmp = (TLinkStackNode*)LinkList_Delete(stack, 0);
    if (tmp == NULL) {
        return NULL;
    }
    // 不为空 则把链表的业务节点 变成 栈的业务节点
    item = tmp->item;
    // 因为push的时候 分配内存 所以pop时要释放内存
    free(tmp);
    return item;
}

// 获取栈的栈顶 相当于 获取链表的第一个元素
void *LinkStack_Top(LinkStack *stack)
{
    void *item = NULL;
    TLinkStackNode *tmp = NULL;
    tmp = (TLinkStackNode*) LinkList_Get(stack, 0);
    if (tmp == NULL ) {
        return NULL;
    }
    item = tmp->item;
    return item;
}

// 求栈的大小 相当于 求链表的len
int LinkStack_Size(LinkStack *stack)
{
    return LinkList_Length(stack);
}

