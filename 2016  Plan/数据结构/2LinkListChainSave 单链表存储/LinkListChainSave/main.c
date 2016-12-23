//
//  main.c
//  LinkListChainSave
//
//  Created by Qinting on 2016/12/15.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>
#include "LinkList.h"
/******************* 线性链表的 链式存储 **************************/

typedef struct {
    LinkListNode node;
    int age;
    char name[64];
    char *pName;
}Teacher;


int main(int argc, const char * argv[]) {

    Teacher t1,t2,t3,t4,t5;
    t1.age = 11;
    t2.age = 12;
    t3.age = 13;
    t4.age = 14;
    t5.age = 15;
    
    LinkList *list = NULL;
    list = LinkList_Create();
    if (list == NULL) {
        return -1;
    }
    
    int length = LinkList_Length(list);
    printf("链表长度：%d\n",length);
    int ret = 0;
    // &t1为结构体的地址，然后强制转化为 (LinkListNode *) 指针，可以直接想指针就是地址，可以相互转化
    ret = LinkList_Insert(list, (LinkListNode *)&t1, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&t2, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&t3, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&t4, 0);
    ret = LinkList_Insert(list, (LinkListNode *)&t5, 0);
    
    length = LinkList_Length(list);
    printf("链表长度：%d\n",length);
    
    // 遍历 查询
    for(int i = 0; i<length; i++){
        //Teacher *tmp  结构体指针
        Teacher *tmp = (Teacher *)LinkList_Get(list, i);
        if(tmp == NULL){
            return -1;
        }
        printf("tmp->age: %d\t",tmp->age);
        
    }
    
    printf("\n");
    
    // 删除
    while (LinkList_Length(list) > 0) {
       Teacher *tmp = (Teacher *) LinkList_Delete(list, 0);
        if(tmp == NULL){
            return -1;
        }
        printf("删除的元素为 tmp->age: %d\n",tmp->age);
    }
        
    return 0;
}
