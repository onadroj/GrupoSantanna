#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE ALTERA��O DO VENCIMENTO DO ASO NO CADASTRO DO FUNCION�RIO (_EM)              
*/
User Function MMENS_EM
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="ALTERA��O DO VENCIMENTO DO ASO: "
_cMensagem+="<br>Funcion�rio: "+_aDados[1]
_cMensagem+="<br>Vencimento anterior: "+_aDados[2]
_cMensagem+="<br>Novo vencimento: "+_aDados[3]
_cMensagem+="<br>Usu�rio: "+_aDados[4]

Return(_cMensagem)