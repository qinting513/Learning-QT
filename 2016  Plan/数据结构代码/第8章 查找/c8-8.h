 // c8-8.h 双链键树的存储结构。在教科书第248页
 typedef struct DLTNode 
 { char symbol; 
   DLTNode *next; 
   NodeKind kind; 
   union 
   { Record *infoptr; 
     DLTNode *first; 
   };
 }DLTNode,*DLTree;
/*
enum NodeKind {LEAF, BRANCH};
template<typename D>struct DLTNode
{//带数据模板<D>的双链键树结点结构
	char symbol;
	NodeKind kind;
	union
	{
		Record<D> *rcptr;
		DLTNode<D> *first;
	};
	DLTNode<D> *next;
};
*/
