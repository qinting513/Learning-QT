//
//  BiTNode.h
//  BiTNodeIterator
//
//  Created by Qinting on 2016/12/18.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef BiTNode_h
#define BiTNode_h

#include <stdio.h>

// 定义一个二叉树
typedef struct _tag_BiTNode
{
    struct _tag_BiTNode *lchild,*rchild;
    int data;
}BiTNode;

// 中序遍历 LDR
void inOrder(BiTNode *root);
void inOrderWithStack(BiTNode *root);

#endif /* BiTNode_h */
