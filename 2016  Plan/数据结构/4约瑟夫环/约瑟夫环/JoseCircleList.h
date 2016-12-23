//
//  JoseCircleList.h
//  约瑟夫环
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef JoseCircleList_h
#define JoseCircleList_h

#include <stdio.h>
/* 构建结构体 */

typedef struct Node
{
    int num;
    struct Node *next; // 结构体指针，指向Node结构体
    
}JoseNode,*PNode,*HeadNode; //PNode为指针变量，HeadNode为头结点


int JoseInit(HeadNode *h);

int JoseInsert(JoseNode *h, int pos, int x);

void TraverseList(HeadNode h,int M);

int JoseDelete(HeadNode h, int M, int k);

#endif /* JoseCircleList_h */
