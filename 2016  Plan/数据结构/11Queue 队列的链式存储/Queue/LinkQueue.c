//
//  LinkQueue.c
//  Queue
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "LinkQueue.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "LinkList.h"

/** 队列就相当于2端都通的水管，水如果从左边流入，则从右边流出 */

typedef struct _tag_LinkQueueNode
{
    LinkListNode node; // 链表的业务节点 LinkListNode, 通过此节点可以将队列连接起来
    void *item; // 队列的业务节点
}TLinkQueueNode;


// 创建队列 相当于 创建线性表
LinkQueue *LinkQueue_Create()
{
    return LinkList_Create();
}

//销毁队列 相当于 销毁线性表
//节点的内存管理
void LinkQueue_Destroy(LinkQueue *queue)
{
    LinkQueue_Clear(queue); // 先清除 释放空间
    LinkList_Destroy(queue); // 再调用链表的销毁操作
}

// 如果清空队列 要把队列中所有的节点获取出来 释放
void LinkQueue_Clear(LinkQueue *queue)
{
    while (LinkList_Length(queue) > 0) {
        LinkQueue_Retrieve(queue);
    }
    LinkList_Clear(queue);
}

//添加元素 相当于向 线性表的尾部添加元素
int LinkQueue_Append(LinkQueue *queue,void *item)
{
    int ret = 0;
    // 需要把栈道item （栈的业务节点）转化成 链表的业务节点LinkListNode
    TLinkQueueNode *tmp = NULL;
    tmp = (TLinkQueueNode *)malloc(sizeof(TLinkQueueNode));
    if (tmp == NULL) {
        printf("LinkQueue_Append() create fail");
        ret = -1;
        return ret;
    }
    memset(tmp,0,sizeof(TLinkQueueNode)); //    tmp->node.next = NULL
    tmp->item = item;
    
    ret =  LinkList_Insert(queue, (LinkListNode*)tmp, LinkList_Length(queue));
   
    if (ret != 0) {
        printf("LinkQueue_Append() LinkList_Insert fail");
        if (tmp != NULL) {
            free(tmp);
        }
        return  ret;
    }
    return  ret;
}

// 从队列中删除元素 相当于 从线性表 头部删除元素 （尾插法 对应头部删除）
void* LinkQueue_Retrieve(LinkQueue *queue)
{
  
    TLinkQueueNode *tmp = NULL;
    void *ret = NULL;
    tmp = (TLinkQueueNode *)LinkList_Delete(queue, 0);
    
    if (tmp == NULL) {
        printf("LinkQueue_Retrieve() delete error");
        return NULL;
    }
    
    ret = tmp->item;
    // 删除之前的缓存
    if (tmp != NULL) {
        free(tmp);
    }
    return ret;
    
}

// 获取 相当于 从链表的0号位置获取
void* LinkQueue_Header(LinkQueue *queue)
{
    TLinkQueueNode *tmp = NULL;
    tmp = (TLinkQueueNode *)LinkList_Get(queue, 0);
    if (tmp == NULL) {
        printf("LinkQueue_Header() get error");
        return NULL;
    }
    return tmp->item;
}


int LinkQueue_Length(LinkQueue *queue)
{
    return LinkList_Length(queue);
}


