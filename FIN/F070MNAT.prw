#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F070MNAT  � Autor � AP6 IDE            � Data �  03/07/14   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F070MNAT 

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local aArea := GetArea()
Local lRet := .F.
Local lMNat      
Local cQuery
Local nTotReg
lMNat := RetField("SE1", 1, xFilial("SE1")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO, "E1_MULTNAT")
       
if lMNat == "1"
	cQuery := "SELECT * FROM "+RETSQLNAME("SEZ")+"  WHERE EZ_NUM = '"+SE1->E1_NUM+"' AND"
	cQuery +=" EZ_PREFIXO = '"+SE1->E1_PREFIXO+"' AND"
	cQuery +=" EZ_PARCELA = '"+SE1->E1_PARCELA+"' AND"
	cQuery +=" EZ_TIPO ='"+SE1->E1_TIPO+"' AND "
	cQuery +=" EZ_CLIFOR = '"+SE1->E1_CLIENTE+"' AND EZ_LOJA = '"+SE1->E1_LOJA+"' AND D_E_L_E_T_ <> '*' "  
	
	TCQUERY cQuery NEW ALIAS "QRY"
	dbSelectArea("QRY")
	nTotReg := Contar("QRY","!Eof()")
	QRY->(DbGoTop())
	if nTotReg > 0
		MsgBox("O titulo deve ser baixado com multiplas naturezas!", "F070MNAT", "Alert")
		lRet := .T.     
	else
		MsgBox("Titulo com multiplas naturezas mas nao houve rateio na inclusao do titulo!", "F070MNAT", "Alert")
		lRet := .F.     
	endif         
	QRY->(DbCloseArea())
	RestArea(aArea)
endif	
Return lRet
