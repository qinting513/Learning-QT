//
//  main.c
//  Queue
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>

#include "SeqQueue.h"

int main(int argc, const char * argv[]) {
  
    int i = 0;
    int a[10] = {0};
    
    SeqQueue *queue = NULL;
    queue = SeqQueue_Create(10);
    if (queue == NULL) {
        return -1;
    }
    
    for (i=0; i<5; i++) {
        a[i] = i+1;
        // 使用了尾插法 故从左到右 header->1->2->3->4->5； 取出时是取头部元素，故1 2 3 4 5
        SeqQueue_Append(queue, &a[i]);
    }
    
    printf("Length: %d\n",SeqQueue_Length(queue));
    printf("Capacity: %d\n",SeqQueue_Capacity(queue));
    printf("header:%d\n", *((int *)SeqQueue_Header(queue)));
    
    while (SeqQueue_Length(queue) > 0) {
        // Retrieve 提取
        int tmp = *((int *) SeqQueue_Retrieve(queue));
        printf("Retrieve:%d\n",tmp);
    }
    
    SeqQueue_Destroy(queue);
    return 0;
}
