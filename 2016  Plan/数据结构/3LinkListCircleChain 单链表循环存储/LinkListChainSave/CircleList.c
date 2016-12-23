//
//  CircleList.c
//  LinkListChainSave
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

/******************* 线性链表的 循环链式存储 **************************/

#include "CircleList.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct
{
    CircleListNode header;
    CircleListNode *slider; // 游标
    // 注意 如果 int length; 放上面 会出错，即这些属性的 要放在node节点后面
     int length;

}TCircleList;

CircleList *CircleList_Create()
{
    TCircleList *ret = NULL;
    ret = (TCircleList *)malloc(sizeof(TCircleList));
    if(ret == NULL) return NULL;
    
    memset(ret, 0, sizeof(TCircleList));
    ret->header.next = NULL;
    ret->slider = NULL;
    ret->length = 0;
    return ret;
}

/** 销毁 */
void CircleList_Destroy(CircleList * list)
{
    if (list != NULL) {
        free(list);
        list = NULL;
    }
}

/** 清除，长度为0 */
void CircleList_Clear(CircleList *list)
{
    TCircleList *tList = NULL;
    if (list == NULL) {
        return;
    }
    tList = (TCircleList *)list;
    tList->header.next = NULL;
    tList->slider = NULL;
    tList->length = 0;
    
}

int CircleList_Length(CircleList *list)
{
    if (list == NULL) {
        return -1 ;
    }
    TCircleList *tList = (TCircleList *)list;
    return tList->length;
}



/** 插入 */
int CircleList_Insert(CircleList *list,CircleListNode *node, int pos)
{
    int ret = 0;
    if (list == NULL || node == NULL || pos <0) {
        ret = -1;
        printf("LinkList_Insert error:%d",ret);
        return ret;
    }
    {
        TCircleList *tList = NULL;
        tList = (TCircleList *)list;
        CircleListNode *current = NULL;// 引用辅助变量
        current = &(tList->header);
        current = (CircleListNode *)tList;
       
     // 然后遍历，找到插入点，比如要插入到pos位置，currentNode要指向pos的前一个结点
        int i = 0;
        for (i=0; i<pos; i++) {
            current = current->next;
        }

        node->next = current->next;
        current -> next = node;

        //若第一次插入结点
        if (tList->length == 0) {
            tList->slider = node; //  让游标指向0号结点
        }
         tList->length ++;
        
        //若头插法 current 仍然指向头部
        //原因 跳0步 没有跳走
        if(current == (CircleListNode*)tList){
        // 获取最后一个元素
            CircleListNode *last = CircleList_Get(list, tList->length - 1);
            last->next = current->next; // 形成闭环
        }
    }
    return ret;
}

CircleListNode *CircleList_Get(CircleList *list, int pos){
    TCircleList *tList = (TCircleList *)list;
    CircleListNode *ret = NULL;
    int i = 0;
    if (list == NULL || pos < 0) {
        return ret;
    }
    {
        CircleListNode *current = &(tList->header);
        for (i=0; i<pos; i++) {
            current = current->next;
        }
        ret = current->next; // 返回一个指针 也用一个指针来接收
    }
    return ret;
}

CircleListNode *CircleList_Delete(CircleList *list,int pos) //O(n)
{
    TCircleList *sList = (TCircleList *)list;
    CircleListNode *deleteNode = NULL;
    int i = 0;
    if ( (sList != NULL) && (pos >= 0) && (sList->length >0) ) {
        // 指向链表头节点
//        CircleListNode *current = (CircleListNode *)(&(sList->header) );
        CircleListNode *current = (CircleListNode *)sList;
        CircleListNode *last = NULL;
        
        for (i = 0; i<pos; i++) {
            current = current->next;
        }
        
        // 若删除第一个元素 （头节点）,得求出尾部节点
        if (current == (CircleListNode *)sList ) {
            last = (CircleListNode *)CircleList_Get(sList, sList->length -1);
        }
        
        // 求要删除的元素deleteNode
        deleteNode = current->next;
        // 将删除的node 连线到current节点
        current->next = deleteNode->next;
        
        sList->length --;
        
        // 判断链表是否为空, 过滤掉空链表的情况
        if(last != NULL)
        {      // 删除头节点的情况
            sList->header.next = deleteNode->next; 
            last->next = deleteNode->next;
        }
        
        // 若删除的元素 为游标所指的元素
        if(sList->slider == deleteNode)
        {
            sList->slider = deleteNode->next;
        }
        // 若删除元素后，链表长度为0
        if (sList->length == 0) {
            sList->header.next = NULL;
            sList->slider = NULL;
        }
    }
    return deleteNode;
}

// 删除指定的节点
CircleListNode *CircleList_DeleteNode(CircleList *list,CircleListNode *node)
{
    TCircleList *sList = (TCircleList*)list;
    CircleListNode *deleteNode = NULL;
    int i = 0;
    if (sList != NULL ) {
        CircleListNode *current = (CircleListNode *)sList;
        
        // 查找node在循环链表中的位置i
        for (i=0; i<sList->length; i++) {
            if (current->next == node ) {
                deleteNode = current->next;
                break;
            }
            current=current->next;
        }
        //如果deleteNode找到，根据i去删除
        if (deleteNode != NULL) {
            CircleList_Delete(sList, i);
        }
    }
    return deleteNode;
}

//  重置游标，指向第一个元素
CircleListNode *CircleList_Reset(CircleList *list)
{
    TCircleList *sList = (TCircleList*)list;
    CircleListNode *ret = NULL;
    
    if (sList != NULL) {
        sList->slider = sList->header.next;
        ret = sList->slider;
    }
    return ret;
}

// 获取到当前游标所指的节点
CircleListNode *CircleList_Current(CircleList *list){
    TCircleList *sList = (TCircleList *)list;
    CircleListNode *ret = NULL;
    
    if (sList != NULL) {
        ret = sList->slider;
    }
    return ret;
}

// 把当前位置返回，并且游标下移一位
CircleListNode *CircleList_Next(CircleList *list)
{
    TCircleList *sList = (TCircleList *)list;
    CircleListNode *ret = NULL;
    
    if (sList != NULL && sList->slider != NULL) {
        ret = sList->slider;
        sList->slider = ret->next;
    }
    return ret;
}


