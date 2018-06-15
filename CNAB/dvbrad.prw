#include "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DVBRAD    � Autor � EDSON PEREIRA      � Data �  13/08/03   ���
�������������������������������������������������������������������������͹��
���Descricao � CALC. DV AGENCIA E CONTA PARA MODALIDADE 31 -PAGTO. BOLETO ���
���          � BRADESCO DE TERCEIROS VIA CNAB                             ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function DVBRAD

Local cFixo,cFonte,nSoma,cDv,nTam

if ParamIXB = "A"
  cFixo  := "5432"
  cFonte := Substr(SE2->E2_CODBAR,20,4) //Agencia
  nTam   := 4
elseIF ParamIXB = "C"
  cFixo  := "765432"
  cFonte := Substr(SE2->E2_CODBAR,38,6) //Conta Corrente
  nTam   := 6
elseIF ParamIXB = "2"
  cFixo  := "765432"
  cFonte := Substr(SEE->EE_CONTAUX,-6) //Conta Corrente SEE
  nTam   := 6
elseIF ParamIXB = "1"
  cFixo  := "5432"
  cFonte := Substr(SEE->EE_AGCAUX,-4) //Agencia SEE
  nTam   := 4
endif

// Calcula o DV
nSoma := 0
For nI := 1 to nTam             
	nSoma := nSoma + ;
	(Val(Substr(cFonte,nI,1))*Val(Substr(cFixo,nI,1)))
Next
If (11-(nSoma%11)) > 9
	cDv := "0"
Else
	cDv := Alltrim(Str(11-(nSoma%11),1))
Endif
RETURN(cDv)
