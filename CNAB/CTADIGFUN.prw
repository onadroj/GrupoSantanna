#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTADIGFUN�  Autor � EDSON              � Data �  18/04/08   ���
�������������������������������������������������������������������������͹��
���Descricao � PREPARA DADOS DA CONTA E DIGITO DO FUNCIONARIO-REMESSA DE  ���
���          � LIQUIDO DE FOLHA PARA O BRADESCO                           ���
�������������������������������������������������������������������������͹��
���Uso       � MP8                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CTADIGFUN
LOCAL cRET,cCONTA
cRET=""
cCONTA:=""
cCONTA:=ALLTRIM(SRA->RA_CTDEPSA)
IF paramixb == "033"
//	alert(paramixb)
	RET:=STRZERO(VAL(SUBSTR(CCONTA,1,LEN(cCONTA)-1)),12)+SUBSTR(cCONTA,LEN(cCONTA),1)
ELSE
	RET:=STRZERO(VAL(SUBSTR(CCONTA,1,LEN(cCONTA)-1)),7)+SUBSTR(cCONTA,LEN(cCONTA),1)
ENDIF

Return(ALLTRIM(RET))
