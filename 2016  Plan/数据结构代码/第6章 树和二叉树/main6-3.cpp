 // main6-3.cpp 检验线索二叉树部分基本操作的程序
 #define CHAR 1 
 //#define CHAR 0 // 整型(二者选一)。第3行
 #include"func6-1.cpp" 
 #include"c6-3.h" 
 #include"bo6-4.cpp" 
 #define FLAG 0 
 void main()
 {
   BiThrTree H,T;
   int i;
   for(i=1;i<=3;i++) 
   {
 #if CHAR 
     printf("请按先序输入二叉树(如：ab三个空格表示a为根结点，b为左子树的二叉树)：\n");
 #else 
     printf("请按先序输入二叉树(如：1 2 0 0 0表示1为根结点，2为左子树的二叉树)：\n");
 #endif
     CreateBiThrTree(T); 
     scanf("%*c"); 
     switch(i)
     { case 1:PreOrderThreading(H,T); 
              printf("先序遍历(输出)线索二叉树：\n");
              PreOrderTraverse_Thr(H,visit); 
              break;
       case 2:InOrderThreading(H,T); 
              printf("中序遍历(输出)线索二叉树：\n");
              InOrderTraverse_Thr(H,visit); 
              break;
       case 3:PostOrderThreading(H,T); 
 #if FLAG 
              printf("后序遍历(输出)线索二叉树：\n");
              PostOrderTraverse_Thr(H,visit);
 #endif
     }
     printf("\n");
     DestroyBiThrTree(H); 
   }
 }

