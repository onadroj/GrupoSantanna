#include "rwmake.ch"

User Function FA60FIL()
Private nRetorno



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    �          � Autor �MAURICIO/GATASSE       �                ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Altera filtro de contas a receber dependendo do filtro     ���
���          �                                                            ���
���          �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � contas a receber / bordero                                 ���
�������������������������������������������������������������������������Ĵ��
���Tabelas   �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Modulo    �                                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������

O ponto de entrada FA60FIL ser� executado no filtro de registros que ser�o 
processados para a elabora��o do border�(tipo Indregua).

*/

aArea:=GetArea()
nRetorno:= ""
/*cTipo:=space(1)
aRadio := {"1-Para CNAB", "2-Nao CNAB", "3-Tudo"}
nRadio := 1

NOK:=.T.
Do while NOK                       
	@ 0, 0 TO 200,280 DIALOG oDlg TITLE "FILTRO"
	@ 12,12 TO 67,140 TITLE "Filtro"
	@ 23,20 RADIO aRadio VAR nRadio
	@ 020, 75 BMPBUTTON TYPE 01 ACTION Confirma()
	@ 045, 75 BMPBUTTON TYPE 02 ACTION (nRetorno:="",NOK:=.F.,Close(oDlg))
	ACTIVATE DIALOG oDlg CENTER
EndDo
  */

RestArea(aArea)     
//nRetorno:=nRetorno + ' .and. (EMPTY(SE1->E1_STAT) .OR. ALLTRIM(SE1->E1_STAT)=="AC") '
nretorno:= 'SUBSTR(SE1->E1_TIPO,-1) <> "-"'
Return(nRetorno)


Static Function Confirma()
***********************************************************************
* Cria a tela para pergunta
***********************************************************************

NOK:=.F.                                     

	if nRadio==1  
		nRetorno:= ' !EMPTY(SE1->E1_NUMBCO) '
	endif
	if nRadio==2                 
		nRetorno:= " EMPTY(SE1->E1_NUMBCO) "
	endif
	if nRadio==3 
		nRetorno:= " .T. "
	endif
  
Close(oDlg)

Return()      
Return(nRetorno)        

