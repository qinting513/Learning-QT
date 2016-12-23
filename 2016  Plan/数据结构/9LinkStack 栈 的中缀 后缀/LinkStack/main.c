//
//  main.c
//  LinkStack
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//


#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "TestPrincipleOfNear.h"

#include "Transform.h"
#include "Calculate.h"

int main(int argc, const char * argv[]) {

    /** 测试就近原则 */
//    test();
    
    transform("8+(3-1)*5"); // 转化后 831-5*+
    
    printf("\n");
   int result = calculate("831-5*+");
    printf("result:%d\n",result);
    
    return 0;
}

