//
//  Transform.c
//  LinkStack
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "Transform.h"
#include "TLinkStack.h"

void output(char c)
{
    if (c != '\0') {
        printf("%c",c);
    }
}
// 判断是不是数字
int isNum(char c)
{
//    int ret = 0;
//    int tmp = c - '0';
//    if (tmp >= 0 && tmp <=9) {
//        ret = 1;
//    }
//    return ret;
    return ('0'<=c) && (c<='9');
}
int isOperator(char c)
{
//    int ret = 0;
//    switch (c) {
//        case '+':
//        case '-':
//        case '*':
//        case '/':
//            ret = 1;
//            break;
//        default:
//            ret = 0;
//    }
//    return ret;
    return (c=='+') || (c=='-') || (c=='*') || (c=='/');
}

int isLeft(char c)
{
    return (c=='(');
}

int isRight(char c)
{
    return (c==')');
}

int priority(char c)
{
    int ret = 0;
    if( (c == '+') || (c=='-')){
        ret = 1;
    }
    if( (c == '*') || (c=='/')){
        ret = 2;
    }
    return ret;
}


void transform(const char *exp)
{
    int i = 0;
    LinkStack *stack = LinkStack_Create();
    
    while (exp[i] != '\0') {
    
        if( isNum(exp[i]) ){
            output(exp[i]);
        }else if(isOperator(exp[i]))
        {
            while ( priority(exp[i]) <= priority((char)(int)LinkStack_Top(stack))  ) {
                // 弹栈出来
                output((char)(int)LinkStack_Pop(stack));
            }
            LinkStack_Push(stack, (void*)(int)exp[i]);
        }else if( isLeft(exp[i]))
        { // 如果是左扩号 直接入栈
            LinkStack_Push(stack, (void*)(int)exp[i] );
        }else if( isRight(exp[i]) )
        {
            // char c = '\0'
            // 如果是又扩号 ，则弹出 直到匹配到左括号为止
            while ( !isLeft( (char)(int)LinkStack_Top(stack) ) ) {
                output( (char)(int)LinkStack_Pop(stack) );
            }
            
            LinkStack_Pop(stack);
        }else {
            printf("Invalid expression!");
            break;
        }
        i++;
    }
    
    // 最后输出栈中所有的东西
    while (LinkStack_Size(stack)>0 && (exp[i] == '\0')) {
        output((char)(int)LinkStack_Pop(stack) );
    }
    
}
