//
//  BiTNode.h
//  BiTNode
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef BiTNode_h
#define BiTNode_h

#include <stdio.h>

/*
 typedef struct BiTNode
 {
 int data;
 struct BiTNode*lchild, *rchild;
 }BiTNode, *BiTree;
 */

// 二叉链表示法
struct BiTNode
{
    int data;
    struct BiTNode *lchild, *rchild;
};

typedef struct BiTNode BiTNode;
//typedef struct BiTNode *BiTree; // 没用到

// 先序遍历 DLR
void preOrder(BiTNode *root);

// 中序遍历 LDR
void inOrder(BiTNode *root);

// 后序遍历 LRD
void postOrder(BiTNode *root);

// 求叶子节点的个数
void countLeaf(BiTNode *root, int *sum);

// 求二叉树的深度 （高度）
int Depth(BiTNode * root);

// 拷贝 二叉树
BiTNode *copyTree(BiTNode* root);

#endif /* BiTNode_h */
