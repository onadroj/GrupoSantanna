#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE LIBERA��O DE BORDER�S (_LB)              
*/
User Function MMENS_LB
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="BORDER�: "
_cMensagem+="<br>Opera��o: "+_aDados[5]
_cMensagem+="<br>Border�: "+_aDados[1]
_cMensagem+="<br>Tipo: "+_aDados[2]
_cMensagem+="<br>Valor: "+_aDados[3]
_cMensagem+="<br>Respons�vel: "+_aDados[4]

Return(_cMensagem)