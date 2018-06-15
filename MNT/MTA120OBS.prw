#INCLUDE "rwmake.ch"
#INCLUDE "FONT.CH"
#Include "Colors.ch"
#INCLUDE "PROTHEUS.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTA120OBS � Autor � GATASSE            � Data �  10/03/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Abre janela no gatilho de T5_DESCRIC para pedir memo       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function MTA120OBS
Local nPos:= (AScan(aHeader,{|aItem| AllTrim(aItem[2])=="T5_DESC"}))        
nOpc:=0
cObs:=Acols[n][nPos]
cRet:=Acols[n][nPos]
DEFINE MSDIALOG oDlgX TITLE "Dados complementares" FROM 33,25 TO 350,350 PIXEL
@ 010,005 Say "Descri��o"   	SIZE 055, 7  OF oDlgX PIXEL
@ 025,005 Get oMEMO VAR cOBS SIZE 150, 100 OF oDlgX PIXEL  MEMO    VALID (LEN(ALLTRIM(COBS))<=999)
DEFINE SBUTTON FROM 140,080  TYPE 1 ACTION (oDlgX:End(),nOpc:=1) ENABLE OF oDlgX
DEFINE SBUTTON FROM 140,120  TYPE 2 ACTION (oDlgX:End()) ENABLE OF oDlgX
ACTIVATE MSDIALOG oDlgX CENTERED
IF nOpc==1                                        
	cRet:=cObs
endif
Return(cRet)
