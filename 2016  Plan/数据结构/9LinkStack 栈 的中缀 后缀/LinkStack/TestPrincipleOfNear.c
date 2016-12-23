//
//  TestPrincipleOfNear.c
//  LinkStack
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "TestPrincipleOfNear.h"
#include "TLinkStack.h"

// 声明部分
int scannerCode(const char *code);

void test()
{
    const char *code = "int main(int argc, const char * argv[]) { int a[10]; LinkStack *stack = NULL;";
    
    scannerCode(code);

}

int isLeftt(char c)
{
    int ret = 0;
    switch (c) {
        case '<':
        case '{':
        case '(':
        case '[':
        case '\'':
        case '\"':
            ret = 1;
            break;
        default:
            ret = 0;
    }
    return ret;
}

int isRightt(char c)
{
    int ret = 0;
    switch (c) {
        case '>':
        case '}':
        case ')':
        case ']':
        case '\'':
        case '\"':
            ret = 1;
            break;
        default:
            ret = 0;
    }
    return ret;
}

int match(char left, char right)
{
    int ret = 0;
    switch (left) {
        case '<': ret = (right == '>');break;
        case '{': ret = (right == '}');break;
        case '(': ret = (right == ')');break;
        case '[': ret = (right == ']');break;
        case '\'':ret = (right == '\'');break;
        case '\"':ret = (right == '\"');break;
        default:
            ret = 0;
            break;
    }
    return ret;
}

int scannerCode(const char *code)
{
    LinkStack *stack = LinkStack_Create();
    int ret = 0;
    int i = 0;
    
    // 对字符串遍历
    while (code[i] != '\0')
    {
        if (isLeftt(code[i]))
        {
            LinkStack_Push(stack, (void*)(code+i)); // &code[i];
        }
        
        if (isRightt(code[i]))
        {
            char *c = (char*)LinkStack_Pop(stack); // 出栈
            if( (c == NULL) || !match(*c,code[i]) )
            {
                printf("%c code not match!\n",code[i]);
                ret = 0;
                break;
            }
        }
        i++;
    }
    
    // 最后看是空栈，则成功
    if ((LinkStack_Size(stack) == 0)&&(code[i] == '\0'))
    {
        printf("success!\n");
        ret = 1;
    }else{
        printf("invalid syntax\n");
        ret = 0;
    }
    
    LinkStack_Destroy(stack);
    return ret;
}

