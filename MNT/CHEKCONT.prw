#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CHEKCONT  � Autor � EDSON              � Data �  19/08/05   ���
�������������������������������������������������������������������������͹��
���Descricao � Efetua checagem de contadores acumulados de bens no m�dulo ���
���          � Manuten��o de Ativos                                       ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CHEKCONT
Private cPerg := "CHKCNT"

IF MSGBOX("Para a execu��o desta rotina � necess�rio que o m�dulo de Manuten��o"+chr(13)+ ;
          "n�o esteja sendo utilizado por outros usu�rios!!!"+chr(13)+  ;
          "Deseja realmente efetuar os ajustes nos contadores acumulados?","CHEKCONT","YESNO")
  ValidPerg(cPerg)
  Pergunte(cPerg,.T.)

  Processa({|| FVerifica() },"Processando...")
ENDIF

Return


Static Function FVerifica()
Private cString := "ST9"
Private nContador := 0
Private nAcumulado := 0 
Private nAcum := 0
Private lAchou

dbSelectArea("ST9")
dbSetOrder(1)

DBGoTop()
COUNT to _RECCOUNT
DBGoTop()
ProcRegua(_RECCOUNT)
DBSeek(xFilial("ST9")+mv_par02,.T.)

WHILE !EOF()
    IncProc("Ajustando contadores do bem : "+AllTrim(ST9->T9_CODBEM))

    If ST9->T9_CODBEM < mv_par02 .OR. ST9->T9_CODBEM > mv_par03
       DbSkip()
       Loop
	Endif       

    If ST9->T9_CCUSTO < mv_par04 .OR. ST9->T9_CCUSTO > mv_par05
       DbSkip()
       Loop
	Endif       

    If ST9->T9_TEMCONT<>"S" .OR. ST9->T9_SITBEM<>"A"
       DbSkip()
       Loop
    Endif

    AjustaSTP(ST9->T9_CODBEM)
    
   RecLock("ST9",.F.)
   Replace ST9->T9_VARDIA With 1
   MsUnlock()
    if lAchou 
//	    MsgBox("O contador acumulado do bem "+alltrim(ST9->T9_CODBEM)+" ser� alterado para "+alltrim(str(nAcumulado)))
        RecLock("ST9",.F.)
        Replace ST9->T9_CONTACU With nAcumulado
        MsUnlock()
        aAreaX:=GetArea()
        DbSelectArea("STC")
        DbSetOrder(1)
        DbSeek(xFilial("STC")+ST9->T9_CODBEM,.T.)
        While !EOF() .AND. xFilial("STC")+STC->TC_CODBEM==xFilial("ST9")+ST9->T9_CODBEM
          AjustaSTP(STC->TC_COMPONE)
          aAreaY:=GetArea()
          DbSelectArea("ST9")
          DbSetOrder(1)
          if DbSeek(xFilial("ST9")+STC->TC_COMPONE)
             RecLock("ST9",.F.)
             Replace ST9->T9_VARDIA With 1
             MsUnlock()
             if lAchou 
//      	       MsgBox("O contador acumulado do sub-conjunto "+alltrim(ST9->T9_CODBEM)+" ser� alterado para "+alltrim(str(nAcumulado)))
               RecLock("ST9",.F.)
               Replace ST9->T9_CONTACU With nAcumulado
               MsUnlock()
             endif
          endif
          RestArea(aAreaX)
          RestArea(aAreaY)
          DbSkip()
        Enddo
        RestArea(aAreaX)
	endif

	DBSKIP()
ENDDO

MsgBox("Processamento terminado. Verifique se os contadores ajustados est�o coerentes"+chr(13)+   ;
       "atrav�s do relat�rio de situa��o das manuten��es e da rotina de altera��o de contador!","CHEKCONT")

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �VALIDPERG � Autor � AP5 IDE            � Data �  17/12/02   ���
�������������������������������������������������������������������������͹��
���Descri��o � Verifica a existencia das perguntas criando-as caso seja   ���
���          � necessario (caso nao existam).                             ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","A Partir Da Data     ?","","","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Do Bem               ?","","","mv_ch2","C",16,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","ST9","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Ate o Bem            ?","","","mv_ch3","C",16,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","ST9","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Do Centro de Custo   ?","","","mv_ch4","C",9,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CTT","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Ate o Centro de Custo?","","","mv_ch5","C",9,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","CTT","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return


Static Function AjustaSTP(CODBEM)
    aArea:=GetArea()
    DbSelectArea("STP")
    DbSetOrder(5)
    DbSeek(xFilial("STP")+CODBEM+DTOS(mv_par01),.T.)
    nContador := STP->TP_POSCONT
    nAcumulado := STP->TP_ACUMCON
    lAchou:=.F.
    lConv:=.F.
    While !EOF() .AND. STP->TP_CODBEM==CODBEM
       RecLock("STP",.F.)
       Replace STP->TP_VARDIA With 1
       MsUnlock()
       nAcum:=nAcumulado + STP->TP_POSCONT - nContador
//       if STP->TP_POSCONT<nContador .AND. STP->TP_ACUMCON>=nAcumulado .AND. STP->TP_TIPOLAN<>"Q"
       if STP->TP_POSCONT<nContador .AND. STP->TP_TIPOLAN<>"Q"
//          if MsgBox("O contador do bem "+alltrim(CODBEM)+" sofreu redu��o no dia "+dtoc(STP->TP_DTLEITU)+  ;
//                 "-"+STP->TP_HORA+" e precisa ser ajustado. Deseja ajust�-lo pelo registro anterior?","Confirma��o","YESNO")
//             MsgBox("Os contadores do bem "+alltrim(CODBEM)+" serao alterados no dia "+dtoc(STP->TP_DTLEITU)+  ;
//                 "-"+STP->TP_HORA+" para "+alltrim(str(nContador))+" e "+alltrim(str(nAcumulado)))
             RecLock("STP",.F.)
             Replace STP->TP_POSCONT With nContador
             Replace STP->TP_ACUMCON With nAcumulado
             MsUnlock()
             lAchou:=.T.
//          else
//             lAchou:=.F.
//             Exit                                         
//          endif
       elseif STP->TP_ACUMCON<>nAcum .AND. STP->TP_TIPOLAN<>"Q" .AND. STP->TP_POSCONT>=nContador
//          MsgBox("O contador acumulado do bem "+alltrim(CODBEM)+" ser� alterado no dia "+dtoc(STP->TP_DTLEITU)+  ;
//                 "-"+STP->TP_HORA+" para "+alltrim(str(nAcum)))
          RecLock("STP",.F.)
          Replace STP->TP_ACUMCON With nAcum
          MsUnlock()
          nAcumulado := nAcum
          lAchou:=.T.
       elseif STP->TP_ACUMCON<>nAcumulado .AND. STP->TP_TIPOLAN=="Q"
//          MsgBox("O contador acumulado do bem "+alltrim(CODBEM)+" ser� alterado no dia "+dtoc(STP->TP_DTLEITU)+  ;
//                 "-"+STP->TP_HORA+" para "+alltrim(str(nAcumulado)))
          RecLock("STP",.F.)
          Replace STP->TP_ACUMCON With nAcumulado
          MsUnlock()
          lAchou:=.T.
       else
          nAcumulado := STP->TP_ACUMCON
       endif
       nContador := STP->TP_POSCONT
       DbSkip()
    Enddo
    RestArea(aArea)
Return