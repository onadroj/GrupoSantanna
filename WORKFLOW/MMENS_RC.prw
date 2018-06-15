#INCLUDE "protheus.ch"
/*
MESSENGER PARA O EVENTO DE REVIS�O DE CONTRATO NO M�DULO GEST�O DE CONTRATOS(_RC)              
*/
User Function MMENS_RC
Local _aDados:=paramixb[1]
Local _cMensagem:=""

If _aDados[1]=="1" //Inclus�o
	_cMensagem:="INCLUS�O DE REVIS�O DE CONTRATO"
ElseIf _aDados[1]=="2" //Exclus�o
	_cMensagem:="EXCLUS�O DE REVIS�O DE CONTRATO"
Else //Aprova��o
	_cMensagem:="APROVA��O DE REVIS�O DE CONTRATO"
Endif

If _aDados[1]=="1" //Inclus�o
	_cMensagem+="<br>Contrato: "+_aDados[2]
	_cMensagem+="<br>Revis�o base: "+_aDados[3]
	_cMensagem+="<br>Revis�o gerada: "+_aDados[4]
	_cMensagem+="<br>Tipo: "+_aDados[5]
	_cMensagem+="<br>Justificativa: "+_aDados[6]
	_cMensagem+="<br>Clausula: "+_aDados[7]
	_cMensagem+="<br>Respons�vel pela inclus�o: "+_aDados[8]
ElseIf _aDados[1]=="2" //Exclus�o
	_cMensagem+="<br>Contrato: "+_aDados[2]
	_cMensagem+="<br>Revis�o base: "+_aDados[3]
	_cMensagem+="<br>Revis�o gerada: "+_aDados[4]
	_cMensagem+="<br>Respons�vel pela exclus�o: "+_aDados[5]
Else //Aprova��o
	_cMensagem+="<br>Contrato: "+_aDados[2]
	_cMensagem+="<br>Revis�o gerada: "+_aDados[3]
	_cMensagem+="<br>Clausula: "+_aDados[4]
	_cMensagem+="<br>Justificativa: "+_aDados[5]
	_cMensagem+="<br>Respons�vel pela aprova��o: "+_aDados[6]
Endif

Return(_cMensagem)