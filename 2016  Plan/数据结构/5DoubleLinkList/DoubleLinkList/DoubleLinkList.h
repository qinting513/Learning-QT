//
//  DoubleLinkList.h
//  DoubleLinkList
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef DoubleLinkList_h
#define DoubleLinkList_h

#include <stdio.h>

/******************* 线性表的 双向链式存储 **************************/
typedef  void  DLinkList;

typedef struct  _tag_DLinkListNode{
    struct _tag_DLinkListNode *next;
    struct _tag_DLinkListNode *pre;
}DLinkListNode;

DLinkList *DLinkList_Create();

void DLinkList_Destroy(DLinkList *list);

void DLinkList_Clear(DLinkList *list);

int DLinkList_Length(DLinkList *list);

int DLinkList_Insert(DLinkList *list,DLinkListNode *node,int pos);

DLinkListNode *DLinkList_Get(DLinkList *list,int pos);

DLinkListNode *DLinkList_Delete(DLinkList *list,int pos);

#pragma  mark - add method
// 根据节点 删除该节点
DLinkListNode *DLinkList_DeleteNode(DLinkList *list,DLinkListNode *node);

//  重置游标，指向第一个元素
DLinkListNode *DLinkList_Reset(DLinkList *list);
// 获取到当前游标所指的节点
DLinkListNode *DLinkList_Current(DLinkList *list);
// 把当前位置返回，并且游标后移一位
DLinkListNode *DLinkList_Next(DLinkList *list);

// 把当前位置返回，并且游标前移一位
DLinkListNode *DLinkList_Pre(DLinkList *list);

#endif /* DoubleLinkList_h */
