 // bo5-5.cpp 广义表的头尾链表存储结构(由c5-4.h定义)的基本操作(12个)，包括算法5.5～5.7
 #include"func5-3.cpp" 
 void InitGList(GList &L)
 { 
   L=NULL;
 }

 void CreateGList(GList &L,SString S) 
 { 
   SString sub,hsub,emp;
   GList p,q;
   StrAssign(emp,"()"); 
   if(!StrCompare(S,emp)) 
     L=NULL; 
   else 
   { if(!(L=(GList)malloc(sizeof(GLNode)))) 
       exit(OVERFLOW);
     if(StrLength(S)==1) 
     { L->tag=ATOM; 
       L->atom=S[1]; 
     }
     else 
     { L->tag=LIST; 
       p=L; 
       SubString(sub,S,2,StrLength(S)-2);
       
       do 
       { sever(sub,hsub); 
         CreateGList(p->ptr.hp,hsub); 
         q=p; 
         if(!StrEmpty(sub)) 
         { if(!(p=(GLNode*)malloc(sizeof(GLNode)))) 
             exit(OVERFLOW);
           p->tag=LIST; 
           q->ptr.tp=p; 
         }
       }while(!StrEmpty(sub)); 
       q->ptr.tp=NULL; 
     }
   }
 }

 void DestroyGList(GList &L)
 { 
   GList q1,q2;
   if(L) 
   { if(L->tag==LIST) 
     { q1=L->ptr.hp; 
       q2=L->ptr.tp; 
       DestroyGList(q1); 
       DestroyGList(q2); 
     }
     free(L); 
     L=NULL; 
   }
 }

 void CopyGList(GList &T,GList L)
 { 
   if(!L) 
     T=NULL;
   else 
   { T=(GList)malloc(sizeof(GLNode)); 
     if(!T)
       exit(OVERFLOW);
     T->tag=L->tag; 
     if(L->tag==ATOM) 
       T->atom=L->atom; 
     else 
     { CopyGList(T->ptr.hp,L->ptr.hp); 
       CopyGList(T->ptr.tp,L->ptr.tp); 
     }
   }
 }

 int GListLength(GList L)
 { 
   int len=0; 
   while(L) 
   { L=L->ptr.tp; 
     len++; 
   }
   return len;
 }

 int GListDepth(GList L)
 { 
   int dep,max=0;
   GList pp;
   if(!L) 
     return 1; 
   if(L->tag==ATOM) 
     return 0; 
   for(pp=L;pp;pp=pp->ptr.tp) 
   { dep=GListDepth(pp->ptr.hp); 
     if(dep>max)
       max=dep; 
   }
   return max+1; 
 }

 Status GListEmpty(GList L)
 { 
   if(!L)
     return TRUE;
   else
     return FALSE;
 }

 GList GetHead(GList L)
 { 
   GList h;
   if(!L) 
     return NULL;
   CopyGList(h,L->ptr.hp); 
   return h;
 }

 GList GetTail(GList L)
 { 
   GList t;
   if(!L) 
     return NULL;
   CopyGList(t,L->ptr.tp); 
   return t;
 }

 void InsertFirst_GL(GList &L,GList e)
 { 
   GList p=(GList)malloc(sizeof(GLNode)); 
   if(!p)
     exit(OVERFLOW);
   p->tag=LIST; 
   p->ptr.hp=e; 
   p->ptr.tp=L; 
   L=p; 
 }

 void DeleteFirst_GL(GList &L,GList &e)
 { 
   GList p=L; 
   e=L->ptr.hp; 
   L=L->ptr.tp; 
   free(p); 
 }

 void Traverse_GL(GList L,void(*visit)(AtomType))
 { 
   if(L) 
     if(L->tag==ATOM) 
       visit(L->atom);
     else 
     { Traverse_GL(L->ptr.hp,visit); 
       Traverse_GL(L->ptr.tp,visit); 
     }
 }


