//
//  main.c
//  LinkListChainSave
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>

/******************* 线性链表的 循环链式存储 **************************/
#include "CircleList.h"
#include "LinkList.h"

typedef struct {
//     LinkListNode linkNode;
    CircleListNode node;   // 为什么这些结点要放在包装的结构体的前面，放在后面会出错！
    int v;
}Value ;


int main(int argc, const char * argv[]) {
    
    Value v1,v2,v3,v4,v5,v6,v7,v8;
    v1.v = 1;
    v2.v = 2;
    v3.v = 3;
    v4.v = 4;
    v5.v = 5;
    v6.v = 6;
    v7.v = 7;
    v8.v = 8;
    
   
    CircleList *list = NULL;
   list = CircleList_Create();
    if (list == NULL) {
        return -1;
    }
   int ret = 0;
    ret = CircleList_Insert(list, (CircleListNode *)&v4, 0);
    ret = CircleList_Insert(list, (CircleListNode *)&v3, 0);
    ret = CircleList_Insert(list, (CircleListNode *)&v2, 0);
    ret = CircleList_Insert(list, (CircleListNode *)&v1, 0);
    
   
   
    int length = CircleList_Length(list);
    printf("length: %d\n",length);
    // 怎么证明是循环链表，打印2次看看是不是重叠的
    for (int i=0; i< 2 * length; i++) {
        Value *pv = (Value*)CircleList_Get(list, i);
        if(pv == NULL){    //不写这个判断 经常出现野指针错误
            return -1;
        }
        printf("%d\t",pv->v);
    }
     printf("--------------------  \n");
    // 删除所有节点
//    while (CircleList_Length(list) > 0) {
//        CircleList_Delete(list, 0);
//    }

    // 删除指定元素
//    CircleList_Delete(list, 1);
//    CircleList_DeleteNode(list, (CircleListNode *)&v2 );
    
    CircleList_Reset(list); // 重置游标
    
    while (CircleList_Current(list) != NULL) {
        CircleListNode *deleteNode = CircleList_Next(list);
        Value *node = (Value *)deleteNode;
        printf("delete node: %d\n",node->v);
        
        CircleList_DeleteNode(list, deleteNode);
        
    }
   
    // 再遍历查看
    for (int i=0; i< CircleList_Length(list); i++) {
        Value *pv = (Value*)CircleList_Get(list, i);
        if(pv == NULL){
            return -1;
        }
        printf("=== %d\n",pv->v);
    }
    
    printf("end \n");
    
     /*
    LinkList *list = NULL;
    list = LinkList_Create();
    if (list == NULL) {
        return -1;
    }
    
    int length = LinkList_Length(list);
    printf("链表长度：%d\n",length);
    int ret = 0;
    // &t1为结构体的地址，然后强制转化为 (LinkListNode *) 指针，可以直接想指针就是地址，可以相互转化
    ret = LinkList_Insert(list, (LinkListNode *)&v1, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&v2, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&v3, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&v4, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&v5, 0);
    
    length = LinkList_Length(list);
    printf("链表长度：%d\n",length);
    
    // 遍历 查询
    for(int i = 0; i<length; i++){
        //Teacher *tmp  结构体指针
        Value *tmp = (Value *)LinkList_Get(list, i);
        if(tmp == NULL){
            return -1;
        }
        printf("tmp->v: %d\t",tmp->v);
        
    }
    
    printf("\n");
      */
      
    return 0;
}
