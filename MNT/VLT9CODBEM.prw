#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VLT9CODBEM� Autor � GATASSE            � Data �  29/10/10   ���
�������������������������������������������������������������������������͹��
���Descricao � Valida codigo do BEM de ST9                                ���
���          � USADO EM X3_VLDUSER DE T9_CODBEM                           ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function VLT9CODBEM
Local lRet:=.t.
Local cConteudo:=ALLTRIM(&(__READVAR))      
Local xx
//MsgBox("Erro no formato do campo. (XXX-999)"+cConteudo)

//valida formato @R XXX-999
if len(cConteudo) <> 7
	lRet:=.f.
endif
for xx:=1 to 7
	if xx<4  .and. (substr(cConteudo,xx,1)<"A" .or. substr(cConteudo,xx,1)>"Z")
		lRet:=.f.
	endif
	if xx=4 .and. substr(cConteudo,xx,1)<>"-"
		lRet:=.f.
	endif
	if xx>4 .and. (substr(cConteudo,xx,1)<"0" .or. substr(cConteudo,xx,1)>"9")
		lRet:=.f.
	endif
next
if !lRet
	MsgBox("Erro no formato do campo. (XXX-999)","VLT9CODBEM")
endif
Return(lRet)
