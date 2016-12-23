//
//  LinkList.h
//  LinkListChainSave
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef LinkList_h
#define LinkList_h

#include <stdio.h>

/******************* 线性链表的 链式存储 **************************/

typedef void  LinkList;

/*
typedef struct _tag_LinkListNode LinkListNode;
struct _tag_LinkListNode {
    LinkListNode *next;
};
*/

typedef struct _tag_LinkListNode {
    struct _tag_LinkListNode *next;  // 存储下一个结点位置
}LinkListNode;

LinkList *LinkList_Create();

/** 销毁 */
void LinkList_Destroy(LinkList * list);

/** 清除，长度为0 */
void LinkList_Clear(LinkList *list);

int LinkList_Length(LinkList *list);

/** 插入 */
int LinkList_Insert(LinkList *list,LinkListNode *node, int pos);

LinkListNode *LinkList_Get(LinkList *list, int pos);

LinkListNode *LinkList_Delete(LinkList *list,int pos);


#endif /* LinkList_h */
