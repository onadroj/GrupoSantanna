#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE ALTERA��O SALARIAL (_AS)              
*/
User Function MMENS_AS
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="ALTERA��O SALARIAL EFETUADA: "
_cMensagem+="<br>Funcion�rio: "+_aDados[1]
_cMensagem+="<br>Fun��o: "+_aDados[7]
_cMensagem+="<br>Situa��o: "+_aDados[8]
_cMensagem+="<br>C.Custo: "+_aDados[9]
_cMensagem+="<br>Sal�rio anterior: R$ "+_aDados[2]
_cMensagem+="<br>Novo sal�rio: R$ "+_aDados[3]
_cMensagem+="<br>Motivo: "+_aDados[4]
_cMensagem+="<br>Data: "+_aDados[5]
_cMensagem+="<br>Usu�rio: "+_aDados[6]

Return(_cMensagem)