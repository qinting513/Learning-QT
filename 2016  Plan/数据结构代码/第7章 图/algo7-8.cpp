 // algo7-8.cpp 求关键路径。实现算法7.13、7.14的程序
 #include"c1.h"
 #include"func7-6.cpp" 
 #include"func7-7.cpp" 
 #include"c7-2'.h" 
 #include"bo7-2.cpp" 
 #include"func7-5.cpp" 
 typedef int SElemType; 
 #include"c3-1.h" 
 #include"bo3-1.cpp" 
 Status TopologicalOrder(ALGraph &G,SqStack &T)
 { 
   
   
   int i,k,count=0; 
   int indegree[MAX_VERTEX_NUM]; 
   SqStack S;
   ArcNode *p;
   FindInDegree(G,indegree); 
   InitStack(S); 
   printf("拓扑序列：");
   for(i=0;i<G.vexnum;++i) 
     if(!indegree[i]) 
       Push(S,i); 
   InitStack(T); 
   for(i=0;i<G.vexnum;++i) 
     G.vertices[i].data.ve=0;
   while(!StackEmpty(S)) 
   { Pop(S,i); 
     Visit(G.vertices[i].data); 
     Push(T,i); 
     ++count; 
     for(p=G.vertices[i].firstarc;p;p=p->nextarc)
     { 
       k=p->data.adjvex; 
       if(--indegree[k]==0) 
         Push(S,k);
       if(G.vertices[i].data.ve+p->data.info->weight>G.vertices[k].data.ve)
       
         G.vertices[k].data.ve=G.vertices[i].data.ve+p->data.info->weight;
         
     }   
   }
   if(count<G.vexnum)
   { printf("此有向网有回路\n");
     return ERROR;
   }
   else
     return OK;
 }

 Status CriticalPath(ALGraph &G)
 { 
   SqStack T;
   int i,j,k;
   ArcNode *p;
   if(!TopologicalOrder(G,T)) 
     return ERROR;
   j=G.vertices[0].data.ve; 
   for(i=1;i<G.vexnum;i++) 
     if(G.vertices[i].data.ve>j)
       j=G.vertices[i].data.ve; 
   for(i=0;i<G.vexnum;i++) 
     G.vertices[i].data.vl=j; 
   while(!StackEmpty(T)) 
     for(Pop(T,j),p=G.vertices[j].firstarc;p;p=p->nextarc)
     { 
       
       k=p->data.adjvex; 
       if(G.vertices[k].data.vl-p->data.info->weight<G.vertices[j].data.vl)
       
         G.vertices[j].data.vl=G.vertices[k].data.vl-p->data.info->weight;
         
     }   
   printf("\ni  ve  vl\n");
   for(i=0;i<G.vexnum;i++) 
   { printf("%d ",i); 
     Visitel(G.vertices[i].data); 
     if(G.vertices[i].data.ve==G.vertices[i].data.vl)
     
       printf(" 关键路径经过的顶点");
     printf("\n");
   }
   printf("j   k  权值  ee  el\n"); 
   for(j=0;j<G.vexnum;++j) 
     for(p=G.vertices[j].firstarc;p;p=p->nextarc)
     { 
       k=p->data.adjvex; 
       p->data.info->ee=G.vertices[j].data.ve;
       
       p->data.info->el=G.vertices[k].data.vl-p->data.info->weight;
       
       printf("%s→%s",G.vertices[j].data.name,G.vertices[k].data.name); 
       OutputArcwel(p->data.info); 
       if(p->data.info->ee==p->data.info->el)
       
         printf("关键活动");
       printf("\n");
     }
   return OK;
 }

 void main()
 {
   ALGraph h;
   printf("请选择有向网\n");
   CreateGraph(h); 
   Display(h); 
   CriticalPath(h); 
 }

