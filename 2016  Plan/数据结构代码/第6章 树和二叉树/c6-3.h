 // c6-3.h 二叉树的二叉线索存储结构。在教科书第133页
 enum PointerTag 
 {Link,Thread}; 
 struct BiThrNode
 { TElemType data; 
   BiThrNode *lchild,*rchild; 
   PointerTag LTag:2; 
   PointerTag RTag:2; 
 };
 typedef BiThrNode *BiThrTree;

