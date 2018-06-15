#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE ALTERA��O DA SITUA��O DE CONTRATO NO M�DULO GEST�O DE CONTRATOS(_SC)              
*/
User Function MMENS_SC
Local _aDados:=paramixb[1]
Local _cMensagem:=""

_cMensagem:="ALTERA��O DA SITUA��O DE CONTRATO"
_cMensagem+="<br>Contrato: "+_aDados[1]
_cMensagem+="<br>Revis�o: "+_aDados[2]
_cMensagem+="<br>Tipo: "+_aDados[3]
_cMensagem+="<br>Opera��o: "+IIf(_aDados[4]=="1","Compra","Venda")
_cMensagem+="<br>Objeto: "+_aDados[5]
If _aDados[4]=="1"
	_cMensagem+="<br>Fornecedor(es): "+_aDados[6]
Else
	_cMensagem+="<br>Cliente: "+_aDados[6]
Endif
_cMensagem+="<br><br>Situa��o anterior: "+_aDados[7]
_cMensagem+="<br>Nova situa��o: "+_aDados[8]
_cMensagem+="<br>Respons�vel pela altera��o: "+_aDados[9]
If !Empty(_aDados[11])
	_cMensagem+="<br><br>Justificativa para o retorno de situa��o: "+_aDados[11]
Endif
_cMensagem+="<br><br><br>Usu�rios relacionados ao contrato: "+_aDados[10]+"<br><br>"

Return(_cMensagem)