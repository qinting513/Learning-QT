 // func7-7.cpp 包括弧的相关信息类型的定义及对它的操作
 typedef int VRType; 
 struct InfoType 
 { VRType weight; 
   int ee,el; 
 };

 void InputArc(InfoType* &arc) 
 { arc=(InfoType*)malloc(sizeof(InfoType)); 
   scanf("%d",&arc->weight); 
 }

 void OutputArc(InfoType* arc) 
 { printf("：%d",arc->weight);
 }

 void OutputArcwel(InfoType* arc) 
 { printf(" %3d %3d %3d ",arc->weight,arc->ee,arc->el); 
 }

 void InputArcFromFile(FILE* f,InfoType* &arc) 
 { arc=(InfoType*)malloc(sizeof(InfoType)); 
   fscanf(f,"%d",&arc->weight);
 }

