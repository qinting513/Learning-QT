//
//  CircleList.h
//  LinkListChainSave
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef CircleList_h
#define CircleList_h

#include <stdio.h>
/******************* 线性链表的 循环链式存储 **************************/

typedef void  CircleList;

/*
 typedef struct _tag_CircleListNode CircleListNode;
 struct _tag_CircleListNode {
 CircleListNode *next;
 };
 */

typedef struct _tag_CirCleListNode{
    struct _tag_CirCleListNode *next;
}CircleListNode;

CircleList *CircleList_Create();

/** 销毁 */
void CircleList_Destroy(CircleList * list);

/** 清除，长度为0 */
void CircleList_Clear(CircleList *list);

int CircleList_Length(CircleList *list);


/** 插入 */
int CircleList_Insert(CircleList *list,CircleListNode *node, int pos);

CircleListNode *CircleList_Get(CircleList *list, int pos);

CircleListNode *CircleList_Delete(CircleList *list,int pos);

#pragma  mark - 增加的方法
// 根据节点 删除该节点
CircleListNode *CircleList_DeleteNode(CircleList *list,CircleListNode *node);

//  重置游标，指向第一个元素
CircleListNode *CircleList_Reset(CircleList *list);
// 获取到当前游标所指的节点
CircleListNode *CircleList_Current(CircleList *list);

// 把当前位置返回，并且游标下移一位
CircleListNode *CircleList_Next(CircleList *list);


#endif /* CircleList_h */

