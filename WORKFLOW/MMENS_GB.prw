#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE GERA��O DE BORDER�S (_GB)              
*/
User Function MMENS_GB
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="INCLUS�O DE/EM BORDER�: "
_cMensagem+="<br>Border�: "+_aDados[1]
_cMensagem+="<br>Tipo: "+_aDados[2]
_cMensagem+="<br>Valor total: "+_aDados[3]
_cMensagem+="<br>Usu�rio: "+_aDados[4]

Return(_cMensagem)