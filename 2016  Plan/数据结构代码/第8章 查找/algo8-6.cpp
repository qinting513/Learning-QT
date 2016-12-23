 // algo8-6.cpp 检验bo8-4.cpp的程序
 #include"c1.h"
 #define m 3 
 int s=(m+1)/2; 
 typedef int KeyType; 
 struct Others 
 { int order; 
 };
 #include"c8-2.h" 
 #define N 12 
 #include"c8-4.h" 
 #include"c8-5.h" 
 #include"c8-6.h" 
 #include"bo8-4.cpp" 
 #include"func8-6.cpp" 

 void main()
 {
   Record r[N]={{24,1},{45,2},{53,3},{12,4},{37,5},{50,6},{61,7},{90,8},
   {100,9},{70,10},{3,11},{37,12}}; 
   BTree t;
   Result u;
   KeyType j;
   int i;
   InitDSTable(t); 
   for(i=0;i<N;i++) 
   { u=SearchBTree(t,r[i].key); 
     if(u.tag) 
       printf("树t中已存在关键字为%d的记录，故(%d,%d)无法插入。\n",r[i].key,
       r[i].key,r[i].others.order);
     else 
       InsertBTree(t,&r[i],u.pt,u.i);
       
   }
   printf("按关键字的顺序遍历B_树t：\n");
   TraverseDSTable(t,Visit); 
   for(i=1;i<=4;i++) 
   { printf("\n请输入待查找记录的关键字：");
     InputKey(j); 
     u=SearchBTree(t,j); 
     if(u.tag) 
       Visit(*(u.pt),u.i); 
     else 
       printf("未找到");
	 printf(" u.i=%d u.tag=%d",u.i,u.tag);
   }
   printf("\n");
   DestroyDSTable(t); 
 }

