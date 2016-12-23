//
//  main.c
//  LineList
//
//  Created by Qinting on 2016/12/14.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>
#include "SeqList.h"

typedef struct _teacher {
    int age;
    char name[64];
    char *fullName;
}Teacher;

int main(int argc, const char * argv[]) {
    int ret = 0;
    SeqList *list = NULL;
    Teacher t1,t2,t3,t4,t5;
    t1.age = 31;
   strcpy( t1.name, "aa");
    t1.fullName = "t1Name";
    t2.age = 32;
    t3.age = 33;
    t4.age = 34;
    t5.age = 35;
    
    list = SeqList_Create(10);
    if (list == NULL) {
        printf("func SeqList_Create() fail");
        return -1;
    }
    
    ret = SeqList_Insert(list, (SeqListNode*) &t1, 0); //头插法
    ret = SeqList_Insert(list, (SeqListNode*) &t2, 0);
    ret = SeqList_Insert(list, (SeqListNode*) &t3, 0);
    ret = SeqList_Insert(list, (SeqListNode*) &t4, 0);
    ret = SeqList_Insert(list, (SeqListNode*) &t5, 0);
   
    int count = SeqList_Length(list);
    for (int  i = 0; i<count; i++) {
        Teacher *tmp = (Teacher*) SeqList_Get(list, i);
        if (tmp == NULL) {
            printf("查询失败");
            return -1;
        }
        printf("tmp:%d ",tmp->age);
        
    }
    
    while (SeqList_Length(list) > 0) {
        SeqList_Delete(list, 0);
    }
    SeqList_Destroy(list);
    printf("end\n");
    return 0;
}
