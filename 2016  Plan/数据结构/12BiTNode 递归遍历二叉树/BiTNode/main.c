//
//  main.c
//  BiTNode
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "BiTNode.h"

/*
int mainA(int argc, const char * argv[]) {
    // 声明 结构体变量
    BiTNode t1,t2,t3,t4,t5;
    memset(&t1, 0, sizeof(BiTNode));
    memset(&t2, 0, sizeof(BiTNode));
    memset(&t3, 0, sizeof(BiTNode));
    memset(&t4, 0, sizeof(BiTNode));
    memset(&t5, 0, sizeof(BiTNode));
    
    t1.data = 1;
    t2.data = 2;
    t3.data = 3;
    t4.data = 4;
    t5.data = 5;
    
    // 建立二叉树的关系
    t1.lchild = &t2;
    t1.rchild = &t3;
    t2.lchild = &t4;
    t3.lchild = &t5;
    
    // 先序遍历
    preOrder(&t1);  // 1  2  4  3  5
    printf("\n");
    //  中序遍历
    inOrder(&t1);  // 4  2  1  5  3
    printf("\n");
    // 后序遍历
    postOrder(&t1); // 4  2  5  3  1
    printf("\n");
    return 0;
}

 */

int main(int argc, const char * argv[]) {
    // 声明指针变量
    BiTNode *p1,*p2,*p3,*p4,*p5,*p6;
    // 分配内存空间
    p1 = (BiTNode*)malloc(sizeof(BiTNode));
    p2 = (BiTNode*)malloc(sizeof(BiTNode));
    p3 = (BiTNode*)malloc(sizeof(BiTNode));
    p4 = (BiTNode*)malloc(sizeof(BiTNode));
    p5 = (BiTNode*)malloc(sizeof(BiTNode));
//    p6 = (BiTNode*)malloc(sizeof(BiTNode));
    
    // 要初始化 要不然会bad_access
    memset(p1, 0, sizeof(BiTNode));
    memset(p2, 0, sizeof(BiTNode));
    memset(p3, 0, sizeof(BiTNode));
    memset(p4, 0, sizeof(BiTNode));
    memset(p5, 0, sizeof(BiTNode));
//    memset(p6, 0, sizeof(BiTNode));
    
    p1->data = 1;
    p2->data = 2;
    p3->data = 3;
    p4->data = 4;
    p5->data = 5;
//    p6->data = 6;
    
    // 建立二叉树的关系
    p1->lchild = p2;
    p1->rchild = p3;
    p2->lchild = p4;
    p3->lchild = p5;
    p3->rchild = p6;
    
//    // 先序遍历
//    preOrder(p1);  // 1  2  4  3  5
//    printf("\n");
//    //  中序遍历
//    inOrder(p1);  // 4  2  1  5  3
//    printf("\n");
//    // 后序遍历
//    postOrder(p1); // 4  2  5  3  1
//    printf("\n");
    
    int sum = 0;
    countLeaf(p1, &sum);
    printf("Leaf count:%d\n",sum);
    
    printf("Depth:%d\n",Depth(p1));
    
    {
        // 验证拷贝是否成功
        printf("\n copy tree:\n");
        BiTNode *newRoot = copyTree(p1);
        inOrder(newRoot);  // 4  2  1  5  3
    }
    printf("\n old tree:\n");
    inOrder(p1);  // 4  2  1  5  3
    
    return 0;

}

/***************************************************************************** */


// 第二种表示法 三叉树表示法
typedef struct TriNode
{
    int data;
    // 左右子孩子
    struct TriNode *lchild, *rchild;
    // 父亲
    struct TriNode *parent;
    
}TriNode,*TriTree;

int main2(int argc, const char * argv[]) {


    return 0;
    
}

/***************************************************************************** */

/** 双亲表示法 */
#define MAX_TREE_SIZE 100
typedef struct  BPTNode
{
    int parentPosition; // 指向双亲的指针， 数组下标
    char data; // 该节点的数据
    char LRFlag; // 左右孩子标志域
}BPTNode;

typedef struct BPTree
{
    BPTNode nodes[100]; // 因为节点之间是分散，需要把节点存储到数组中
    int num_node;// 节点数目
    int root;//根节点的位置 注意此域存储的是父节点在数组中的下标
}BPTree;


int main000()
{
    BPTree tree;
    
    // 根节点 A
    tree.nodes[0].parentPosition = 1000;
    tree.nodes[0].data           = 'A';
    
    // 节点B
    tree.nodes[1].parentPosition = 0;  // 父节点位置 在数组中是0，即上面的A节点
    tree.nodes[1].data           = 'B';
    tree.nodes[1].LRFlag         = 'L';
    
     // 节点C
    tree.nodes[2].parentPosition = 0; // 父节点位置 在数组中是0，即上面的A节点
    tree.nodes[2].data           = 'C';
    tree.nodes[2].LRFlag         = 'R';
    return 0;
}


