//
//  BiTNode.c
//  BiTNode
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "BiTNode.h"

/**  树的结构:
        1
       / \
      2   3
     /    /
    4    5   6
 
 */

// 先序遍历 DLR
void preOrder(BiTNode *root)
{
    if (root == NULL) {
        return;
    }
    // 先遍历根节点
    printf("%d  ",root->data);  // 遍历出来是  1 2 4 3 5
    // 遍历 左子树
    
    preOrder(root->lchild);
    
    // 遍历 右子树
    preOrder(root->rchild);

}

// 中序遍历 LDR
void inOrder(BiTNode *root)
{
    if (root == NULL) {
        return;
    }
    // 遍历 左子树
    inOrder(root->lchild);
    
    // 遍历根节点
    printf("%d  ",root->data);  // 遍历出来是  1 2 4 3 5

    // 遍历 右子树
    inOrder(root->rchild);
}

// 后序遍历 LRD
void postOrder(BiTNode *root)
{
    if (root == NULL) {
        return;
    }
    // 遍历 左子树
    postOrder(root->lchild);
    // 遍历 右子树
    postOrder(root->rchild);
    // 遍历根节点
    printf("%d  ",root->data);  // 遍历出来是  1 2 4 3 5
    
    
}

// 求叶子节点的个数
void countLeaf(BiTNode *root, int *sum)
{
    if (root != NULL) {
        if ( (root->lchild == NULL) && (root->rchild == NULL)){
            // 注意啊 （*sum） 星号是取值操作，如果写成 * sum++； 先运算++，而且是地址++ ，然后才取值
            (*sum) ++;
        }
        if (root->lchild) {
            countLeaf(root->lchild, sum); // 传一个int * 的指针变量，而sum 刚好是
        }
        if (root->rchild) {
            countLeaf(root->rchild, sum);
        }
    }
}

// 求一棵树的深度
int Depth(BiTNode * root)
{
    int  deptLeft  = 0;
    int  deptRight = 0;
    int  deptValue = 0;
    
    if (root == NULL) {
        deptValue = 0;
        return deptValue;
    }
    
    // 求左子树高度
    deptLeft = Depth(root->lchild);
    // 求右子树高度
    deptRight = Depth(root->rchild);
    
    deptValue = 1 + (deptLeft>deptRight ? deptLeft : deptRight);
    
    return deptValue;
}

BiTNode *copyTree(BiTNode* root)
{
    BiTNode *newRoot = NULL;
    BiTNode *newLp   = NULL;
    BiTNode *newRp   = NULL;
    
    if (root == NULL) {
        return  NULL;
    }
    
    // copy 左子树
    if (root->lchild != NULL) {
        newLp = copyTree(root->lchild);
    }else{
        newLp = NULL;
    }
    
    // copy 右子树
    if (root->rchild != NULL) {
        newRp = copyTree(root->rchild);
    }else{
        newRp = NULL;
    }
    
    // 创建节点
    newRoot = (BiTNode *)malloc(sizeof(BiTNode));
    memset(newRoot, 0, sizeof(BiTNode));
    if (newRoot == NULL) {
        return NULL;
    }
    newRoot->lchild = newLp;
    newRoot->rchild = newRp;
    newRoot->data = root->data;
    
    return newRoot;
}

// 按照给定的先序序列 建立二叉树
BiTNode * createBiTree(BiTNode *T)
{
    char ch;
    printf("请输入字符:\n");
    scanf("%c",&ch);
    
    BiTNode *newNode = NULL;
    
        char tmp = ch;
        if (tmp == '#') {
            return NULL;
        }else{
            newNode = (BiTNode *) malloc(sizeof(BiTNode));
            memset(newNode, 0, sizeof(BiTNode));
            newNode->data = tmp;
           
               newNode->lchild  = createBiTree(NULL); // 构造左子树
               newNode->rchild  = createBiTree(NULL); // 构造右子树
        }
       return newNode;
}

// 释放
void FreeTree(BiTNode *T)
{
    if (T == NULL) {
        return;
    }
    if (T->lchild != NULL) {
        FreeTree(T->lchild);
        T->lchild = NULL;
    }
    
    if (T->rchild != NULL) {
        FreeTree(T->rchild);
        T->rchild = NULL;
    }
    if (T != NULL) {
        free(T);
        T = NULL;
    }
}

//  未完成。。。
BiTNode * createBiTreeWith(BiTNode *T,char *p)
{

    BiTNode *newNode = NULL;
    BiTNode *left    = NULL;
    BiTNode *right   = NULL;
  
    while (*p != '\0') {

        char tmp = *p;
        if (tmp == '#') {
            return NULL;
        }else{
            newNode = (BiTNode *) malloc(sizeof(BiTNode));
            memset(newNode, 0, sizeof(BiTNode));
            newNode->data = tmp;
            p++;
            left  = createBiTreeWith(NULL, p); // 构造左子树
            right = createBiTree(NULL); // 构造右子树
            
            /** newNode->lchild = left; // 不管是不是NULL，都赋值啊? */
            if (left != NULL) {
                newNode->lchild = left;
            }else{
                newNode->lchild = NULL;
            }
            
            if (right != NULL) {
                newNode->rchild = right;
            }else{
                newNode->rchild = NULL;
            }
        }
    
  }
    return newNode;
}

