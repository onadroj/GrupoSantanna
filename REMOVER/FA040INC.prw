#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA040INC  � Autor � EDSON              � Data �  03/08/05   ���
�������������������������������������������������������������������������͹��
���Descricao � Validacao do intervalo de datas da locacao de box - My Box -��
���          � no cadastramento de contas a receber                       ���
�������������������������������������������������������������������������͹��
���Uso       � SIGAFIN                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function FA040INC()
Local lReturn:=.T.
Local _cCntObr := ""  
Local _aDados := {}

IF cEmpAnt == "05"
	if ALLTRIM(dtos(M->E1_LOCATE))<>"" .AND. alltrim(dtos(M->E1_LOCDE))==""
	   msgstop("Data inicial da loca��o precisa ser preenchida!")
	   lReturn:=.F.
	elseif alltrim(dtos(M->E1_LOCDE))<>"" .AND. alltrim(dtos(M->E1_LOCATE))==""
	   msgstop("Data final da loca��o precisa ser preenchida!")
	   lReturn:=.F.
	else
	   if (M->E1_LOCATE - M->E1_LOCDE + 1) > 32
	      msgstop("Limite excedido para per�odo de loca��o!")
	      lReturn:=.F.
	   endif   
	endif
endif	
if M->E1_EMISSAO < getmv("MV_DATAFIS")
   msgstop("Lancamento em periodo fiscal fechado, entre em contato com a contabilidade.")
   lReturn:=.F.
endif

//Valida obrigatoriedade de contrato para o cliente
If lReturn .AND. (cEmpAnt=="03" .OR. cEmpAnt=="04" .OR. cEmpAnt=="08" .OR. cEmpAnt=="99") // Executado apenas para a Construtora Sant'Anna ou empresa Teste 
	_cCntObr := RetField("SA1",1,xFilial("SA1")+M->E1_CLIENTE+M->E1_LOJA,"A1_CNTOBR")
	If _cCntObr=="1"
		MsgStop("Para este cliente � exigida utiliza��o de contrato, com pedido de venda gerado por medi��o." +chr(13)+chr(10) ;
			   +"A gera��o de contas a receber deve ser feita a partir do Documento de Sa�da, no m�dulo Faturamento.")
		lReturn := .F.
	ElseIf _cCntObr=="3"
		aAdd(_aDados,M->E1_CLIENTE)
		aAdd(_aDados,M->E1_LOJA)
		aAdd(_aDados,RetField("SA1",1,xFilial("SA1")+M->E1_CLIENTE+M->E1_LOJA,"A1_NOME"))
		aAdd(_aDados,M->E1_NUM + " - Prefixo: "+M->E1_PREFIXO)
		aAdd(_aDados,cUserName)
		aAdd(_aDados,"Contas a Receber")
		aAdd(_aDados,"C")
		MEnviaMail("_CO",_aDados,,,,.T.)
	Endif
Endif

Return(lReturn)
