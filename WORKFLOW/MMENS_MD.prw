#INCLUDE "protheus.ch"
/*
MESSENGER PARA EVENTOS DE MEDI��ES (_MD) - Encerramento e Estorno
*/
User Function MMENS_MD()
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="Medi��o de Contrato"
_cMensagem+="<br>Opera��o: "+_aDados[1]
_cMensagem+="<br>Medi��o No.: "+_aDados[2]
_cMensagem+="<br>Contrato: "+_aDados[3]
_cMensagem+="<br>Revis�o: "+_aDados[4]
_cMensagem+="<br>"+_aDados[6]+" - "+_aDados[7]
_cMensagem+="<br>Respons�vel: "+_aDados[5]

Return(_cMensagem)