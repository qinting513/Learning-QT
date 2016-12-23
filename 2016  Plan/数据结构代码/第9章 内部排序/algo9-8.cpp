 // alg9-8.cpp 链式基数排序，包括算法10.15～10.17
 #include"c1.h"
 typedef char KeysType; 
 typedef int InfoType; 
 #include"c9-4.h" 
 typedef SLList SqList; 
 #define length recnum 
 #include"func9-2.cpp" 

 void MadeListFromFile(SLList &L,FILE* f)
 { 
   int i;
   fscanf(f,"%d",&L.recnum); 
   for(i=1;i<=L.recnum;i++) 
     fscanf(f,"%s%d",&L.r[i].keys,&L.r[i].otheritems);
   L.keynum=strlen(L.r[1].keys); 
 }
 
 int ord(char c)
 { 
   return c-'0';
 }

 void Distribute(SLCell r[],int i,ArrType f,ArrType e)
 { 
   
   
   int j,p;
   for(j=0;j<RADIX;++j)
     f[j]=0; 
   for(p=r[0].next;p;p=r[p].next) 
   { j=ord(r[p].keys[i]); 
     if(!f[j]) 
       f[j]=p; 
     else 
       r[e[j]].next=p; 
     e[j]=p; 
   }
   printf("\nf[j]="); 
   for(j=0;j<RADIX;++j)
     printf("%3d",f[j]);
   printf("\ne[j]=");
   for(j=0;j<RADIX;++j)
     if(f[j])
       printf("%3d",e[j]);
     else
       printf("%3d",0);
   printf("\n");
 }

 int succ(int i)
 { 
   return ++i;
 }

 void Collect(SLCell r[],ArrType f,ArrType e)
 { 
   
   int j,t;
   for(j=0;!f[j];j=succ(j)); 
   r[0].next=f[j]; 
   t=e[j]; 
   while(j<RADIX-1) 
   { for(j=succ(j);j<RADIX-1&&!f[j];j=succ(j)); 
     if(f[j]) 
     { r[t].next=f[j]; 
       t=e[j]; 
     }
   }
   r[t].next=0; 
 }

 void Print2(SLList L)
 { 
   int i=0;
   printf("keynum=%d recnum=%d i=%d next=%d\n",L.keynum,L.recnum,i,
   L.r[i].next);
   for(i=1;i<=L.recnum;i++)
     printf("i=%d keys=%s otheritems=%d next=%d\n",i,L.r[i].keys,
     L.r[i].otheritems,L.r[i].next);
 }

 void PrintLL(SLList L)
 { 
   int i=L.r[0].next;
   while(i)
   { printf("%s ",L.r[i].keys);
     i=L.r[i].next;
   }
 }

 void RadixSort(SLList &L)
 { 
   
   int i,j=1;
   ArrType f,e;
   for(i=0;i<L.recnum;++i) 
     L.r[i].next=i+1;
   L.r[L.recnum].next=0;
   for(i=L.keynum-1;i>=0;--i,++j) 
   { Distribute(L.r,i,f,e); 
     printf("第%d趟分配后：\n",j);
     Print2(L); 
     Collect(L.r,f,e); 
     printf("第%d趟收集后：\n",j);
     Print2(L); 
     PrintLL(L); 
   }
 }

 void main()
 {
   FILE *f; 
   SLList m; 
   int *adr;
   f=fopen("f9-4.txt","r"); 
   MadeListFromFile(m,f); 
   fclose(f); 
   printf("排序前(next域还未赋值)：\n");
   Print2(m); 
   RadixSort(m); 
   adr=(int*)malloc((m.recnum+1)*sizeof(int)); 
   Sort(m,adr); 
   Rearrange(m,adr); 
   free(adr); 
   printf("\n重排记录后(next域不起作用)：\n");
   Print2(m); 
 }

