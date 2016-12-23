//
//  BiTNode.c
//  BiTNodeIterator
//
//  Created by Qinting on 2016/12/18.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "BiTNode.h"
#include "TLinkStack.h"


void inOrder(BiTNode *root)
{
    if (root == NULL) {
        return;
    }
    //中序遍历 LDR
    inOrder(root->lchild);
    
    printf("%d   ",root->data);
    
    inOrder(root->rchild);
}


/** 非递归遍历:
 步骤1:
 如果节点有左子树，该节点入栈
 如果节点没有左子树，访问该节点
 步骤2:
 如果节点有右子树，重复步骤1；
 如果节点没有右子树(节点访问完毕),根据栈顶指示回退，访问栈顶元素，并访问右子树，重复步骤1
 如果栈为空 遍历结束。
 注意：入栈的节点表示，本身没有被访问过，同时右子树也没有被访问过。
 */


BiTNode *goLeft(BiTNode *T, LinkStack *s)
{
    if (T == NULL) {
        return NULL;
    }
    while (T->lchild != NULL) {
        LinkStack_Push(s,T); //如果T有做孩子，则入栈，再往左走
        T = T->lchild;
    }
    
    return  T;
}

void inOrderWithStack(BiTNode *root)
{
    LinkStack *stack  = NULL;
    // 创建栈
    stack = LinkStack_Create();
    
    BiTNode *t = NULL;
    // 递归  找到中序遍历的起点
    t = goLeft(root, stack);
    while (t) {
        
        printf("%d  ",t->data); // 找到中序遍历的起点
        // 如果t有右子树 重复步骤1
        if (t->rchild != NULL) {
            t = goLeft(t->rchild, stack); // 右子树中序遍历的起点
        }else if( LinkStack_Size(stack) > 0){
             // 如果没有右子树，并且栈不为空 根据栈顶指示访问栈顶元素，并访问右子树，重复步骤1
            t = (BiTNode *)LinkStack_Top(stack);
                 LinkStack_Pop(stack); // 出栈
        }else{
            // 如果没有右子树，并且栈为空 结束遍历
            t = NULL;
        }
        
       
    }
    
    
}
