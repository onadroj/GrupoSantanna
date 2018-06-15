#include "rwmake.ch"        

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    �UCCSUP  � Autor � EDSON                   � Data � 21.08.07 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Retorna Centro de custo superior                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       �Gatilho no preenchimento do campo CTT_CUSTO                 ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function UCCSUP()        

Private Cparam, CClasse

Cretorno :=""
Cparam:=paramIXB

if Len(Alltrim(Cparam))>4
   Cretorno:=Substr(Cparam,1,4)
else
   if Len(Alltrim(Cparam))=4 
      Cretorno:=Substr(Cparam,1,3)
   else
     if Len(Alltrim(Cparam))=3 
        Cretorno:=Substr(Cparam,1,1)
     endif
   endif
endif

if Cretorno<>""
   CClasse:=Retfield("CTT",1,xFilial("CTT")+Cretorno,"CTT_CLASSE")
   if CClasse == "2"
      MsgBox("Centro de Custo superior deve ser sint�tico!","UCCSUP","ALERT")
   else
     if Alltrim(CClasse) == ""
        MsgBox("Centro de Custo superior ainda n�o foi cadastrado!","UCCSUP","ALERT")
     endif 
   endif
endif



Return( Cretorno )        

