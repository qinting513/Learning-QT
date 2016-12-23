 // func7-4.cpp 包括弧(边)的相关信息类型的定义及对它的操作
 typedef int VRType; 
 struct InfoType 
 { VRType weight; 
 };

 void InputArc(InfoType* &arc) 
 { arc=(InfoType*)malloc(sizeof(InfoType)); 
   scanf("%d",&arc->weight);
 }

 void OutputArc(InfoType* arc) 
 { printf("：%d",arc->weight);
 }

 void InputArcFromFile(FILE* f,InfoType* &arc) 
 { arc=(InfoType*)malloc(sizeof(InfoType)); 
   fscanf(f,"%d",&arc->weight);
 }

