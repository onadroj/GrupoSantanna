#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO8     � Autor � AP6 IDE            � Data �  18/05/16   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CNAB033(cTipo)

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cConvenio := ""
Local cConta := ""
Local cRet :=""




IF cEmpAnt = "03"
	cConvenio := "00332085008301605671"
	cConta := "0000130007426"
endif
IF cEmpAnt = "04"
	cConvenio := "00332085008301605711"
	cConta := "0000130007419"
endif
IF cEmpAnt = "08"
	cConvenio := "00332085008301605728"
	cConta := "0000130007402"
endif

IF UPPER(cTipo) == "CC"
	cRet := cConta
elseif UPPER(cTipo) == "SEQ"
	cRet := getmv("MV_XSEQREM") 
	cRet :=cRet+1 
	PutMv("MV_XSEQREM", cRet) 
ELSE
	cRet := cConvenio
endif

Return cRet
