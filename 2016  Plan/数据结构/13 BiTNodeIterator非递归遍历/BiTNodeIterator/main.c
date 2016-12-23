//
//  main.c
//  BiTNodeIterator
//
//  Created by Qinting on 2016/12/18.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "BiTNode.h"

int main(int argc, const char * argv[]) {
  
    BiTNode t1,t2,t3,t4,t5;
    
    // 初始化为0
    memset(&t1,0,sizeof(BiTNode));
    memset(&t2,0,sizeof(BiTNode));
    memset(&t3,0,sizeof(BiTNode));
    memset(&t4,0,sizeof(BiTNode));
    memset(&t5,0,sizeof(BiTNode));
    
    t1.data = 1;
    t2.data = 2;
    t3.data = 3;
    t4.data = 4;
    t5.data = 5;
    
    // 建立树关系
    t1.lchild = &t2;
    t1.rchild = &t3;
    t2.lchild = &t4;
    t3.lchild = &t5;
    
    printf("递归遍历：\n");
    inOrder(&t1);
    
    printf("\n非递归遍历：\n");
    inOrderWithStack(&t1);
    
    return 0;
}
