//
//  SeqList.c
//  LineList
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "SeqList.h"

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct  _tag_SeqList
{
    int length; // 链表的实际长度
    int capacity; //链表的容量  比如容量是10，但是插入实际长度为7，还有后面的3位是0
#warning 写一级指针会出现 bad_access
    unsigned int *node;// 在结构体套一级指针，指向数组地址的内存空间,
}TSeqList;

/** 创建一个结点 */
SeqList * SeqList_Create(int capacity){
    
    int ret = 0;
    TSeqList *tmp = NULL;
    tmp = (TSeqList *) malloc(sizeof(TSeqList)); // 分配指定长度的内存空间
    
    if(tmp == NULL){
        ret = -1;
        printf("func SeqList_Create() error");
        return NULL;
    }
    
    /** void *memset(void *s, int ch, size_t n);
     函数解释：将s中当前位置后面的n个字节 （typedef unsigned int size_t ）用 ch 替换并返回 s 。
     memset：作用是在一段内存块中填充某个给定的值，它是对较大的结构体或数组进行清零操作的一种最快方法[1]  。
     清0 操作： */
    memset(tmp, 0, sizeof(TSeqList));
    
    //    sizeof(unsigned int *) 的长度 再乘上 capacity；相当于给数组分配内存空间
    tmp->node = (unsigned int *) malloc(sizeof(unsigned int *) * capacity);
    if (tmp->node == NULL) {
        ret = -2;
        printf("func SeqList_Create() malloc error");
        return NULL;
    }
    tmp->capacity = capacity;
    tmp->length = 0;
    return tmp;
}

/** 销毁 */
void SeqList_Destroy(SeqList * list){
    if (list == NULL) {
        return ;
    }
    TSeqList *tList = (TSeqList*)list;
    if (tList->node == NULL) {
        free(tList->node);
    }
    free(tList->node);
    return ;
}

/** 清空链表 */
void SeqList_Clear(SeqList *list)
{
    if(list == NULL){
        return;
    }
    TSeqList *tList = (TSeqList *)list;
    tList -> length = 0; // 让其回到原始的初始化状态
}


int SeqList_Length(SeqList *list)
{
    if(list == NULL){
        return 0;
    }
    TSeqList  *tList = (TSeqList *)list;
    return tList->length;
}

int SeqList_Capacity(SeqList *list)
{
    
    if(list == NULL){
        return 0;
    }
    TSeqList  *tList = (TSeqList *)list;
    return tList->capacity;
}

/** 在指定位置插入结点 */
int SeqList_Insert(SeqList *list, SeqListNode *node,int position)
{
   
    TSeqList *tList = (TSeqList *)list;
    int ret = 0;
    if (list == NULL || tList->node == NULL || position < 0) {
        ret = -1;
        printf("func SeqList_Insert() error:%d",ret);
        return ret;
    }
    
    // 判断是不是满了 长度大于容量了
    if(tList->length >= tList->capacity){
        ret = -2;
        printf("func SeqList_Insert() error:%d",ret);
        return ret;
    }
    // 容错修正 假如实际长度是6， 容量是20，用户在pos10的位置插入，也不报错,插入到最后
    if (position > tList->length) { // 能够来到这行，说明已经满了
        position = tList -> length; //插入到最后面
    }
    
    int i = 0;
    for (i = tList->length; i>position; i--) {
        tList->node[i] = tList->node[i-1];
    }
    tList->node[i] = (unsigned int )node; //  2种写法，跟下面一行一样 都是指针赋给指针
    tList->length ++;
    return 0;
}

/** 获取某一个结点 */
void * SeqList_Get(SeqList *list,int position)
{
    SeqListNode * ret = NULL;
    TSeqList *tList = (TSeqList *)list;
    if (list == NULL || position < 0) {
        printf("func SeqList_Get() error");
        return NULL;
    }
    
    ret =  (void*)tList->node[position];
    return ret;
}


SeqListNode* SeqList_Delete(SeqList *list,int position)
{
    SeqListNode * ret = 0;
    TSeqList *tList = (TSeqList *)list;
    if (list == NULL || position < 0) {
        printf("func SeqList_Get() error");
        return NULL;
    }
    
    // 缓存pos位置的元素
    ret = (void *) tList->node[position];
    
    // 从pos+1位置往前移
    for (int i = position+1; i<tList->length; i++) {
        tList->node[i-1] = tList->node[i];
    }
    
    //移完后 长度减1
    tList->length --;
    return ret;
}
