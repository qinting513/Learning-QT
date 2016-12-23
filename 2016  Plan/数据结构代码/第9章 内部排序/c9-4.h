 // c9-4.h 基数排序的数据类型。在教科书第286页
 #define MAX_NUM_OF_KEY 8 
 #define RADIX 10 
 #define MAX_SPACE 100
 struct SLCell 
 { KeysType keys[MAX_NUM_OF_KEY]; 
   InfoType otheritems; 
   int next;
 };

 struct SLList 
 { SLCell r[MAX_SPACE]; 
   int keynum; 
   int recnum; 
 };

 typedef int ArrType[RADIX]; 

