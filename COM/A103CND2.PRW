#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A103CND2     � Autor � EDSON              � Data �  04/10/06���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA SE DATA DE VENCIMENTO A PAGAR E SUPERIOR A UM       ���
���          � NUMERO DE DIAS EM MV_VENCIN                                ���
�������������������������������������������������������������������������͹��
���Uso       � COMPRAS E FINANCEIRO                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function A103CND2

if LEN(PARAMIXB)>0 .AND. !("CX" $ ccondicao)
	Dias:= GetMV("MV_VENCMIN")
	dDtIni := MSDATE()
	dDtFim := PARAMIXB[1,1]
	nDUtil :=0
	While dDtIni<dDtFim
		If DataValida(dDtIni) == dDtIni
			nDUtil := nDUtil + 1
		Endif
		dDtIni := dDtIni + 1
	EndDo
	if nDUtil<Dias .OR. dDtFim<dDtIni
		MsgStop("Vencimento real menor que o prazo minimo de dias uteis estabelecido em MV_VENCMIN!")
	endif
endif

Return
