#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA290     � Autor � GATASSE            � Data �  16/06/03   ���
�������������������������������������������������������������������������͹��
���Descricao � GRAVA DADOS COMPLEMENTARES EM SE2                          ���
���          �          APOS AS FATURAS A PAGAR                           ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function FA290
AAREA:=GETAREA()
dbSelectArea("SX5")
dbSetOrder(1)
dbSeek(xFilial("SX5")+"96SE2")
Seq :=AllTrim(Str(val(SX5->X5_DESCRI) + 1))
Seq :=subst("00000000",1,8-len(Seq))+Seq
RecLock("SX5",Eof())
replace X5_DESCRI with Seq
MSUnlock()

RecLock("SE2",.f.)
Replace  SE2->E2_CUSTO With  f290cc
Replace  SE2->E2_CCUNID With  f290ccunid
Replace  SE2->E2_COMPETE With  f290COMPETE
Replace  SE2->E2_HIST With  f290HIST
Replace  SE2->E2_FLUXO With  "S"
Replace  SE2->E2_ORIG With  "R"
Replace  SE2->E2_SEQ With  Seq
MsUnlock()
RESTAREA(AAREA)
Return
