#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �UMNTA401  � Autor � EDSON              � Data �  28/03/05   ���
�������������������������������������������������������������������������͹��
���Descricao � GRAVA DATA REAL DE APLICACAO DE INSUMOS NAS OS DE          ���
���          � ABASTECIMENTO                                              ���
�������������������������������������������������������������������������͹��
���Modulo    � MANUTENCAO DE ATIVOS                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function UMNTA401
MNTA401()
cQuery:="UPDATE "+RETSQLNAME("STL")+" SET TL_DTDIGIT = TL_DTINICI "
cQuery+="WHERE TL_DTDIGIT='' AND D_E_L_E_T_<>'*' "
nret:=TCSQLExec(cQuery)
IF nret<> 0
	msgstop("Ocorreu um erro com codigo "+str(nret)+" na atualizacao de STL. ")
endif
Return
