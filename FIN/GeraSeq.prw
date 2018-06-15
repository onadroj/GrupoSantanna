#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GERASEQ   �Autor  �GATASSE             � Data �  03/20/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �GERA NUMERO DE DOCUMENTO SEQUENCIAL AUTOMATICAMENTE         ���
���          �PARA ALGUNS TIPOS DE DOCUMENTOS DO FINANCEIRO               ���
�������������������������������������������������������������������������͹��
���Uso       � AP6                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function GeraSeq()


cChav := "GRN"
cCampo:=__READVAR

if cCampo=="M->E1_TIPO"
	cTipo:=M->E1_TIPO
else
	cTipo:=M->E2_TIPO
endif
if alltrim(cTipo) $ "GR/GRN/RC/FER/RES/FOL/PR/RPA/ADI/TX/DEV/FV/AMC/TXC/PRC/"
	_area:=getarea()
	dbSelectArea("SX5")
	dbSetOrder(1)
	IF dbSeek(xFilial("SX5")+"96"+cChav)
		Seq:=AllTrim(Str(val(SX5->X5_DESCRI) + 1))
//		Seq:=subst("000000",1,6-len(Seq))+Seq
		Seq:=subst("000000000",1,12-len(Seq))+Seq
		RecLock("SX5",.F.)
	ELSE
		RecLock("SX5",.T.)
		replace X5_TABELA WITH "96"
		replace X5_CHAVE WITH "GRN"
//		Seq:="000001"
		Seq:="000000000001"
	ENDIF
	replace X5_DESCRI with Seq
	MSUnlock()
	restarea(_area)
ENDIF
Return(Seq)
