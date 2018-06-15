#INCLUDE "rwmake.ch"
#include "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F240BORD  � Autor � GATASSE            � Data �  10/03/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de Entrada ap�s a grava��o do border� a pagar        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F240BORD
Local _aDados := {}
Local aArea:=GetArea()
Local nSld:=0
Local cQuery:=""
cQuery:=" SELECT SUM(E2_SALDO +E2_ACRESC - E2_DECRESC) AS SLD "
cQuery+=" FROM "+RetSQLName("SEA") +" SEA, "+RetSQLName("SE2") +" SE2 "
cQuery+=" WHERE "
cQuery+=" SEA.D_E_L_E_T_<>'*' AND "
cQuery+=" SE2.D_E_L_E_T_<>'*' AND "
cQuery+=" SEA.EA_LOJA    =  SE2.E2_LOJA AND "
cQuery+=" SEA.EA_FORNECE =  SE2.E2_FORNECE  AND "
cQuery+=" SEA.EA_TIPO    =  SE2.E2_TIPO AND "
cQuery+=" SEA.EA_PARCELA =  SE2.E2_PARCELA AND "
cQuery+=" SEA.EA_NUM     =  SE2.E2_NUM AND "
cQuery+=" SEA.EA_PREFIXO =  SE2.E2_PREFIXO  AND "
cQuery+=" SEA.EA_FILIAL  =  SE2.E2_FILIAL AND "
cQuery+=" SEA.EA_CART    = 'P' AND "
cQuery+=" SEA.EA_NUMBOR  ='"+cNumBor+"' "
TCQUERY cQuery ALIAS QRY NEW
dbSelectArea("QRY")
DbGoTop()
if !eof()
	nSld:=QRY->SLD
	MsgStop("Border� ser� gerado para libera��o!")
else
	MsgStop("Erro no sistema, o border� n�o ser� gerado para libera��o."+chr(13)+chr(10)+"Contate o Setor de TI!")
endif
CLOSE
dbSelectArea("SZJ")
RecLock("SZJ",.T.)
replace ZJ_FILIAL with xFilial("SZJ")
replace ZJ_BORDERO with cNumBor
replace ZJ_TIPO with "P"
replace ZJ_LIBERAD with "N"
replace ZJ_VALOR with nSld
MSUnlock()
restarea(aArea) 

If cEmpAnt=="03" .OR. cEmpAnt=="04" .OR. cEmpAnt=="08" .OR. cEmpAnt=="99"
	aAdd(_aDados,cNumBor)
	aAdd(_aDados,"Pagamento")
	aAdd(_aDados,AllTrim(Transform(nSld,"@E 999,999,999.99")))
	aAdd(_aDados,cUserName)
	MEnviaMail("_GB",_aDados,,,,.T.)
EndIf


Return
