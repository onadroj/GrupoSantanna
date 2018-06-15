#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT241EXT  � Autor � GATASSE            � Data �  05/11/04   ���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA EXTRONO DE MOVIMENTACAO INTERNA                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function MT241EXT
LOCAL RET:=.T.
local cVet:=""
LOCAL ACHOU:=.F.
LOCAL nPos1 := (AScan(aHeader,{|aItem| UPPER(AllTrim(aItem[2]))=="D3_OP"}))
FOR X:=1 TO LEN(ACOLS)
	IF ALLTRIM(ACOLS[X][nPos1])<>""
		if retfield("SC2",1,XFILIAL("SC2")+ACOLS[X][nPos1],"C2_DATRF")<>CTOD("  /  /  ") //OP ENCERRADA
			cvet:=	cVet+alltrim(ACOLS[X][nPos1])+","
			ACHOU:=.T.
		ENDIF
	endif
next
IF ACHOU
	cvet:=substr(cvet,1,len(cvet)-1)
	msgstop("Este documento contem itens que foram direcionados para OP/OS."+chr(13)+chr(10)+"As OP/OS "+cvet+" estao encerradas! Exclusao nao permitida!" )
	ret:=.f.
ENDIF
Return(RET)
