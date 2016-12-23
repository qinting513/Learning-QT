//
//  DoubleLinkList.c
//  DoubleLinkList
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "DoubleLinkList.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//内部结构
typedef struct  _tag_DLinkList{
    DLinkListNode header;
    DLinkListNode *slider; // 游标
    int length;
}TDLinkList;

DLinkList *DLinkList_Create()
{
    TDLinkList *ret = (TDLinkList *)malloc(sizeof(TDLinkList));
    if (ret != NULL) {
        ret->length = 0;
        ret->header.next = NULL;
        ret->header.pre  = NULL;
        ret->slider      = NULL;
    }
    return ret;
}

void DLinkList_Destroy(DLinkList *list)
{
    if (list != NULL) {
        free(list);
    }
}

void DLinkList_Clear(DLinkList *list)
{
    TDLinkList *tList = (TDLinkList *) list;
    if (tList != NULL) {
        tList->length = 0;
        tList->header.next = NULL;
        tList->header.pre  = NULL;
        tList->slider      = NULL;
    }
}

int DLinkList_Length(DLinkList *list)
{
    TDLinkList *tList = (TDLinkList *)list;
    int ret = -1;
    if (list != NULL) {
        ret = tList -> length;
    }
    return  ret;
}

int DLinkList_Insert(DLinkList *list,DLinkListNode *node,int pos)
{
    int ret = 0, i = 0;
    TDLinkList *tList = (TDLinkList *)list;
    if (list == NULL || pos<0 || node == NULL) {
        return -1;
    }
    
    // 引入辅助变量current， 并初始化为tList->header
    DLinkListNode *current = (DLinkListNode *)tList;
    DLinkListNode *next = NULL; // 需要增加辅助变量 next指针
    
    for (i = 0; (i<pos)&&(current->next != NULL); i++) {
        current = current->next;  // 找到要插入的节点
    }
    next = current->next; // 0
    
    current->next = node;// 1
    node->next = next;   // 2
    
    if (next != NULL) { // 当链表插入第一个元素，需要特殊处理
        next->pre = node; // 3 next 不为空的时候 才能设置pre
    }
    
    node->pre = current; // 4
    
    if(tList->length == 0)
    {
        tList->slider = node; // 当链表插入第一个元素后处理游标指向它
    }
    
    // 若在0位置插入，需要特殊处理，新来的节点next 的 pre指向null
    if (current == (DLinkListNode *)tList) {
        node->pre = NULL;
    }
    
    tList->length ++; // 链表长度加1
    return ret;
}

DLinkListNode *DLinkList_Get(DLinkList *list,int pos)
{
    TDLinkList *tList = (TDLinkList *)list;
    DLinkListNode *ret = NULL;
    int i=0;
    if ( (tList != NULL) && (pos>=0) && (pos<tList->length) ) {
        DLinkListNode *current = (DLinkListNode *)tList;
        for (i=0; i<pos; i++) {
            current = current->next;
        }
        ret = current->next;
    }
    return ret;
}
// 插入第一个点
// 删除的是最后一个节点 该如何处理
DLinkListNode *DLinkList_Delete(DLinkList *list,int pos)
{
    TDLinkList *tList = (TDLinkList *)list;
    DLinkListNode *ret = NULL;
    int i = 0;
    if (tList == NULL || pos<0 || pos > tList->length) {
        return NULL;
    }
//    if ( (tList != NULL) && (pos>= 0) && (pos>tList->length))
    {
        // 引入辅助变量
        DLinkListNode *current = (DLinkListNode *)tList;
        // 需要增加next 指针
        DLinkListNode *next = NULL;
        for (i=0; i<pos; i++) {
            current = current->next;
        }
        //找到要删除的节点
        ret = current->next;
        
        // 进行其他连线操作
        next = ret->next; // 0
        current->next = next; // 1
        
        if (next != NULL) { // 需要特殊处理
            
            // 若第0个位置，需要特殊处理
            if (current == (DLinkListNode*) tList ) {
                next->pre = NULL;
            }
        }
        
        if (tList->slider == ret) {
            tList->slider = next;
        }
        
        tList->length --; 
    }
    
    return ret;
}

#pragma  mark - add method
// 根据节点 删除该节点
DLinkListNode *DLinkList_DeleteNode(DLinkList *list,DLinkListNode *node)
{
    TDLinkList *tList = (TDLinkList *)list;
    DLinkListNode *ret = NULL;
    int i = 0;
    if (tList != NULL) {
        DLinkListNode *current = (DLinkListNode *)tList; // 指向链表的header
        
         // 查找node在循环链表中的位置i
        for (i=0 ; i<tList->length; i++) {
            if (current->next == node) {
                ret = current->next;
                break;
            }
            current = current->next;
        }
        
        // 如果找到 则调用来删除掉
        if (ret != NULL) {
            DLinkList_Delete(tList, i);
        }
    }
    return ret;
}

//  重置游标，指向第一个元素
DLinkListNode *DLinkList_Reset(DLinkList *list)
{
    TDLinkList *tList = (TDLinkList *)list;
    DLinkListNode *ret = NULL;
    if (tList != NULL) {
        tList->slider = tList->header.next; //  游标指向header
        ret = tList->slider;
    }
    return ret;
}
// 获取到当前游标所指的节点
DLinkListNode *DLinkList_Current(DLinkList *list)
{
    TDLinkList *tList = (TDLinkList *)list;
    DLinkListNode *ret = NULL;
    if (tList != NULL) {
        ret = tList->slider;
    }
    return ret;
}

// 把当前位置返回，并且游标后移一位
DLinkListNode *DLinkList_Next(DLinkList *list)
{
    TDLinkList *tList = (TDLinkList *)list;
    DLinkListNode *ret = NULL;
    
    if (tList != NULL && tList->slider != NULL) {
        ret = tList->slider;
        DLinkListNode *current = DLinkList_Get(list, DLinkList_Length(list)-1); // 获取到最后一位的
        // 得判断如果是最后一个
        if (tList->slider == current) {
            // 若是最后一个了 ，则指向第一个元素
            tList->slider = tList->header.next;
        }else{
            tList->slider = ret->next;
        }
       
    }
    return ret;
}

// 把当前位置返回，并且游标前移一位
DLinkListNode *DLinkList_Pre(DLinkList *list)
{
    TDLinkList *tList = (TDLinkList *)list;
    DLinkListNode  *ret = NULL;
    if (tList != NULL && tList->slider != NULL) {
        
        ret = tList->slider;
        // 得判断如果是第1个 移动到最后一位
        if(tList->header.next == ret)
        {
            DLinkListNode *current = DLinkList_Get(list, DLinkList_Length(list)-1); // 获取到最后一位的
            tList->slider = current;
        }else{
            tList->slider = ret->pre;
        }
    }
    return ret;
}
