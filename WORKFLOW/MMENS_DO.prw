#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE INCLUS�O DE DOCUMENTO ENTRADA GERANDO T�TULOS COM DOCUMENTA��O OBRIGAT�RIA PARA LIBERA��O PARA BAIXA NO FINANCEIRO (_DO)              
*/
User Function MMENS_DO
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="O documento de entrada abaixo foi inclu�do no sistema, relacionado a medi��o(�es) de contrato(s)."
_cMensagem+="Para o(s) tipo(s) do(s) contrato(s) relacionado(s), ser�o exigidos os documentos listados, para libera��o para baixa dos t�tulos a pagar."
_cMensagem+="<br><br>Documento/S�rie: "+_aDados[1]
_cMensagem+="<br>Fornecedor/Loja: "+_aDados[2]
_cMensagem+="<br>Respons�vel pela inclus�o: "+_aDados[3]
_cMensagem+="<br><br>Contrato(s) e documento(s) exigido(s): "+_aDados[4]
_cMensagem+="<br><br>"

Return(_cMensagem)