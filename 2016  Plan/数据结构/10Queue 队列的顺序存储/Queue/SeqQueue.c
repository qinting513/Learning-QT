//
//  SeqQueue.c
//  Queue
//
//  Created by Qinting on 2016/12/17.
//  Copyright © 2016年 QT. All rights reserved.
//

#include "SeqQueue.h"

#include "SeqList.h"

/** 队列也是一种特殊的线性表，队列就是一个2头都通的管子 */

// 创建一个队列 相当于 创建一个顺序存储线性表
SeqQueue *SeqQueue_Create(int capacity)
{
    return SeqList_Create(capacity);
}

void SeqQueue_Destroy(SeqQueue *queue)
{
    SeqList_Destroy(queue);
}

void SeqQueue_Clear(SeqQueue *queue)
{
    SeqList_Clear(queue);
}

// 因为队列可以两端都插入，所以可以任选一种方式插入  头插法或者尾插法,
// 如果尾插法 删除元素时需从头部删除，
int SeqQueue_Append(SeqQueue *queue,void *item)
{
    return  SeqList_Insert(queue, item, SeqList_Length(queue));
}

void* SeqQueue_Retrieve(SeqQueue *queue)
{
    // 从头部开始删除元素
    return SeqList_Delete(queue, 0);
}

void* SeqQueue_Header(SeqQueue *queue)
{
    return SeqList_Get(queue, 0);
}

int SeqQueue_Length(SeqQueue *queue)
{
    return SeqList_Length(queue);
}

int SeqQueue_Capacity(SeqQueue *queue)
{
    return SeqList_Capacity(queue);
}
