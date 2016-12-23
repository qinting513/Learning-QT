 // algo7-9.cpp 实现算法7.15的程序。迪杰斯特拉算法的实现
 #include"c1.h"
 #include"func7-1.cpp" 
 #include"func7-2.cpp" 
 #include"c7-1.h" 
 #include"bo7-1.cpp" 
 typedef Status PathMatrix[MAX_VERTEX_NUM][MAX_VERTEX_NUM]; 
 typedef VRType ShortPathTable[MAX_VERTEX_NUM]; 

 void ShortestPath_DIJ(MGraph G,int v0,PathMatrix P,ShortPathTable D)
 { 
   
   
   int v,w,i,j;
   VRType min;
   Status final[MAX_VERTEX_NUM];
   
   for(v=0;v<G.vexnum;++v)
   { final[v]=FALSE; 
     D[v]=G.arcs[v0][v].adj; 
     for(w=0;w<G.vexnum;++w)
       P[v][w]=FALSE; 
     if(D[v]<INFINITY) 
       P[v][v0]=P[v][v]=TRUE;
       
   }
   D[v0]=0; 
   final[v0]=TRUE; 
   for(i=1;i<G.vexnum;++i) 
   { 
     min=INFINITY; 
     for(w=0;w<G.vexnum;++w) 
       if(!final[w]&&D[w]<min) 
       { 
         v=w; 
         min=D[w]; 
       }
     final[v]=TRUE; 
     for(w=0;w<G.vexnum;++w) 
       if(!final[w]&&min<INFINITY&&G.arcs[v][w].adj<INFINITY&&(min+
       G.arcs[v][w].adj<D[w]))
       { 
         D[w]=min+G.arcs[v][w].adj; 
         for(j=0;j<G.vexnum;++j)
         
           P[w][j]=P[v][j];
         P[w][w]=TRUE;
       }
   }
 }

 void Path(MGraph G,int v0,int v,PathMatrix P)
 { 
   Status path[MAX_VERTEX_NUM]; 
   VRType min; 
   int i,j=0,k,m; 
   for(i=0;i<G.vexnum;++i)
   {
     path[i]=P[v][i];
     if(path[i]) 
       j++;
   }
   path[v0]=FALSE;
   if(j) 
     j--; 
   k=v0; 
   while(j)
   {
     min=INFINITY;
     printf("%s→",G.vexs[k].name);
     for(i=0;i<G.vexnum;++i) 
       if(path[i]&&G.arcs[k][i].adj<min) 
       {
         min=G.arcs[k][i].adj; 
         m=i; 
       }
     k=m;
     path[k]=FALSE;
     j--; 
   }
   if(k!=v0)
     printf("%s\n",G.vexs[k].name);
 }

 void main()
 {
   int i,j;
   MGraph g;
   PathMatrix p; 
   ShortPathTable d; 
   int k=0; 
   CreateFromFile(g,"f7-5.txt",0); 
   Display(g); 
   ShortestPath_DIJ(g,k,p,d);
   
   printf("最短路径数组p[i][j]如下：\n");
   for(i=0;i<g.vexnum;++i)
   { for(j=0;j<g.vexnum;++j)
       printf("%d ",p[i][j]);
     printf("\n");
   }
   printf("%s到各顶点的最短路径长度和依次经过的顶点为\n",g.vexs[k].name);
   for(i=0;i<g.vexnum;++i)
   {
     if(i!=k)
       printf("%s→%s：%d",g.vexs[k].name,g.vexs[i].name,d[i]);
     if(d[i]<INFINITY)
       printf("\t");
     else
       printf("\n");
     Path(g,k,i,p);
   }
 }

