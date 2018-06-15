#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VALCEI    � Autor � EDSON              � Data �  04/06/07   ���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA CEI NO CADASTRO DE CENTROS DE CUSTOS                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP 7.09                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function VALCEI()
LOCAL _RET:=.T.
LOCAL _BASE:="74185216374"
LOCAL _SOMA:= 0
LOCAL _CEI:=RIGHT(ALLTRIM(M->CTT_CEI),12)

IF LEN(ALLTRIM(M->CTT_CEI))<>14
   MSGSTOP("Tamanho do CEI inv�lido! Deve ser utilizado o CEI acrescido de dois zeros a esquerda.")
   _RET:=.F.
ELSE
   FOR i:= 1 to 11
       _SOMA:=_SOMA + val(substr(_BASE,i,1)) * val(substr(_CEI,i,1))
   NEXT
   _Val1:=right(str(_SOMA),2)
   _Val2:=val(left(_Val1,1)) + val(right(_Val1,1))
   _Val2:=10 - val(right(str(_Val2),1))
   IF _Val2 > 9
      _Val2:=0
   ENDIF   
   IF ALLTRIM(right(_CEI,1))<>ALLTRIM(str(_Val2))
      MSGSTOP("CEI invalido!")
      _RET:=.F.
   ENDIF
ENDIF

Return(_RET)
