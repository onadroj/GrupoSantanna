#include "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VALRDOC   � Autor �                    � Data �  16/11/00   ���
�������������������������������������������������������������������������͹��
���Descricao � INFOR. O VALOR DO DOCUMENTO PARA TIPO DE PGTO 31 BUSCADO   ���
���          � DO CODIGO DE BARRAS OU VALOR DO TITULO QDO. TPPGTO <> 31.  ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function VALRDOC

Local nValr

nValr := iif(SEA->EA_MODELO="31" .and. val(substr(SE2->E2_CODBAR,10,10))>0, ;
             substr(SE2->E2_CODBAR,10,10),strzero(SE2->E2_SALDO*100,10))
/*if ((SEA->EA_MODELO=="31") .and. val(substr(SE2->E2_CODBAR,10,10))>0)
	nValr := substr(SE2->E2_CODBAR,10,10)
else
	nValr := REPLICATE("0",10)
endif
*/
RETURN(nValr)
