 // c8-3.h 平衡二叉树的存储结构。在教科书第236页
 typedef struct BSTNode
 { ElemType data; 
   int bf; 
   BSTNode *lchild,*rchild; 
 }BSTNode,*BSTree;

