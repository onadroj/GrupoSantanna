#INCLUDE 'PROTHEUS.CH'
#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GP650CPO   � Autor � AP6 IDE           � Data �  30/06/14   ���
�������������������������������������������������������������������������͹��
���Descricao � 															  ���
���Essa implementa��o permite atualizar informa��es dos campos da tabela  ���
���RC1 - Movimenta��es de T�tulos.										  ���
���Na rotina GPEM650 (Gera Movimenta��o de T�tulos no arquivo RC1).		  ���
���                                                                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function GP650CPO()
	Local cCompet      := mv_par12
	Local cFornecFunc :=""
	Local cLojaFunc :=""
	Local aArea  := GetArea()
	
	RC1->RC1_XCOMPE  := cCompet
	if mv_par14 == 1                                              
		
		cCpf := fAcha("SRA",XFILIAL("SRA")+RC1->RC1_MAT,1,"RA_CIC")
		cFornecFunc := POSICIONE("SA2", 3, xFilial("RC1") + cCpf, "A2_COD")
		cLojaFunc := POSICIONE("SA2", 3, xFilial("RC1") + cCpf, "A2_LOJA")
		IF EMPTY(cFornecFunc)
			ALERT("Cadastrar o Funcionario "+ fAcha("SRA",XFILIAL("SRA")+RC1->RC1_MAT,1,"RA_NOME") +" Como Fornecedor!")		
		ENDIF
		RC1->RC1_FORNEC := cFornecFunc
		RC1->RC1_LOJA := cLojaFunc
	endif
	
	RestArea(aArea)
Return()
