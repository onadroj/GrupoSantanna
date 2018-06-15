#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA280     � Autor � GATASSE            � Data �  30/05/03   ���
�������������������������������������������������������������������������͹��
���Descricao � GRAVA DADOS COMPLEMENTARES EM SE1                          ���
���          �          APOS AS FATURAS A RECEBER                         ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function FA280
AAREA:=GETAREA()
dbSelectArea("SX5")
dbSetOrder(1)
dbSeek(xFilial("SX5")+"96SE1")
Seq :=AllTrim(Str(val(SX5->X5_DESCRI) + 1))
Seq :=subst("00000000",1,8-len(Seq))+Seq
RecLock("SX5",Eof())
replace X5_DESCRI with Seq
MSUnlock()

RecLock("SE1",.f.)
Replace  SE1->E1_CUSTO With  _CUSTO
Replace  SE1->E1_CCUNID With  _CCUNID
Replace  SE1->E1_COMPETE With  _COMPETE
Replace  SE1->E1_HIST With  _HIST
Replace  SE1->E1_FLUXO With  "S"
Replace  SE1->E1_ALUGUEL With  "N"
Replace  SE1->E1_ORIG With  "R"
Replace  SE1->E1_SEQ With  Seq
MsUnlock()
RESTAREA(AAREA)
Return
