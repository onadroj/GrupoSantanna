#INCLUDE "rwmake.ch"
#INCLUDE "Topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Valf1doc  �GATASSE� AP6 IDE            � Data �  11/01/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Valida��o se a nota j� havia sido entrada com 6 d�gitos.   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function Valf1doc


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local lRet:=.t.
Local cNum                          
Local aArea:=GetArea()
Local cMsg:=""        
Local cDoc:=""
Local cFrn:=""
Local cLj:=""

if __READVAR=="cNFiscal"
	cDoc:=&(__READVAR)	
else      
	cDoc:=cNFiscal
EndIf
if __READVAR=="cA100For"
	cFrn:=&(__READVAR)	
else      
	cFrn:=cA100For
EndIf
if __READVAR=="cLoja"
	cLj:=&(__READVAR)	
else      
	cLj:=cLoja
EndIf
if !empty(cDoc) .and. !empty(cFrn) .and. !empty(cLj) .and. !(cTipo$"DB")
	cNum:=strzero(val(cNFiscal),9)+"   "
	cMsg:=BscNota(cNum,cFrn,cLj)
	if !empty(cMsg)
		if MsgYesNo(cMsg+chr(10)+chr(13)+"Verifique ! "+chr(10)+chr(13)+"Deseja continuar ?")
			lRet:=.t.
		else
			lRet:=.f.
		EndIf                                                                        	
	EndIf
EndIf                 
restarea(aArea)
Return(lRet)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BscNota   �Autor  �Microsiga           � Data �  01/11/10   ���
�������������������������������������������������������������������������͹��
���Desc.     � Verifica se a nota passada como par�metro j� existe na     ���
���          � base de dados e retorna a mensagem. N�o testa a s�rie.     ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
s*/

Static Function BscNota(cDoc,cFornece,cLoja)
Local cRet:=""
LOCAL AAREA:=GETAREA()
Local cQuery :="SELECT F1_DOC, F1_EMISSAO, F1_VALBRUT, F1_SERIE "
cQuery += " FROM "+RETSQLNAME("SF1")+" SF1 "
cQuery += " WHERE "
cQuery += "   F1_FILIAL='"+XFILIAL("SF1")+"' "
cQuery += "   AND SF1.D_E_L_E_T_ <>'*' "
cQuery += "   AND F1_DOC='"+cDoc+"' "	
cQuery += "   AND F1_FORNECE='"+cFornece+"' "	
cQuery += "   AND F1_LOJA='"+cLoja+"' "	
TCQUERY cQuery NEW ALIAS "QRY"   
TCSETFIELD("QRY","F1_EMISSAO","D",8,0)
dbSelectArea("QRY")
DBGOTOP()
if !EOF()
	cRet:="Nota com mesmo n�mero, por�m com 9 d�gitos, lan�ada com a S�rie '"+QRY->F1_SERIE+"', emiss�o em "+dtoc(QRY->F1_EMISSAO)+" e valor bruto de R$"+transform (QRY->F1_VALBRUT,"@E 999,999,999.99") +"!"
EndIf
CLOSE
RETURN(cRet)

