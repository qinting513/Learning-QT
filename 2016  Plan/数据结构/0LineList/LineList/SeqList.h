//
//  SeqList.h
//  LineList
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef SeqList_h
#define SeqList_h

#include <stdio.h>

typedef void  SeqList;
typedef void  SeqListNode;

SeqList * SeqList_Create(int capacity);

void SeqList_Destroy(SeqList * list);

void SeqList_Clear(SeqList *list);

int SeqList_Length(SeqList *list);

int SeqList_Capacity(SeqList *list);

int SeqList_Insert(SeqList *list, SeqListNode *node,int position);

SeqListNode * SeqList_Get(SeqList *list,int position);

SeqListNode* SeqList_Delete(SeqList *list,int position);

#endif /* SeqList_h */
