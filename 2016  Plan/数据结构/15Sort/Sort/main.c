//
//  main.c
//  Sort
//
//  Created by Qinting on 2016/12/18.
//  Copyright © 2016年 QT. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void Printf(int arr[],int len)
{
    for (int i = 0; i<len; i++) {
        printf("%d   ",arr[i]);
    }
    printf("\n");
}

void swap(int arr[],int i,int j)
{
    int tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
}

  // 选择排序，每次都选出最小的数放到最前面来
void SelectionSort(int array[],int len){
    for (int i = 0; i<len-1; i++) {   // 排序到len-1位即可
        for (int j = i+1; j<len; j++) { // j从i+1位开始循环，即i与后面的数进行比较
            if (array[i] > array[j]) {
                int tmp = array[i];
                array[i] = array[j];
                array[j] = tmp;
            }
        }
    }
}

/**  插入排序 将元素拿出来，然后比较，满足的则后移 */
void InsertSort(int array[],int len){
    int tmp = -1;
    int k = -1;
    for (int i=1; i<len; i++) {
        tmp = array[i];
        k = i; // 待插入的位置
        // tmp是拿出来的那个数，跟i前面数比较，tmp小于前面的数，则前面的数后移,并将tmp插入到合适位置
        for (int j=i-1; j>=0 && (tmp < array[j]); j--)
        {
                array[j+1] = array[j]; // 元素后移
                k = j;                 // 并记录插入位置
        }
        array[k] = tmp; // 元素插入
    }
}

// 冒泡法： 每循环一次 大的数都往最后移
void BobbleSort(int arr[],int len)
{
    for (int i = 0; i<len-1; i++) {
        for (int j = 1; j<len; j++) {
            if (arr[j-1]>arr[j]) {
                swap(arr, j, j-1);
            }
        }
    }
}

//冒泡法： 优化的 exchange  小的数往前移动
void BubbleSort(int arr[],int len) //  O(n*n)
{
    int exchange = 1; // exchange=0 表明数组已经排序好 ，=1 表示没有排序好
    for (int i = 0; (i<len) && exchange; i++) {
        exchange = 0; // 认为已经排序好
        for (int j=len-1; j>i; j--)
        {
            if (arr[j-1] > arr[j]) {
                swap(arr, j, j-1);
                exchange = 1;
            }
        }
    }
}

/** 希尔排序 */
void ShellSort(int arr[],int len)
{
    int k =-1;
    int tmp = -1;
    int gap = len;
    
    do {
        // 业界统一实验的 平均最好情况，经过若干次后 收敛为1
        gap = gap/3 + 1; //进行分组的
        for (int i=gap; i<len; i+=gap)
        {
            k = i; // 插入的地方，类似插入法
            tmp = arr[k];
            
            for (int j=i-gap; (j>=0)&&(arr[j]>tmp); j-=gap) {
                arr[j+gap] = arr[j];
                k=j;
            }
            arr[k] = tmp; // k在上一个for循环里，k的值有改变了的话 则修改
        }
        
    } while (gap > 1);
}

/********************** 快速排序 *****************************/
int partion(int arr[], int low, int high)
{
    int pv = arr[low];
    while (low < high)
    {
        while ( (low<high) && (arr[high] >= pv) ){
            high --; //右边部分 比基准的大，本来就在右边，所以high往前移动
        }
        swap(arr, low, high); // 如果arr[high]比基准pv小，则交换low跟high的值
        
        while ( (low<high) && (arr[low] <= pv) ){
            low ++;//左边部分 比基准的小，本来就在左边，所以low往后移动
        }
        swap(arr, low, high); // 如果arr[low]比基准pv大，则交换low跟high的值
    }
    return low;
}

void QSort(int arr[],int low, int high)
{
    if (low < high)
    {
        // 选取一个pv值，把数据分别放在pv值的左右两边，并把pivot位置返回
        int pivot = partion(arr, low, high);
        
        // 对左序列排序
        QSort(arr, low, pivot-1);
        
        // 对右序列排序
        QSort(arr, pivot+1, high);
    }
}

void QuickSort(int array[], int len)
{
    QSort(array, 0, len-1);
}

/***************************************************/
/********************** 归并排序 *****************************/
void Merge(int srcArr[],int desArr[], int low, int mid, int high)
{
    int i = low;
    int j = mid+1;
    int k = low;
    while (i<=mid && j<=high) // 将小的数放到目的数组中
    {
//        i*******************mid  j******high
        if (srcArr[i] < srcArr[j] ) {
            desArr[k++] = srcArr[i++]; // 赋值完成后 要移位
        }else{
            desArr[k++] = srcArr[j++]; // i++ 还是 j++
        }
    }
    // 移完一边后某一边有剩余的
    //  若还剩余尾部元素的
    while (i<= mid) {
        desArr[k++] = srcArr[i++];
    }
    while (j<= high) {
        desArr[k++] = srcArr[j++];
    }
    
}

// 每次分为2路，当只剩下一个元素的时候 就不需要再划分
void MSort(int src[], int des[], int low, int high, int max)
{
    if (low == high) {
        //只有一个元素，不需要归并，结果赋给des[low]
        des[low] = src[low];
    }else{ // 如果多个元素，划分为2路
        int  mid = (low+high) / 2;
        int *space = (int *)malloc(sizeof(int) *max);
        
        // 当剩下一个元素的时候，递归划分结束，然后开始merge归并操作
        if (space != NULL) {
            MSort(src, space, low, mid, max);
            MSort(src, space, mid+1, high, max);
            Merge(space, des, low, mid, high); //调用函数 归并
        }
        free(space);
    }

}
void MergeSort(int arr[], int len)  // O(n*logn)
{
    MSort(arr, arr, 0, len-1, len);
}

/***************************************************/
int main(int argc, const char * argv[]) {
    int arr[6] = {10,31,4,6,7,2};
    int len = sizeof(arr) / sizeof(*arr);
    
// 选择排序
//    Printf(arr,len);
//    SelectionSort(arr, len);
//    Printf(arr,len);
    
// 插入排序
//        Printf(arr,len);
//        InsertSort(arr, len);
//        Printf(arr,len);
    
//    Printf(arr,len);
//    BubbleSort(arr, len);
//    Printf(arr,len);
    
//    Printf(arr,len);
//    ShellSort(arr, len);
//    Printf(arr,len);

//    Printf(arr,len);
//    QuickSort(arr, len);
//    Printf(arr,len);

    Printf(arr,len);
    MergeSort(arr, len);
    Printf(arr,len);
    
    return 0;
}
