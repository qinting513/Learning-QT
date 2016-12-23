 // bo6-4.cpp 构造线索二叉树的11个基本操作，包括算法6.5～6.7
 void CreateBiThrTree(BiThrTree &T)
 { 
   TElemType ch;
   scanf(form,&ch); 
   if(ch==Nil) 
     T=NULL;
   else 
   { T=(BiThrTree)malloc(sizeof(BiThrNode)); 
     if(!T)
       exit(OVERFLOW);
     T->data=ch; 
     CreateBiThrTree(T->lchild); 
     if(T->lchild) 
       T->LTag=Link; 
     CreateBiThrTree(T->rchild); 
     if(T->rchild) 
       T->RTag=Link; 
   }
 }

 BiThrTree pre; 
 void InThreading(BiThrTree p)
 { 
   if(p) 
   { InThreading(p->lchild); 
     if(!p->lchild) 
     { p->LTag=Thread; 
       p->lchild=pre; 
     }
     if(!pre->rchild) 
     { pre->RTag=Thread; 
       pre->rchild=p; 
     }
     pre=p; 
     InThreading(p->rchild); 
   }
 }

 void InOrderThreading(BiThrTree &Thrt,BiThrTree T)
 { 
   if(!(Thrt=(BiThrTree)malloc(sizeof(BiThrNode)))) 
     exit(OVERFLOW);
   Thrt->LTag=Link; 
   Thrt->RTag=Thread; 
   Thrt->rchild=Thrt; 
   if(!T) 
     Thrt->lchild=Thrt;
   else 
   { Thrt->lchild=T; 
     pre=Thrt; 
     InThreading(T); 
     pre->rchild=Thrt; 
     pre->RTag=Thread; 
     Thrt->rchild=pre; 
   }
 }

 void InOrderTraverse_Thr(BiThrTree T,void(*Visit)(TElemType))
 { 
   BiThrTree p;
   p=T->lchild; 
   while(p!=T)
   { 
     while(p->LTag==Link) 
       p=p->lchild; 
     Visit(p->data); 
     while(p->RTag==Thread&&p->rchild!=T)
     { 
       p=p->rchild; 
       Visit(p->data); 
     }
     
     p=p->rchild;
   }
 }

 void PreThreading(BiThrTree p)
 { 
   if(!pre->rchild) 
   { pre->RTag=Thread; 
     pre->rchild=p; 
   }
   if(!p->lchild) 
   { p->LTag=Thread; 
     p->lchild=pre; 
   }
   pre=p; 
   if(p->LTag==Link) 
     PreThreading(p->lchild); 
   if(p->RTag==Link) 
     PreThreading(p->rchild); 
 }

 void PreOrderThreading(BiThrTree &Thrt,BiThrTree T)
 { 
   if(!(Thrt=(BiThrTree)malloc(sizeof(BiThrNode)))) 
     exit(OVERFLOW);
   Thrt->LTag=Link; 
   Thrt->RTag=Thread; 
   Thrt->rchild=Thrt; 
   if(!T) 
     Thrt->lchild=Thrt; 
   else 
   { Thrt->lchild=T; 
     pre=Thrt; 
     PreThreading(T); 
     pre->RTag=Thread; 
     pre->rchild=Thrt; 
     Thrt->rchild=pre; 
   }
 }

 void PreOrderTraverse_Thr(BiThrTree T,void(*Visit)(TElemType))
 { 
   BiThrTree p=T->lchild; 
   while(p!=T) 
   { Visit(p->data); 
     if(p->LTag==Link) 
       p=p->lchild; 
     else 
       p=p->rchild; 
   }
 }

 void PostThreading(BiThrTree p)
 { 
   if(p) 
   { PostThreading(p->lchild); 
     PostThreading(p->rchild); 
     if(!p->lchild) 
     { p->LTag=Thread; 
       p->lchild=pre; 
     }
     if(!pre->rchild) 
     { pre->RTag=Thread; 
       pre->rchild=p; 
     }
     pre=p; 
   }
 }

 void PostOrderThreading(BiThrTree &Thrt,BiThrTree T)
 { 
   if(!(Thrt=(BiThrTree)malloc(sizeof(BiThrNode)))) 
     exit(OVERFLOW);
   Thrt->LTag=Link; 
   Thrt->RTag=Thread; 
   if(!T) 
     Thrt->lchild=Thrt->rchild=Thrt; 
   else 
   { Thrt->lchild=Thrt->rchild=T; 
     pre=Thrt; 
     PostThreading(T); 
     if(pre->RTag!=Link) 
     { pre->RTag=Thread; 
       pre->rchild=Thrt; 
     }
   }
 }

 void DestroyBiTree(BiThrTree &T)
 { 
   if(T) 
   { if(T->LTag==0) 
       DestroyBiTree(T->lchild); 
     if(T->RTag==0) 
       DestroyBiTree(T->rchild); 
     free(T); 
     T=NULL; 
   }
 }

 void DestroyBiThrTree(BiThrTree &Thrt)
 { 
   if(Thrt) 
   { if(Thrt->lchild) 
       DestroyBiTree(Thrt->lchild); 
     free(Thrt); 
     Thrt=NULL; 
   }
 }

