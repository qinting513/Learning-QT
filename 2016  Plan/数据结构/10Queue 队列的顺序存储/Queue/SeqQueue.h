//
//  SeqQueue.h
//  Queue
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#ifndef SeqQueue_h
#define SeqQueue_h

#include <stdio.h>


typedef void  SeqQueue;

SeqQueue *SeqQueue_Create(int capacity);

void SeqQueue_Destroy(SeqQueue *queue);

void SeqQueue_Clear(SeqQueue *queue);

int SeqQueue_Append(SeqQueue *queue,void *item);

void* SeqQueue_Retrieve(SeqQueue *queue);

void* SeqQueue_Header(SeqQueue *queue);

int SeqQueue_Length(SeqQueue *queue);

int SeqQueue_Capacity(SeqQueue *queue);


#endif /* SeqQueue_h */
