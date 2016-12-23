//
//  main.c
//  Queue
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>

#include "LinkQueue.h"

int main(int argc, const char * argv[]) {
  
    int i = 0;
    int a[10] = {0};
    
    LinkQueue *queue = NULL;
    queue = LinkQueue_Create();
    if (queue == NULL) {
        return -1;
    }
    
    /** 队列就相当于2端都通的水管，水如果从左边流入，则从右边流出 */
    for (i=0; i<5; i++) {
        a[i] = i+1;
        // 使用了尾插法 故从左到右 header->1->2->3->4->5->tail； 取出时是取头部元素，故1 2 3 4 5
        LinkQueue_Append(queue, &a[i]);
    }
    
    printf("Length: %d\n",LinkQueue_Length(queue));
    printf("header:%d\n", *((int *)LinkQueue_Header(queue))  );
    
    while (LinkQueue_Length(queue) > 0) {
        // Retrieve 提取
        int tmp = *((int *) LinkQueue_Retrieve(queue));
        printf("Retrieve:%d\n",tmp);
    }
    
    LinkQueue_Destroy(queue);
    
    
    return 0;
}
