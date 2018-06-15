#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VALC5CTT  � Autor � GATASSE            � Data �  04/07/03   ���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA C5_CONTRAT. VERIFICA SE � DO CLIENTE E ABERTO.      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function VALC5CTT
LOCAL RET
AAREA:=GETAREA()
RET:=.T.
IF ALLTRIM(M->C5_CONTRAT)<>""
	DBSELECTAREA("SZL")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL("SZL")+M->C5_CONTRAT)
		IF M->C5_CLIENTE+M->C5_LOJACLI<>SZL->ZL_CLIENTE+SZL->ZL_LOJA
			MSGSTOP("Contrato informado nao pertence a este cliente!")
			RET:=.F.
		ENDIF
	ELSE
		MSGSTOP("Registro nao localizado!")
		RET:=.F.
	ENDIF
ENDIF
RESTAREA(AAREA)
Return(RET)
