#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F290CAN   � Autor � GATASSE            � Data �  11/12/02   ���
�������������������������������������������������������������������������͹��
���Descricao � CANCELAMENTO DE FATURA A PAGAR                             ���
���          � PREPARA VARIAVEL PARA A CONTABILIZACAO                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP5 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F290CAN

PUBLIC _FCANCHIST    ,_FCANVALOR    ,f290cc
//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
//VIDE CA100CHK
IF !(SE2->E2_NUM==CFATCAN .AND. SE2->E2_PREFIXO==CPREFCAN)
	IF TYPE("_FCANCHIST")=="U"
		_FCANCHIST:=SE2->E2_NUM+"/"+SE2->E2_PARCELA+","
	ELSE
		_FCANCHIST:=_FCANCHIST+SE2->E2_NUM+"/"+SE2->E2_PARCELA+","
	ENDIF
	IF TYPE("_FCANVALOR")=="U"
		_FCANVALOR:=SE2->E2_VALOR
	ELSE
		_FCANVALOR:=_FCANVALOR+SE2->E2_VALOR
	ENDIF                                   
	f290cc:=SE2->E2_CCUNID
ENDIF
Return