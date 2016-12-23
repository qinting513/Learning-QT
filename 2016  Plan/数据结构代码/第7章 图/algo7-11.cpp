 // algo7-11.cpp 实现教科书图7.33的程序(新增孤立顶点台北)
 #include"c1.h"
 #include"func7-1.cpp" 
 #include"func7-2.cpp" 
 #include"c7-1.h" 
 #include"bo7-1.cpp" 
 typedef char PathMatrix[MAX_VERTEX_NUM][MAX_VERTEX_NUM][MAX_VERTEX_NUM];
 // 三维数组，其值只可能是0或1，故用char类型以减少存储空间的浪费
 typedef VRType DistancMatrix[MAX_VERTEX_NUM][MAX_VERTEX_NUM]; 
 #include"func7-8.cpp" 

 void main()
 {
   MGraph g;
   int i,j,q=1;
   PathMatrix p; 
   DistancMatrix d; 
   char filename[8]="map.txt"; 
   CreateFromFile(g,filename,0); 
   for(i=0;i<g.vexnum;i++)
     g.arcs[i][i].adj=0;
     
   ShortestPath_FLOYD(g,p,d); 
   while(q)
   { printf("请选择：1 查询  0 结束\n");
     scanf("%d",&q);
     if(q)
     { printf("城市代码：\n");
       for(i=0;i<g.vexnum;i++)
       { printf("%2d.%-8s",i,g.vexs[i].name);
         if(i%7==6) 
           printf("\n");
       }
       printf("\n请输入要查询的起点城市代码 终点城市代码：");
       scanf("%d%d",&i,&j);
         path(g,d,p,i,j); 
     }
   }
 }

