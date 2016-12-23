 // algo8-5.cpp 检验bo8-3.cpp的程序
 #include"c1.h"
 #include"func8-5.cpp" 
 #include"c8-2.h" 
 typedef ElemType TElemType; 
 #include"c8-3.h" 
 typedef BSTree BiTree; 
 #include"func8-4.cpp" 
 //#define FLAG // 加此句在bo8-3.cpp中直接做RL和LR平衡处理。第9行
 #include"bo8-3.cpp" 
 void main()
 {
   BSTree dt,p;
   int i,n;
   KeyType j;
   ElemType r;
   Boolean flag;
   Status k;
   FILE *f; 
   f=fopen("f8-4.txt","r"); 
   fscanf(f,"%d",&n); 
   InitDSTable(dt); 
   for(i=0;i<n;i++) 
   { InputFromFile(f,r); 
     k=InsertAVL(dt,r,flag); 
     if(k) 
     { printf("插入关键字为%d的结点后，按关键字顺序(中序)遍历平衡二叉树dt\n",r.key);
       TraverseDSTable(dt,Visit); 
       printf("\n先序遍历平衡二叉树dt\n");
       PreOrderTraverse(dt,Visit); 
       printf("\n");
     }
     else 
       printf("平衡二叉树dt中已存在关键字为%d的数据，故(%d,%d)无法插入到dt中。\n",
       r.key,r.key,r.others);
   }
   fclose(f); 
   printf("请输入待查找的关键字的值：");
   InputKey(j); 
   p=SearchBST(dt,j); 
   if(p) 
    printf("dt中存在关键字为%d的结点，其值为(%d,%d)。\n",j,p->data.key,
    p->data.others);
   else
     printf("dt中不存在关键字为%d的结点。\n",j);
   DestroyDSTable(dt); 
 }

