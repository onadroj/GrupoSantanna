#INCLUDE "PROTHEUS.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F290FIL   � Autor � AP6 IDE            � Data �  18/12/09   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada no filtro de faturas a pagar              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F290FIL


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cFiltro:=".t."
Private cDescCC:=criavar("CTT_DESC01")
Public f290ccunid  := criavar("E2_CCUNID")
Public f290cc      := criavar("E2_CUSTO")
Public f290HIST    := criavar("E2_HIST")
Public f290COMPETE := criavar("E2_COMPETE")

DEFINE MSDIALOG oDlg FROM 000,000 To 250,410 PIXEL TITLE 'Informa��es para os t�tulos gerados'
@ 025,010 Say "Centro de Custo" pixel  SIZE 80,09 of oDlg
@ 024,060 MSGet of290cc  Var f290cc Size 040,08 Picture "@9.99.9.999.9" Valid ValidaI3() F3 "CTT" of oDlg Pixel
@ 024,110 MSGet oDesc Var cDescCC Size 080,08 when .f. of oDlg Pixel
@ 037,010 Say "CC Unid." PIXEL SIZE 80,09  of oDlg
@ 036,060 MSGet of290ccunid  Var f290ccunid Size 040,08 of oDlg Pixel  WHEN .F.
@ 049,010 Say "Competencia" PIXEL SIZE 80,09 of oDlg
@ 048,060 MSGet of290COMPETE Var f290COMPETE Size 040,08 Picture "@R 99/9999" Valid ValidaCmp() of oDlg Pixel
@ 061,010 Say "Hist�rico" PIXEL SIZE 180,09  of oDlg
@ 060,060 MSGet of290HIST  Var f290HIST Size 140,08 of oDlg Pixel
//@ 073,010 Say OemToAnsi("Dt.Ctb Outro Final") PIXEL SIZE 80,09 of oDlg
//@ 072,120 MSGet oGet  Var dDataFIM Size 040,08 of oDlg Pixel
DEFINE SBUTTON FROM 080,80  TYPE 1 ACTION (iif(tok(),(oDlg:End(),nOpc:=1),nOpc:=0)) ENABLE OF oDlg
Activate MsDialog oDlg Centered //on init EnchoiceBar(oDlg,{|| Eval(bOk)},{|| oDlg:End()})
cFiltro := " E2_ORIGEM <> 'SIGAEFF' "
Return(cFiltro)


Static Function tok()
Local lRet:=.t.
IF  ALLTRIM(f290cc)=="" .or.  ALLTRIM(f290COMPETE)=="".or.  ALLTRIM(f290HIST)==""
	lRet:=.f.
	MSGSTOP("Existem campos vazios de preenchimento obrigatorio!")
ENDIF
return(lRet)

Static Function ValidaI3()
Local aArea:=GetArea()
local lret:= !empty(ALLTRIM(f290cc)) .and. ExistCpo("CTT",f290cc)
if lret
	dbSelectArea("CTT")
	dbSetOrder(1)
	dbSeek(xFilial("CTT")+f290cc)                                            		
	cDescCC:=CTT->CTT_DESC01
	f290ccunid:=CTT->CTT_CCUNID
	oDesc:refresh()
	of290ccunid:refresh()
endif
RestArea(aArea)
return(lret)


Static Function ValidaCmp
Local mes:=substr(f290COMPETE,1,2)
Local ANO:=substr(f290COMPETE,3,4)
Local cRet:=.t.
if mes < "01" .or. mes >"12"
	cRet:= .f.
endif
if ano <"1989" .or. ano >"2020"
	cRet:= .f.
endif
Return( cRet )
