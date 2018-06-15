#Include 'Protheus.ch'
/**
Ponto de entrada chamado no momento final da grava��o na fun��o de inconsist�ncias, 
fazendo uma verifica��o do usu�rio.
**/
User Function MNTA8301()

Local nVariacao := nCont1v - ST9->T9_POSCONT
	aArea:=getarea()
	dbselectarea("STC")
	dbSETOrder(1)//FILIAL+BEM
	DBSEEK(xfilial("STC")+ST9->T9_CODBEM)	
	While !EOF() .AND. xFilial("STC")+STC->TC_CODBEM==xFilial("ST9")+ST9->T9_CODBEM
	       aArea2:=GetArea()
			dbselectarea("TPE")
			dbSETOrder(1)//FILIAL+BEM
			If DBSEEK(xfilial("TPE")+STC->TC_COMPONE)
				//ALERT("UPDATE CONTADOR "+ cValToChar(nVariacao))
				RecLock("TPE",.F.)
              Replace TPE->TPE_POSCON With TPE->TPE_POSCON + nVariacao
              Replace TPE->TPE_CONTAC With TPE->TPE_CONTAC + nVariacao
              MsUnlock()				
			ENDIF	
			restarea(aArea2)
	DbSkip()
	Enddo
	restarea(aArea)
Return .t.