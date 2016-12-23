 // c6-4.h 树的二叉链表(孩子-兄弟)存储结构。在教科书第136页
 typedef struct CSNode 
 { TElemType data; 
   CSNode *firstchild,*nextsibling;
 }CSNode,*CSTree;

