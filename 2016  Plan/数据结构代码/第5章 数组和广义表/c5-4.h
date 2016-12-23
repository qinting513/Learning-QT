 // c5-4.h 广义表的头尾链表存储结构。在教科书第109页
 enum ElemTag{ATOM,LIST};
 // ATOM==0：原子,LIST==1：子表
 typedef struct GLNode
 { ElemTag tag; 
   union 
   { AtomType atom; 
     struct
     { GLNode *hp,*tp;
     }ptr; 
   };
 }*GList,GLNode; 

