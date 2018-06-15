#Include "PROTHEUS.CH"       

User Function MT103ISS
Local cFornIss  := PARAMIXB[1]      // C�digo do fornecedor de ISS atual para grava��o.
Local cLojaIss  := PARAMIXB[2]      // Loja do fornecedor de ISS atual para grava��o.
Local cDirf     := PARAMIXB[3]      // Indicador de gera dirf atual para grava��o.
Local cCodRet   := PARAMIXB[4]      // C�digo de reten��o do t�tulo de ISS atual para grava��o.
Local dVcIss    := PARAMIXB[5]      // Data de vencimento do t�tulo de ISS atual para grava��o.
Local aRet      := {}
Local cEst 		:= ""
Local cMun 		:= ""

     
Static oDlg


IF CTIPO=="N" .AND. MaFisRet(,"NF_VALISS") > 0  //NOTA COM ISS 
	IF empty(cForniss)
		DEFINE MSDIALOG oDlg TITLE "Informe os Parametros" FROM 000,000 TO 150,400 PIXEL 
		@ 010, 010 SAY "Informe o Codigo do Fornecedor:" SIZE 120, 20 OF oDlg PIXEL 
		@ 025, 010 SAY "Informe o Codigo da Loja" SIZE 120, 20 OF oDlg PIXEL 
		@ 010, 120 MSGET cFornIss VALID ExistCpo("SA2",cFornIss) F3 "SA2" PICTURE "@R 999999" SIZE 55, 11 OF oDlg PIXEL 
		@ 025, 120 MSGET cLojaIss SIZE 55, 11 Valid ExistCpo("SA2",cLojaIss+cLojaIss) PICTURE "@R 99" OF oDlg PIXEL 

		DEFINE SBUTTON FROM 055, 065 TYPE 1 ACTION (iif(tok(cForniss,cLojaIss),(oDlg:End(),nOpc:=1),nOpc:=0)) ENABLE OF oDlg 
		ACTIVATE MSDIALOG oDlg CENTERED
	ENDIF
ENDIF


cEst := POSICIONE("SA2", 1, xFilial("SA2") + cFornIss+cLojaIss, "A2_EST")
cMun := POSICIONE("SA2", 1, xFilial("SA2") + cFornIss+cLojaIss, "A2_COD_MUN")
cDiaVenc := POSICIONE("CC2", 1, xFilial("CC2") + cEst+cMun, "CC2_DTRECO")

IF cDiaVenc > 0
	dVcIss :=LASTDAY(DATE())+cDiaVenc
ENDIF                                

//dVcIss :=LASTDAY(DATE())+cDiaVenc
//ApMsgAlert("Pr�ximo dia �til do m�s: " + dtoc (LASTDAY(DATE())+cDiaVenc))

aAdd( aRet , cFornIss) 		//Cod Forn ISS
aAdd( aRet , cLojaIss)     	//Cod Loja Forn ISS
aAdd( aRet , '1')      		//Gera Dirf ? - 1=Sim, 2=Nao
aAdd( aRet , cCodRet)   	//Codigo de Receita
aAdd( aRet , dVcIss)   		//Vencimento ISS           

Return (aRet)

//(iif(tok(),(oDlg:End(),nOpc:=1),nOpc:=0))

Static Function tok(cForn,cLoj)
Local lRet:=.t.
IF  ALLTRIM(cForn)=="" .or.  ALLTRIM(cLoj)==""
	lRet:=.f.
	MSGSTOP("Existem campos vazios de preenchimento obrigatorio!")
ENDIF
return(lRet)
