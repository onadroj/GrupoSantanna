#include "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BCOFORN   � Autor �                    � Data �  16/11/00   ���
�������������������������������������������������������������������������͹��
���Descricao � INFOR. O BANCO DO FORNECEDOR QUANDO O MODELO DO FOR DOC    ���
���          � PARA CNAB A PAGAR - BRADESCO                               ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/                      

User Function BCOFORN

Local Banco

Banco := iif(SEA->EA_MODELO="03",strzero(val(SA2->A2_BANCO),3),;//03 DOC (DOCUMENTO DE CR�DITO)
         iif(SEA->EA_MODELO="08",strzero(val(SA2->A2_BANCO),3),;//08 TED STR
         iif(SEA->EA_MODELO="31",substr(SE2->E2_CODBAR,1,3),"237")))//T�TULOS DE TERCEIROS

RETURN(Banco)
