#include "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VALRPGTO  � Autor � GATASSE            � Data �  06/10/03   ���
�������������������������������������������������������������������������͹��
���Descricao � RETORNAR O VALOR A SER PAGO DE CADA TITULO.                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function VALRPGTO

Local nValrPgto,nValrAbat
nValrAbat:=SOMAABAT(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,"P",1,SE2->E2_VENCREA,SE2->E2_FORNECE,SE2->E2_LOJA)    
/*
if (SEA->EA_MODELO=="31" .and. val(substr(SE2->E2_CODBAR,10,10))>0 .and. nValrAbat == 0)
	nValrPgto := StrZero(val(substr(SE2->E2_CODBAR,10,10)),15)

else     
*/
	nValrPgto := Strzero((SE2->E2_SALDO - nValrAbat + SE2->E2_JUROS + SE2->E2_ACRESC - SE2->E2_DECRESC)*100,15)

//?endif
//nValorTotal := nValorTotal + val(nValrPgto)/100
RETURN(nValrPgto)


