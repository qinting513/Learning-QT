 // bo5-6.cpp 广义表的扩展线性链表存储(存储结构由c5-5.h定义)的基本操作(12个)
 #include"func5-3.cpp" 

 void InitGList(GList1 &L)
 { 
   L=(GList1)malloc(sizeof(GLNode1)); 
   L->tag=LIST; 
   L->hp=L->tp=NULL; 
 }

 void Create(GList1 &L,SString S)
 { 
   SString emp,sub,hsub;
   GList1 p;
   StrAssign(emp,"()"); 
   if(!(L=(GList1)malloc(sizeof(GLNode1)))) 
     exit(OVERFLOW);
   if(!StrCompare(S,emp)) 
   { L->tag=LIST; 
     L->hp=NULL; 
   }
   else if(StrLength(S)==1) 
   { L->tag=ATOM; 
     L->atom=S[1]; 
   }
   else 
   { L->tag=LIST; 
     SubString(sub,S,2,StrLength(S)-2);
     
     sever(sub,hsub); 
     Create(L->hp,hsub); 
     p=L->hp; 
     while(!StrEmpty(sub)) 
     { sever(sub,hsub); 
       Create(p->tp,hsub); 
       p=p->tp; 
     }
   }
   L->tp=NULL; 
 }

 void CreateGList(GList1 &L,SString S) 
 { 
   SString emp,sub,hsub;
   GList1 p;
   StrAssign(emp,"()"); 
   if(!StrCompare(S,emp)) 
     InitGList(L); 
   else 
   { SubString(sub,S,2,StrLength(S)-2);
     
     sever(sub,hsub); 
     Create(L->hp,hsub); 
     p=L->hp; 
     while(!StrEmpty(sub)) 
     { sever(sub,hsub); 
       Create(p->tp,hsub); 
       p=p->tp; 
     }
     p->tp=NULL; 
   }
 }

 void DestroyGList(GList1 &L)
 { 
   GList1 ph,pt;
   if(L) 
   { 
     if(L->tag) 
       ph=L->hp;
     else 
       ph=NULL;
     pt=L->tp;
     DestroyGList(ph); 
     DestroyGList(pt); 
     free(L); 
     L=NULL; 
   }
 }

 void CopyGList(GList1 &T,GList1 L)
 { 
   T=NULL;
   if(L) 
   { T=(GList1)malloc(sizeof(GLNode1));
     if(!T)
       exit(OVERFLOW);
     T->tag=L->tag; 
     if(L->tag==ATOM) 
       T->atom=L->atom; 
     else
       CopyGList(T->hp,L->hp); 
     if(L->tp==NULL) 
       T->tp=L->tp;
     else
       CopyGList(T->tp,L->tp); 
   }
 }

 int GListLength(GList1 L)
 { 
   int len=0;
   GList1 p=L->hp; 
   while(p)
   { len++;
     p=p->tp;
   };
   return len;
 }

 int GListDepth(GList1 L)
 { 
   int max=0,dep;
   GList1 p;
   if(L->tag==LIST&&!L->hp)
     return 1; 
   else if(L->tag==ATOM)
     return 0; 
   else 
     for(p=L->hp;p;p=p->tp)
     { dep=GListDepth(p); 
       if(dep>max)
         max=dep;
     }
   return max+1; 
 }

 Status GListEmpty(GList1 L)
 { 
   if(!L->hp)
     return OK;
   else
     return ERROR;
 }

 GList1 GetHead(GList1 L)
 { 
   GList1 h,p;
   if(!L->hp) 
     return NULL;
   p=L->hp->tp; 
   L->hp->tp=NULL; 
   CopyGList(h,L->hp); 
   L->hp->tp=p; 
   return h;
 }

 GList1 GetTail(GList1 L)
 { 
   GList1 t;
   InitGList(t); 
   if(L->hp) 
     CopyGList(t->hp,L->hp->tp); 
   return t;
 }

 void InsertFirst_GL(GList1 &L,GList1 e)
 { 
   GList1 p=L->hp; 
   L->hp=e; 
   e->tp=p; 
 }

 void DeleteFirst_GL(GList1 &L,GList1 &e)
 { 
   e=L->hp; 
   if(L->hp) 
   { L->hp=e->tp; 
     e->tp=NULL; 
   }
 }

 void Traverse_GL(GList1 L,void(*visit)(AtomType))
 { 
   if(L) 
   { if(L->tag==ATOM) 
       visit(L->atom); 
     else 
       Traverse_GL(L->hp,visit); 
     Traverse_GL(L->tp,visit); 
   }
 }

