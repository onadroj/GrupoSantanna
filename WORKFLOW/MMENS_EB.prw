#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE EXCLUS�O DE BORDER�S (_EB)              
*/
User Function MMENS_EB
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="EXCLUS�O DE/EM BORDER�: "
_cMensagem+="<br>Border�: "+_aDados[1]
_cMensagem+="<br>Usu�rio: "+_aDados[2]

Return(_cMensagem)