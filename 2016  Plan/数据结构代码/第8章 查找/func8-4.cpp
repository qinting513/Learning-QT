 // func8-4.cpp 包括算法9.5(a)和bo6-2.cpp，algo8-4.cpp和algo8-5.cpp调用
 #include"bo6-2.cpp" 
 #define InitDSTable InitBiTree 
 #define DestroyDSTable DestroyBiTree 
 #define TraverseDSTable InOrderTraverse
 // 按关键字顺序遍历二叉排序树和平衡二叉树与中序遍历二叉树的操作同

 BiTree SearchBST(BiTree T,KeyType key)
 { 
   
   if(!T||EQ(key,T->data.key)) 
     return T; 
   else if LT(key,T->data.key) 
     return SearchBST(T->lchild,key); 
   else 
     return SearchBST(T->rchild,key); 
 }

