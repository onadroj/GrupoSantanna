#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VALPROD   � Autor � GATASSE            � Data �  12/01/04   ���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA PRODUTO.                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP5 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function VALPROD


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
LOCAL AREA,CCOD,CCAMPO,_RET
//Local cCtbDes, cCtbCus, cCtbInd
Local _aDados := {}
_RET:=.T.
AREA:=GETAREA()
CCAMPO:=__READVAR

/*	MSGSTOP("C�digo do Produto "+&CCAMPO+" - "+cCtbDes+" - "+cCtbCus+" - "+cCtbInd)
IF POSICIONE("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_CTBADES") == "" .OR. POSICIONE("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_CTBACUS") == ""  .OR. POSICIONE("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_CTBACI") == ""
	cCtbDes := RETFIELD("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_CTBADES")
	cCtbCus := RETFIELD("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_CTBACUS")
	cCtbInd := RETFIELD("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_CTBACI")
	aAdd(_aDados,cCtbDes)
	aAdd(_aDados,"Pagamento")
	aAdd(_aDados,cCtbCus)
	aAdd(_aDados,cCtbInd)
	MEnviaMail("_CC",_aDados,,,,.T.)	 
	MSGSTOP("C�digo do Produto "+&CCAMPO+" - "+cCtbDes+" - "+cCtbCus+" - "+cCtbInd)

B1_CTBADES
B1_CTBACUS
B1_CTBACI

ENDIF    
*/
IF ALLTRIM(&CCAMPO)=""
	MSGSTOP("C�digo do Produto � Obrigat�rio!")
	//_RET:=.F.
ELSE
	IF POSICIONE("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_SITPROD") == "OB"
//		IF MSGBOX(ALLTRIM(&CCAMPO)+"-"+POSICIONE("SB1",1,XFILIAL("SB1")+&CCAMPO,"B1_DESC")+CHR(10)+CHR(13)+"Produto se encontra em situacao de OBSOLETO!. Deseja usar assim mesmo?","Confirmacao","YESNO")
//			_RET:=.T.
//		ELSE
        	MSGSTOP("Produto n�o habilitado para uso!")
			_RET:=.F.
//		ENDIF
	ENDIF
ENDIF
RESTAREA(AREA)
Return(_RET)
