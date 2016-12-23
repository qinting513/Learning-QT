//
//  JoseCircleList.c
//  约瑟夫环
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "JoseCircleList.h"

#include <stdio.h>
#include <stdlib.h>



int JoseInit(HeadNode *h)
{
    if (!h) {
        printf("初始化链表错误\n");
        return 0;
    }
    (*h)->next = (*h); // 循环单链表
    return 1;
}

/** 插入 */

int JoseInsert(JoseNode *h, int pos, int x)
{
    PNode p = h,q; //声明2个变量，并初始化p
    int i = 1;
    if (pos == 1) { /** 尾插法 */
        p->num = x;
        p->next = p;
    }
    while (i < pos - 1) {
        p=p->next;
        i++;
    }
    q = (PNode)malloc(sizeof(JoseNode));
    q->num = x;
    q->next = p->next;
    p->next = q;
    return 1;
}

void TraverseList(HeadNode h,int M)
{
    int i = 0;
    PNode p = h;
    printf("参与的人的编号为：\n");
    while (i<M) {
        printf("%d\t",p->num);
        p = p->next;
        i++;
    }
    printf("\n");
}

/**************出局函数****************/

int JoseDelete(HeadNode h, int M, int k)
{    int i;
    PNode p=h,q;
    while(M>1)
    {
        for(i=1;i<k-1;i++)
        {
            p=p->next;
        }
        
        q=p->next;
        p->next=q->next;
        printf("出局的人为：%d号\n",q->num);
        free(q);
        
        p=p->next;
        M--;
    }
    printf("***************获胜者为：%d号***************",p->num);
    return 1;
}
