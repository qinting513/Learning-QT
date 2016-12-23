//
//  LinkList.c
//  LinkListChainSave
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "LinkList.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/******************* 线性链表的 链式存储 **************************/

typedef struct  _tag_LinkList
{
    int length; // 链表的长度
    LinkListNode header; // 头结点 指向下一个业务结点
    
}TLinkList;


LinkList *LinkList_Create()
{
    TLinkList *ret = NULL;
    ret = (TLinkList *)malloc(sizeof(TLinkList)); // 分配内存空间
    memset(ret, 0, sizeof(TLinkList)); // member set 其实就是初始化为0
    ret->length = 0;
    ret->header.next = NULL;
    return ret;
}

/** 销毁 */
void LinkList_Destroy(LinkList * list)
{
    if (list != NULL) {
        free(list);
        list = NULL;
    }
}

/** 清除，让链表回到初始值 */
void LinkList_Clear(LinkList *list)
{
    TLinkList *tList = NULL;
    if ( list == NULL ) {
        return ;
    }
    tList = (TLinkList *)list;
    tList -> header.next = NULL;
    tList -> length = 0;
}

int LinkList_Length(LinkList *list)
{
    TLinkList *tList = NULL;
    if ( list == NULL ) {
        return 0;
    }
    tList = (TLinkList *)list;
    return tList -> length;
}

/** 插入 
 把小的业务结点连接起来即可，大的业务结点自然就连接起来，next，就是大的业务结点的   LinkListNode node; */
int LinkList_Insert(LinkList *list,LinkListNode *node, int pos)
{
    int ret = 0;
    if(list == NULL || node == NULL || pos < 0){
        ret = -1;
        printf("LinkList_Insert error:%d",ret);
        return ret;
    }
    TLinkList * tList = NULL ;
    tList = (TLinkList *)list;
    LinkListNode *current = NULL;
    current = &(tList->header); //让辅助指针变量指向链表的头部
    
    // 然后遍历，找到插入点，比如要插入到pos位置，currentNode要指向pos的前一个结点
    int i = 0;
    for (i=0; i<pos && (!current->next); i++) {
        current = current->next;
    }
    
    // 找到插入位置后，进行链表操作
    /** pos结点位置保存在pos-1结点的next指针中的， 
       让插入的node的next指向pos结点位置，实现node连接下一个结点的操作
     */
    node->next = current -> next;
    /** pos-1结点的next 指向node，让前边的结点连接node结点，使链表串起来 */
    current->next = node;
    tList->length ++;
    return ret; //如果返回0 说明插入成功
}

LinkListNode *LinkList_Get(LinkList *list, int pos)
{
    int ret = 0;
    if(list == NULL || pos < 0){
        ret = -1;
        printf("LintList_Get error:%d",ret);
        return NULL;
    }
    TLinkList * tList = (TLinkList *)list;
    LinkListNode *current = NULL;
    current = &(tList->header); //让辅助指针变量指向链表的头部
    int i = 0;
    for (i=0; i<pos; i++) {
        current = current->next;
    }
    return current->next;
}

/** 获取到 然后删除 */
LinkListNode *LinkList_Delete(LinkList *list,int pos)
{
    int ret = 0;
    if(list == NULL || pos < 0){
        ret = -1;
        printf("LintList_Get error:%d",ret);
        return NULL;
    }
    TLinkList * tList = (TLinkList *)list;
    LinkListNode *current = NULL;
    current = &(tList->header); //让辅助指针变量指向链表的头部
    int i = 0;
    for (i=0; i<pos && (!current->next) ; i++) {
        current = current->next;
    }
    // 缓存被删除的结点deleteNode
    LinkListNode *deleteNode = current->next;
    //连线
    current->next = deleteNode->next;
    tList -> length --;
    return deleteNode;
}



