#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �OSABERTA  � Autor � GATASSE            � Data �  21/02/05   ���
�������������������������������������������������������������������������͹��
���Descricao � USADO NO BROWSE DA OS MANUAL PARA MOSTRAR A OS QUE         ���
���          � ESTA EM ABERTO                                             ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function OSABERTA
Local aArea:=GETAREA()
LOCAL cOS:=" "
Local aAreaSTJ                        
IF Alltrim(FUNNAME())=="UMNTA410"
	dbSelectArea("STJ")
	aAreaSTJ:=GetArea()
	dbSetOrder(2)    
	DBSEEK(XFILIAL("STJ")+"B"+STF->TF_CODBEM+STF->TF_SERVICO+STF->TF_SEQRELA,.T.)
	WHILE !EOF() .AND. XFILIAL("STJ")+"B"+STF->TF_CODBEM+STF->TF_SERVICO+STF->TF_SEQRELA==STJ->TJ_FILIAL+"B"+STJ->TJ_CODBEM+STJ->TJ_SERVICO+STJ->TJ_SEQRELA
		IF STJ->TJ_TERMINO=="N" .AND. STJ->TJ_SITUACA<>"C"
			cOs+=STJ->TJ_ORDEM+"/"
		ENDIF
		dbskip()
	ENDDO
	IF ALLTRIM(cOS)<>""
		cOS:=SUBSTR(cOS,1,LEN(cOS)-1)
	ENDIF
	RESTAREA(aAreaSTJ)
ENDIF

RESTAREA(aArea)
RETURN(cOs)
//NGSEEK("ST4",STF->TF_SERVICO,1,"T4_NOME")
