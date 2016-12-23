 // func5-3.cpp广义表的书写形式串为SString类型，包括算法5.8。bo5-5.cpp和bo5-6.cpp调用
 #include"c4-1.h" 
 #include"bo4-1.cpp" 
 void sever(SString str,SString hstr) 
 { 
   int n,k=0,i=0; 
   SString ch,c1,c2,c3;
   StrAssign(c1,","); 
   StrAssign(c2,"("); 
   StrAssign(c3,")"); 
   n=StrLength(str); 
   do 
   { ++i;
     SubString(ch,str,i,1); 
     if(!StrCompare(ch,c2)) 
       ++k; 
     else if(!StrCompare(ch,c3)) 
       --k; 
   }while(i<n&&StrCompare(ch,c1)||k!=0); 
   if(i<n) 
   { SubString(hstr,str,1,i-1); 
     SubString(str,str,i+1,n-i); 
   }
   else 
   { StrCopy(hstr,str); 
     ClearString(str); 
   }
 }

