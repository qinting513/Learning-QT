//
//  main.c
//  DoubleLinkList
//
//  Created by Qinting on 2016/12/16.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>
#include "DoubleLinkList.h"

struct  Value{
    DLinkListNode node;
    int v;
};

int main(int argc, const char * argv[]) {
   
   
    struct Value v1,v2,v3,v4,v5;
    v1.v = 1;
    v2.v = 2;
    v3.v = 3;
    v4.v = 4;
    v5.v = 5;
   
    
    DLinkList *list = DLinkList_Create();
    
    //尾插法
    DLinkList_Insert(list, (DLinkListNode *)&v1,DLinkList_Length(list));
    DLinkList_Insert(list, (DLinkListNode *)&v2,DLinkList_Length(list));
    DLinkList_Insert(list, (DLinkListNode *)&v3,DLinkList_Length(list));
    DLinkList_Insert(list, (DLinkListNode *)&v4,DLinkList_Length(list));
    DLinkList_Insert(list, (DLinkListNode *)&v5,DLinkList_Length(list));
    
    int i = 0;
    struct Value *pv = NULL;
    for (i=0; i<DLinkList_Length(list); i++) {
        pv = (struct Value*)DLinkList_Get(list, i);
        if (pv == NULL) {
            return -1;
        }
        printf("pv->v:%d\t",pv->v);
    }
    printf("\n");
    
    DLinkList_Delete(list, DLinkList_Length(list) -1); // 删除最后一个元素
    DLinkList_Delete(list, 0);
    
    for (i=0; i<DLinkList_Length(list); i++) {
        pv = (struct Value*)DLinkList_Get(list, i);
        if (pv == NULL) {
            return -1;
        }
        printf("删除后pv->v:%d\n",pv->v);
    }
    printf("\n");
    
    DLinkList_Reset(list);
    DLinkList_Next(list);// 后移一位
//    DLinkList_Next(list);
//    DLinkList_Next(list);
    
//    DLinkList_Pre(list);
//      DLinkList_Pre(list);
    pv = (struct Value *)DLinkList_Current(list); // 获取当前游标的值
    printf("current pv->v:%d\n",pv->v);
    
    DLinkList_DeleteNode(list, (DLinkListNode *)pv);
    printf("length:%d\n",DLinkList_Length(list));
    
    return 0;
}
