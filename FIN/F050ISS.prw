#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F050ISS   � Autor � AP6 IDE            � Data �  11/12/09   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada para gravar dados adicionais              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F050ISS


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local aArea:=GetArea()
Local cE2CCUNID
Local cE2CUSTO
Local cE2HIST
Local cE2COMPETE
Local recaux:=SE2->(RECNO())
DBGOTO(PARAMIXB)  //RECNO DO DOCUMENTO PRINCIPAL
cE2CCUNID := SE2->E2_CCUNID
cE2CUSTO  := SE2->E2_CUSTO
cE2HIST := SE2->E2_HIST
cE2COMPETE := SE2->E2_COMPETE
DBGOTO(recaux)
RecLock("SE2",.F.)
SE2->E2_CCUNID := cE2CCUNID
SE2->E2_CUSTO  := cE2CUSTO
SE2->E2_COMPETE  := cE2COMPETE
SE2->E2_HIST   := cE2HIST
SE2->E2_FLUXO  := "S"
MSUnlock()


restarea(aArea)
Return
