#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A100CND2     � Autor � GATASSE            � Data �  11/09/02���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA SE DATA DE VENCIMENTO A PAGAR E SUPERIOR A UM       ���
���          � NUMERO DE DIAS EM MV_VENCIN                                ���
�������������������������������������������������������������������������͹��
���Uso       � COMPRAS E FINANCEIRO                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function A100CND2


if LEN(ACOLS)>0 .AND. !("CX" $ ccondicao)
	Dias:= GetMV("MV_VENCMIN")
	dDtIni := MSDATE()
	dDtFim := ACOLS[1,4]
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
