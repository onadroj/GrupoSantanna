#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"

User Function CN100VST()
Local _cSit := PARAMIXB[1]
Local _lRet := .F. 
Local _aArea := GetArea()
Local _aSit := {"Cancelado","Elaboracao","Emitido","Aprovacao","Vigente","Paralisado","Sol. Finalizacao","Finalizado","Revisao","Revisado"}

DbSelectArea("ZZ0")
DbSetOrder(1)
DbSeek(xFilial("ZZ0")+__CUSERID)

While !Eof() .AND. xFilial("ZZ0")+ZZ0->ZZ0_CODUSR==xFilial("ZZ0")+__CUSERID
	If ZZ0->ZZ0_SITUAC==_cSit
		_lRet := .T.
		Exit
	Endif
	DbSkip()
EndDo

If !_lRet
	MsgBox("Voc� n�o tem permiss�o para altera��o da situa��o do contrato para "+_aSit[Val(_cSit)]+".","Situa��o n�o permitida-CN100VST","ALERT")
Else
	Do Case
		Case _cSit=="01" .AND. CN9->CN9_SITUAC<>"05" 
			MsgBox("Somente pode ser alterada situa��o para "+_aSit[Val(_cSit)]+" no contrato com situa��o "+_aSit[5]+".","Situa��o n�o permitida-CN100VST","ALERT")
			_lRet := .F.
		Case _cSit=="02" .AND. (CN9->CN9_SITUAC<>"03" .AND. CN9->CN9_SITUAC<>"04")
			MsgBox("Somente pode ser alterada situa��o para "+_aSit[Val(_cSit)]+" no contrato com situa��o "+_aSit[3]+" ou "+_aSit[4]+".","Situa��o n�o permitida-CN100VST","ALERT")
			_lRet := .F.
		Case _cSit=="03" .AND. (CN9->CN9_SITUAC<>"02" .AND. CN9->CN9_SITUAC<>"04")
			MsgBox("Somente pode ser alterada situa��o para "+_aSit[Val(_cSit)]+" no contrato com situa��es "+_aSit[2]+" ou "+_aSit[4]+".","Situa��o n�o permitida-CN100VST","ALERT")
			_lRet := .F.
		Case _cSit=="04" .AND. CN9->CN9_SITUAC<>"03"
			MsgBox("Somente pode ser alterada situa��o para "+_aSit[Val(_cSit)]+" no contrato com situa��o "+_aSit[3]+".","Situa��o n�o permitida-CN100VST","ALERT")
			_lRet := .F.
		Case _cSit=="05" .AND. CN9->CN9_SITUAC<>"04"
			MsgBox("Somente pode ser alterada situa��o para "+_aSit[Val(_cSit)]+" no contrato com situa��o "+_aSit[4]+".","Situa��o n�o permitida-CN100VST","ALERT")
			_lRet := .F.
		Case _cSit=="07" .AND. CN9->CN9_SITUAC<>"05"
			MsgBox("Somente pode ser alterada situa��o para "+_aSit[Val(_cSit)]+" no contrato com situa��o "+_aSit[5]+".","Situa��o n�o permitida-CN100VST","ALERT")
		Case _cSit=="08" .AND. CN9->CN9_SITUAC<>"07"
			MsgBox("Somente pode ser alterada situa��o para "+_aSit[Val(_cSit)]+" no contrato com situa��o "+_aSit[7]+".","Situa��o n�o permitida-CN100VST","ALERT")
			_lRet := .F.
	End
Endif

RestArea(_aArea)

Return(_lRet)