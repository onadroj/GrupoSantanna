#include "rwmake.ch"
#include "topconn.ch"

/*
- Rotina para tratamento de t�tulos provis�rios (listagem e exclus�o).
- Para utiliza��o via valida��o de usu�rio do campo E2_FORNECE (EXECBLOCK("BUSCAPROV",.F.,.F.))
- Na inclus�o manual de Contas a Pagar, ap�s digitar o c�digo do fornecedor, busca t�tulos provis�rios e, caso encontre, lista os registros encontrados, 
independente da loja do fornecedor
- Permite a sele��o e exclus�o de t�tulos encontrados, alertando o usu�rio para utiliza��o da rotina de substitui��o do sistema caso utilize a contabiliza��o 
de t�tulos provis�rios.
*/

User Function BUSCAPROV()
Local _cQuery := ""
Local _aArea:=GetArea()
Local _lOk
Local _aDbf
Local _aTrb

Private aRotina := {{"Excluir    " ,"ExcPR", 0, 1}}
Private aAC     := {"Abandona","Confirma"}
Private _cArqTrab
Private _oDlg4
Private _nOpca
Private _cMarca

If cEmpAnt=="03" .OR. cEmpAnt=="04" .OR. cEmpAnt=="06" .OR. cEmpAnt=="08"  .OR. cEmpAnt=="99"
		_cQuery := "SELECT E2_PREFIXO, E2_NUM, E2_PARCELA, E2_EMISSAO, E2_FORNECE, E2_LOJA, E2_VENCREA, E2_VALOR, E2_SALDO, E2_MDCONTR, E2_MDREVIS "
		_cQuery += "FROM " + RetSqlName("SE2") + " WHERE "
		_cQuery += "E2_FILIAL = '" + XFILIAL("SE2") + "' AND E2_FORNECE = '" + M->E2_FORNECE + "' AND E2_TIPO = 'PR ' "
		_cQuery += "AND E2_SALDO > 0 AND D_E_L_E_T_ <> '*' "
		_cQuery += "ORDER BY E2_VENCREA, E2_NUM, E2_PARCELA"
		
		TCQUERY _cQuery NEW ALIAS QRY

		DbSelectArea("QRY")
		If Eof()
			Close
			RestArea(_aArea)
			Return(.T.)	
		Endif

		MsgBox("Este fornecedor possui t�tulos provis�rios, neste momento ser� poss�vel efetuar a exclus�o." +chr(13) + chr(10) ; 
		     + "ATEN��O: Caso os t�tulos provis�rios sejam contabilizados, utilize a rotina de substitui��o.","BUSCAPROV")

		_cMarca := GetMark()
		
		_aDbf := {}
		AADD(_aDbf,{ "E2_OK"      , "C" , 2, 0 })
		AADD(_aDbf,{ "E2_PREFIXO" , "C" , TAMSX3("E2_PREFIXO")[1], TAMSX3("E2_PREFIXO")[2] })
		AADD(_aDbf,{ "E2_NUM"     , "C" , TAMSX3("E2_NUM")[1], TAMSX3("E2_NUM")[2] })
		AADD(_aDbf,{ "E2_PARCELA" , "C" , TAMSX3("E2_PARCELA")[1], TAMSX3("E2_PARCELA")[2] })
		AADD(_aDbf,{ "E2_EMISSAO" , "D" , TAMSX3("E2_EMISSAO")[1], TAMSX3("E2_EMISSAO")[2] })
		AADD(_aDbf,{ "E2_FORNECE" , "C" , TAMSX3("E2_FORNECE")[1], TAMSX3("E2_FORNECE")[2] })
		AADD(_aDbf,{ "E2_LOJA"    , "C" , TAMSX3("E2_LOJA")[1], TAMSX3("E2_LOJA")[2] })
		AADD(_aDbf,{ "E2_VENCREA" , "D" , TAMSX3("E2_VENCREA")[1], TAMSX3("E2_VENCREA")[2] })
		AADD(_aDbf,{ "E2_VALOR" , "N" , TAMSX3("E2_VALOR")[1], TAMSX3("E2_VALOR")[2] ,})
		AADD(_aDbf,{ "E2_SALDO" , "N" , TAMSX3("E2_SALDO")[1], TAMSX3("E2_SALDO")[2] })
		AADD(_aDbf,{ "E2_MDCONTR" , "C" , TAMSX3("E2_MDCONTR")[1], TAMSX3("E2_MDCONTR")[2] ,})
		AADD(_aDbf,{ "E2_MDREVIS" , "C" , TAMSX3("E2_MDREVIS")[1], TAMSX3("E2_MDREVIS")[2] })
		
		_aTrb := {}
		
		AADD(_aTrb,{"E2_OK"      ,NIL," "    ,})
		AADD(_aTrb,{"E2_PREFIXO" ,NIL,"Prefixo",})
		AADD(_aTrb,{"E2_NUM"     ,NIL,"Documento",})
		AADD(_aTrb,{"E2_PARCELA" ,NIL,"Parcela",})
		AADD(_aTrb,{"E2_EMISSAO" , NIL,"Emissao",})
		AADD(_aTrb,{"E2_FORNECE" , NIL,"Fornecedor",})
		AADD(_aTrb,{"E2_LOJA"    , NIL,"Loja"})
		AADD(_aTrb,{"E2_VENCREA" , NIL,"Vencto. Real",})
		AADD(_aTrb,{"E2_VALOR"    , NIL,"Valor","@E 999,999,999.99"})
		AADD(_aTrb,{"E2_SALDO"    , NIL,"Saldo","@E 999,999,999.99"})
		AADD(_aTrb,{"E2_MDCONTR"    , NIL,"Contrato",})
		AADD(_aTrb,{"E2_MDREVIS"    , NIL,"Revisao",})
		
		_cArqTrab := CriaTrab(_aDbf)
		Use (_cArqTrab) NEW SHARED Alias TRB25
		
		DbSelectArea("QRY")
		While !Eof()
			dbSelectArea("TRB25")
			TRB25->(DbAppend())
			TRB25->E2_OK      := " "
			TRB25->E2_PREFIXO  := QRY->E2_PREFIXO
			TRB25->E2_NUM  := QRY->E2_NUM
			TRB25->E2_PARCELA  := QRY->E2_PARCELA
			TRB25->E2_EMISSAO  := STOD(QRY->E2_EMISSAO)
			TRB25->E2_FORNECE  := QRY->E2_FORNECE
			TRB25->E2_LOJA  := QRY->E2_LOJA
			TRB25->E2_VENCREA  := STOD(QRY->E2_VENCREA)
			TRB25->E2_VALOR  := QRY->E2_VALOR
			TRB25->E2_SALDO  := QRY->E2_SALDO
			TRB25->E2_MDCONTR  := QRY->E2_MDCONTR
			TRB25->E2_MDREVIS  := QRY->E2_MDREVIS
			DbSelectArea("QRY")
			DbSkip()
		EndDo
		Close
		dbSelectArea("TRB25")
		DbGoTop()
		
		_nOpca   := 1
		
		DEFINE MSDIALOG _oDlg4 TITLE "Exclus�o de T�tulos Provis�rios" From 6.5,0 To 35,72 OF oMainWnd
		
		@ 20,30 Say OemToAnsi ("Selecione os t�tulos a excluir") SIZE 150,20
		oMark := MsSelect():New("TRB25","E2_OK",,_aTrb,,@_cMarca,{35,1,200,280})
		oMark:oBrowse:lhasMark = .F.
		oMark:oBrowse:lCanAllmark := .t.
		
		ACTIVATE MSDIALOG _oDlg4 ON INIT EnchoiceBar(_oDlg4,{||_nOpca:=2,_oDlg4:End()},{||_nOpca:=1,_oDlg4:End()}) CENTERED
		
		If _nOpca == 2      //OK
			Processa({|lEnd| EXCLUEPR()}, "Excluindo Provis�rios")
			Close
			fErase(_cArqTrab)
			MsgBox("T�tulos exclu�dos.","BUSCAPROV")
		ENDIF
		
		If _nOpca == 1  //CANCELAR
			Close
			fErase(_cArqTrab)
		EndIf
		RestArea(_aArea)
ENDIF
Return(.T.)

Static Function EXCLUEPR()
DbSelectArea("TRB25")
DbGoTop()
While !EOF()
	IF TRB25->E2_OK==_cMarca
		DBSELECTAREA("SE2")
		DBSETORDER(1)   //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
		IF DBSEEK(XFILIAL("SE2")+TRB25->E2_PREFIXO+TRB25->E2_NUM+TRB25->E2_PARCELA+"PR "+TRB25->E2_FORNECE+TRB25->E2_LOJA)
			RecLock("SE2",.F.)
			dbDelete()
			MsUnlock()
		ENDIF
	ENDIF
	dbSelectArea("TRB25")
	dbSkip()
EndDo
Return()
