#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �inibwstf  � Autor � GATASSE            � Data �  26/04/04   ���
�������������������������������������������������������������������������͹��
���Descricao � inicializador de browse para ft_diasman                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function inibwstf


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local nRet
Local aArea:=GETAREA()
Local aAreaST9
nRet:=0
DBSELECTAREA("ST9")
aAreaST9:=GetArea()
DBSETORDER(1)
IF DBSEEK(XFILIAL("ST9")+STF->TF_CODBEM)
	D:=DDATABASE-STF->TF_DTULTMA         //DIAS DESDE A ULTIMA MANUTENCAO
	P:=STF->TF_CONMANU+STF->TF_INENMAN   //PROXIMA MANUTENCAO=CONTADORATUAL+INCREMENTO
	F:=P-ST9->T9_CONTACU                 //ODOMETRO RESTANTE
	IF F>=0
		nRet:="NORMAL("+ALLTRIM(STR(F))+")"           //DIAS RESTANTE
	ELSE
		nRet:="ATRASO("+ALLTRIM(STR(F))+")"           //DIAS RESTANTE
	ENDIF
ENDIF   
RESTAREA(aAreaST9)
RESTAREA(aArea)
Return(nRet)
