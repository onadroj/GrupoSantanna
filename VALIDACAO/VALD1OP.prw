#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VALD1OP   � Autor � GATASSE            � Data �  29/10/10   ���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA O CAMPO D1_OP                                       ���
���          � USADO NA VALIDACAO DE D1_OP PARA PREENCHER D1_ITEMCTA      ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������

Se a empresa � a 08, o item � o equipamento pai e a classe o componente, para o caso da OS 
ser de um componente.Se a OS j� � do pai (tem contador), n�o tem classe e o item � o pai.


Para a empresa 03, o item � o bem da OS e a classe o centro de custo da OS
/*/

User Function VALD1OP
Local aArea:=GetArea()
Local cOS:=&(__READVAR)
LOCAL nPosConta:=(AScan(aHeader,{|aItem| UPPER(AllTrim(aItem[2]))=="D1_CONTA"}))
LOCAL nPosItem:=(AScan(aHeader,{|aItem| UPPER(AllTrim(aItem[2]))=="D1_ITEMCTA"}))
LOCAL nPosCLVL := (AScan(aHeader,{|aItem| UPPER(AllTrim(aItem[2]))=="D1_CLVL"}))
Local lRet:=.t.
if cEmpAnt $ "08" .AND. ACOLS[N][nPosConta]>"3"
	if "OS" $ cOS//� UMA OS E N�O UMA OP
		cOS:=substr(cOS,1,6)
		dbSelectArea("STJ")
		dbSetOrder(1)
		if dbSeek(xFilial("STJ")+cOS,.T.)
			acols[n][nPosItem]:="E"+STJ->TJ_CODBEM
			acols[n][nPosCLVL]:=SPACE(9)
			dbSelectArea("ST9")
			dbSetOrder(1)
			if dbSeek(xFilial("ST9")+STJ->TJ_CODBEM)
				IF  ! ST9->T9_TEMCONT=="S"
					DBSELECTAREA("STC")
					DBSETORDER(3)//TC_FILIAL+TC_COMPONE+TC_CODBEM
					if dbSeek(xFilial("STC")+STJ->TJ_CODBEM)
						acols[n][nPosItem]:="E"+ALLTRIM(STC->TC_CODBEM) //Preenche Item cta com bem pai
						acols[n][nPosCLVL]:="E"+ALLTRIM(STJ->TJ_CODBEM)  //Preenche Classe Valor com bem filho
					endif
				endif
			endif
		endif
	endif
endif
if cEmpAnt $ "03" .AND. ACOLS[N][nPosConta]>"3"
	if "OS" $ cOS//� UMA OS E N�O UMA OP
		cOS:=substr(cOS,1,6)
		dbSelectArea("STJ")
		dbSetOrder(1)
		if dbSeek(xFilial("STJ")+cOS,.T.)
			acols[n][nPosItem]:="E"+STJ->TJ_CODBEM
			acols[n][nPosCLVL]:=ALLTRIM(STJ->TJ_CCUSTO)  //Preenche Classe Valor com o centro de custo
			dbSelectArea("ST9")
			dbSetOrder(1)
			if dbSeek(xFilial("ST9")+STJ->TJ_CODBEM)
				IF  ! ST9->T9_TEMCONT=="S"
					DBSELECTAREA("STC")
					DBSETORDER(3)//TC_FILIAL+TC_COMPONE+TC_CODBEM
					if dbSeek(xFilial("STC")+STJ->TJ_CODBEM)
						acols[n][nPosItem]:="E"+ALLTRIM(STC->TC_CODBEM) //Preenche Item cta com bem pai
					endif
				endif
			endif
		endif
	endif
endif
restarea(aArea)
Return(lRet)

