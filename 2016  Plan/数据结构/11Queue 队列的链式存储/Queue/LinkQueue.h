//
//  LinkQueue.h
//  Queue
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef LinkQueue_h
#define LinkQueue_h

#include <stdio.h>

typedef void  LinkQueue;

LinkQueue *LinkQueue_Create();

void LinkQueue_Destroy(LinkQueue *queue);

void LinkQueue_Clear(LinkQueue *queue);

int LinkQueue_Append(LinkQueue *queue,void *item);

void* LinkQueue_Retrieve(LinkQueue *queue);

void* LinkQueue_Header(LinkQueue *queue);

int LinkQueue_Length(LinkQueue *queue);


#endif /* LinkQueue_h */
