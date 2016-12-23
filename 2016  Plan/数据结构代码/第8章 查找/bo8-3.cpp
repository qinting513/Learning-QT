 // bo8-3.cpp 平衡二叉树的基本操作，包括算法9.9～9.12
 void R_Rotate(BSTree &p)
 { 
   
   BSTree lc;
   lc=p->lchild; 
   p->lchild=lc->rchild; 
   lc->rchild=p; 
   p=lc; 
 }

 void L_Rotate(BSTree &p)
 { 
   
   BSTree rc;
   rc=p->rchild; 
   p->rchild=rc->lchild; 
   rc->lchild=p; 
   p=rc; 
 }

 void LR_Rotate(BSTree &p)
 { 
   BSTree lc=p->lchild; 
   p->lchild=lc->rchild->rchild; 
   lc->rchild->rchild=p; 
   p=lc->rchild; 
   lc->rchild=p->lchild; 
   p->lchild=lc; 
 }

 void RL_Rotate(BSTree &p)
 { 
   BSTree rc=p->rchild; 
   p->rchild=rc->lchild->lchild; 
   rc->lchild->lchild=p; 
   p=rc->lchild; 
   rc->lchild=p->rchild; 
   p->rchild=rc; 
 }

 #define LH +1 
 #define EH  0 
 #define RH -1 

 void LeftBalance(BSTree &T) 
 { 
   
   
   
   BSTree lc,rd;
   lc=T->lchild; 
   switch(lc->bf) 
   { case LH: 
             
             T->bf=lc->bf=EH; 
             R_Rotate(T); 
             break;
     case RH: 
             
             rd=lc->rchild; 
             switch(rd->bf) 
             { case LH: 
                       T->bf=RH; 
                       lc->bf=EH; 
                       break;
               case EH: 
                       T->bf=lc->bf=EH; 
                       break;
               case RH: 
                       T->bf=EH; 
                       lc->bf=LH; 
             }
             rd->bf=EH; 
 #ifndef FLAG 
             L_Rotate(T->lchild);
             
             R_Rotate(T); 
 #else 
             LR_Rotate(T); 
 #endif
   }
 }

 void RightBalance(BSTree &T)
 { 
   
   
   
   BSTree rc,ld;
   rc=T->rchild; 
   switch(rc->bf) 
   { case RH: 
             
             T->bf=rc->bf=EH; 
             L_Rotate(T); 
             break;
     case LH: 
             
             ld=rc->lchild; 
             switch(ld->bf) 
             { case RH: 
                       T->bf=LH; 
                       rc->bf=EH; 
                       break;
               case EH: 
                       T->bf=rc->bf=EH; 
                       break;
               case LH: 
                       T->bf=EH; 
                       rc->bf=RH; 
             }
             ld->bf=EH; 
 #ifndef FLAG 
             R_Rotate(T->rchild);
             
             L_Rotate(T); 
 #else 
             RL_Rotate(T); 
 #endif
   }
 }

 Status InsertAVL(BSTree &T,ElemType e,Boolean &taller)
 { 
   
   
   if(!T) 
   { 
     T=(BSTree)malloc(sizeof(BSTNode)); 
     T->data=e; 
     T->lchild=T->rchild=NULL; 
     T->bf=EH; 
     taller=TRUE; 
   }
   else 
   { if EQ(e.key,T->data.key) 
     { 
       return FALSE; 
     }
     if LT(e.key,T->data.key) 
     { if(!InsertAVL(T->lchild,e,taller)) 
         return FALSE; 
       if(taller) 
         switch(T->bf) 
         { case LH: 
                   LeftBalance(T); 
                   taller=FALSE; 
                   break;
           case EH: 
                   T->bf=LH; 
                   taller=TRUE; 
                   break;
           case RH:T->bf=EH; 
                   taller=FALSE; 
         }
     }
     else 
     { if(!InsertAVL(T->rchild,e,taller)) 
         return FALSE; 
       if(taller) 
         switch(T->bf) 
         { case LH:T->bf=EH; 
                   taller=FALSE; 
                   break;
           case EH: 
                   T->bf=RH; 
                   taller=TRUE; 
                   break;
           case RH: 
                   RightBalance(T); 
                   taller=FALSE; 
         }
     }
   }
   return TRUE;
 }

