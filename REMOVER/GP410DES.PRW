#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GP410DES    � Autor � EDSON            � Data �  31/01/12   ���
�������������������������������������������������������������������������͹��
���Descricao � PARA REMESSA DE RESCIS�ES FILTRA APENAS RESCIS�ES MARCADAS ���
���          � PARA REMESSA VIA CNAB                                      ���
�������������������������������������������������������������������������͹��
���Uso       � GPE e FINANCEIRO                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function GP410DES
LOCAL _return := .T.
LOCAL _aArea := GetArea()               
LOCAL _cCNAB := ""

If MV_PAR28==1
	DbSelectArea("SRG")
	DbOrderNickName("RGHOM")
	DbSeek(SRA->RA_FILIAL+SRA->RA_MAT+DTOS(MV_PAR24))
    If !Eof()
       _cCNAB := SRG->RG_CNAB
    Endif
//	MsgStop("Funcion�rio corrente: "+SRA->RA_MAT+" Matricula: "+SRA->RA_NOME+" Gera CNAB = "+_cCNAB)
	If _cCNAB<>"S"
	   _return := .F.
	Endif
Endif

RestArea(_aArea)
Return(_return)