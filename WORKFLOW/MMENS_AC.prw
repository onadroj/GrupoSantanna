#INCLUDE "protheus.ch"
/*
MESSENGER PARA EVENTO DE ALTERAÇÕES EM CADASTROS DE CLIENTES (_AC)
*/
User Function MMENS_AC()
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="Alteração cadastral"
_cMensagem+="<br>Cliente: "+_aDados[3]
_cMensagem+="<br>Responsável: "+_aDados[1]
_cMensagem+="<br>Motivo: "+_aDados[2]
_cMensagem+="<br><br>Alterações: "

For _I := 4 to Len(_aDados)
	_cMensagem+="<br>"+_aDados[_I]
Next

_cMensagem+="<br><br>Alterações registradas no banco de dados para auditorias futuras. "

Return(_cMensagem)