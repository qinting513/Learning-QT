//
//  Calculate.c
//  LinkStack
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "Calculate.h"
#include "TLinkStack.h"

int isNumber(char c)
{
    return ('0'<= c) && (c<='9');
}
int IsOperator(char c)
{
    return (c=='+')||(c=='-')||(c=='*')||(c=='/');
}

int value(char c)
{
    return (c-'0'); // 转变为字符
}

int express(int left,int right,char op)
{
    int ret = 0;
    switch (op) {
        case '+': ret = left + right; break;
        case '-': ret = left - right; break;
        case '*': ret = left * right; break;
        case '/': ret = left / right; break;
        default:
            ret = 0;
            break;
    }
    return ret;
}

int calculate(const char *exp)
{
    int ret = 0;
    LinkStack *stack = LinkStack_Create();
    int i = 0;
    
    while (exp[i] != '\0') {
        if (isNumber(exp[i]) ) {
            LinkStack_Push(stack, (void *)value(exp[i]) ); // 入栈
        }else if(IsOperator(exp[i]))
        {
            int right = (int)LinkStack_Pop(stack);
            int left  = (int)LinkStack_Pop(stack);
            int result = express(left, right, exp[i]);
            LinkStack_Push(stack, (void*)result);
        }
        else{
            printf("Invalid expression!");
            break;
        }
        i++;
    }
    
    if (LinkStack_Size(stack) == 1 && (exp[i] == '\0')) {
        ret = (int)LinkStack_Pop(stack);
    }
    else{
        printf("Invalid expression!");
    }
    LinkStack_Destroy(stack);
    return ret;
}
