 // c5-5.h 广义表的扩展线性链表存储结构。在教科书第110页
 enum ElemTag{ATOM,LIST}; 
 typedef struct GLNode1
 { ElemTag tag; 
                
   union 
   { AtomType atom; 
     GLNode1 *hp; 
   };
   GLNode1 *tp; 
 }*GList1,GLNode1; 

