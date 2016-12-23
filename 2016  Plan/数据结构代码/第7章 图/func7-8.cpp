 // func7-8.cpp 算法7.16，algo7-10.cpp和algo7-11.cpp用到
 void ShortestPath_FLOYD(MGraph G,PathMatrix P,DistancMatrix D)
 { 
   
   int u,v,w,i;
   for(v=0;v<G.vexnum;v++) 
     for(w=0;w<G.vexnum;w++)
     { D[v][w]=G.arcs[v][w].adj; 
       for(u=0;u<G.vexnum;u++)
         P[v][w][u]=FALSE; 
       if(D[v][w]<INFINITY) 
         P[v][w][v]=P[v][w][w]=TRUE; 
     }
   for(u=0;u<G.vexnum;u++)
     for(v=0;v<G.vexnum;v++)
       for(w=0;w<G.vexnum;w++)
         if(D[v][u]<INFINITY&&D[u][w]<INFINITY&&D[v][u]+D[u][w]<D[v][w])
         { 
           D[v][w]=D[v][u]+D[u][w]; 
           for(i=0;i<G.vexnum;i++)
             P[v][w][i]=P[v][u][i]||P[u][w][i];
             
         }
 }

 void path(MGraph G,DistancMatrix D,PathMatrix P,int i, int j)
 {
   char p[MAX_VERTEX_NUM];
   int k, n, m=i;
   VRType a;
   if(i!=j)
   {
     for(k=0; k<G.vexnum; k++)
       p[k]=P[i][j][k];
     printf("与%s到%s有关的p[]=：",G.vexs[i].name,G.vexs[j].name,i,j);
     for(k=0; k<G.vexnum; k++)
       printf("%d ",p[k]);
     if(D[i][j]<INFINITY)
     {
       while(m!=j)
       {
         a=INFINITY;
         for(k=0; k<G.vexnum; k++)
           if(G.arcs[m][k].adj<a && p[k])
           {
             a=G.arcs[m][k].adj;
             n=k;
           }
         printf("%s",G.vexs[n].name);
         if(n!=j)
           printf("→");
         p[n]=false;
         m=n;
       }
       printf("。最短距离：%d\n",D[i][j]);
     }
     else
       printf("%s到%s没有路径可通。\n",G.vexs[i].name,G.vexs[j].name);
   }
 }

