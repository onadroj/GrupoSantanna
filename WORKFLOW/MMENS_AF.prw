#INCLUDE "protheus.ch"
/*
MESSENGER PARA EVENTO DE ALTERA��ES EM CADASTROS DE FORNECEDORES (_AF)
*/
User Function MMENS_AF()
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="Altera��o cadastral"
_cMensagem+="<br>Fornecedor: "+_aDados[3]
_cMensagem+="<br>Respons�vel: "+_aDados[1]
_cMensagem+="<br>Motivo: "+_aDados[2]
_cMensagem+="<br><br>Altera��es: "

For _I := 4 to Len(_aDados)
	_cMensagem+="<br>"+_aDados[_I]
Next

_cMensagem+="<br><br>Altera��es registradas no banco de dados para auditorias futuras. "

Return(_cMensagem)