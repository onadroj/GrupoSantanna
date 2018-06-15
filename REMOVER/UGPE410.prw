#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �UGPE410   � Autor � AP6 IDE            � Data �  04/08/03   ���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA GERACAO DE CNAB A PAGAR DE FUNCIONARIOS.            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function UGPE410
//���������������������������������������Ŀ
//�  Ajusta Grupo de Perguntas - SX1      �
//�����������������������������������������
LOCAL AAREA
PRIVATE nHdl,cEOL,CPERG
AjustaSX1()
GPEM410()
IF SUBSTR(UPPER(ALLTRIM(MV_PAR21)),1,7)=="LIQBRAD" //LAYOUT BRADESCO
	nHdl    := fOpen(mv_par22,68)
	cEOL    := "CHR(13)+CHR(10)"
	If Empty(cEOL)
		cEOL := CHR(13)+CHR(10)
	Else
		cEOL := Trim(cEOL)
		cEOL := &cEOL
	Endif
	
	If nHdl == -1
		MsgAlert("O arquivo de nome "+mv_par22+" nao pode ser aberto! Verifique os parametros.","Atencao!")
		Return
	Endif
	
	//���������������������������������������������������������������������Ŀ
	//� Inicializa a regua de processamento                                 �
	//�����������������������������������������������������������������������
	
	Processa({|| RunCont() },"Processando...")
	Return
	
	
ELSE
	MSGSTOP("ROTINA NAO ESTA PREPARADA PARA O ARQUIVO DE CONFIGURACAO "+MV_PAR21)
ENDIF
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    � RUNCONT  � Autor � AP5 IDE            � Data �  04/08/03   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunCont

Local nTamFile, nTamLin, cBuffer, nBtLidos

//�����������������������������������������������������������������ͻ
//� Lay-Out do arquivo Texto gerado:                                �
//�����������������������������������������������������������������͹
//�Campo           � Inicio � Tamanho                               �
//�����������������������������������������������������������������Ķ
//� ??_FILIAL     � 01     � 02                                    �
//�����������������������������������������������������������������ͼ

nTamFile := fSeek(nHdl,0,2)
fSeek(nHdl,0,0)
nTamLin  := 200+Len(cEOL)
cBuffer  := Space(nTamLin) // Variavel para criacao da linha do registro para leitura

nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da primeira linha do arquivo texto

ProcRegua(nTamFile) // Numero de registros a processar

While nBtLidos >= nTamLin
	
	//���������������������������������������������������������������������Ŀ
	//� Incrementa a regua                                                  �
	//�����������������������������������������������������������������������
	
	IncProc()
	
	reg := cBuffer
	
	//���������������������������������������������������������������������Ŀ
	//� Leitura da proxima linha do arquivo texto.                          �
	//�����������������������������������������������������������������������
	
	nBtLidos := fRead(nHdl,@cBuffer,nTamLin) // Leitura da proxima linha do arquivo texto
	
	dbSkip()
EndDo

//���������������������������������������������������������������������Ŀ
//� O arquivo texto deve ser fechado, bem como o dialogo criado na fun- �
//� cao anterior.                                                       �
//�����������������������������������������������������������������������
VALOR:=SUBSTR(CBUFFER,2,13)//PARA BRADESCO
VLR:=VAL(VALOR)/100
fClose(nHdl)
//Close(oLeTxt)
AAREA:=GETAREA()
ERRO:=.F.
/*
dbSelectArea("SZJ")
dbSetOrder(1)      //ZJ_FILIAL+ZJ_TIPO+ZJ_BORDERO
IF dbSeek(xFilial("SZJ")+"P"+MV_PAR32)
	IF SZJ->ZJ_LIBERAD<>"S"
		MSGSTOP("BORDERO NAO SE ENCONTRA LIBERADO.")
		ERRO:=.T.
	ENDIF
	IF SZJ->ZJ_VALOR<>VLR
		MSGSTOP("TOTAL DO VALOR LIQUIDO GERADO NAO BATE COM VALOR DO BORDERO.")
		ERRO:=.T.
	ENDIF

ELSE
	MSGSTOP("BORDERO NAO SE ENCONTRA NO ARQUIVO DE LIBERACAO.")
	ERRO:=.T.
ENDIF
RESTAREA(AAREA)
IF ERRO
	MSGSTOP("OCORRERAM ERROS!. ARQUIVO NAO FOI GERADO.	")
	FERASE(MV_PAR22)
ENDIF
*/

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AjustaSX1 � Autor �                       � Data �          ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta Grupo de Perguntas                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
// Substituido pelo assistente de conversao do AP5 IDE em 28/03/00 ==> FUNCTION AJUSTASX1
Static FUNCTION AJUSTASX1() 
cPerg:="GPM410"
aSvAlias:=getarea()
i:=0
j:=0
cPerg:=PADR(cPerg,10)
Select SX1
aRegistros:={}

//AADD(aRegistros,{"GPM410","01","LIM.FISCAL?","LIM.FISCAL?","LIM.FISCAL?","mv_ch1","D",08,00,00,"G",""        ,"mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
  AADD(aRegistros,{cPerg,"32","Bordero ?"  ,"�Bordero?"  ,"Bordero  ?" ,"mv_chx","C",   6,0,0,"G","NaoVazio","mv_par32","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
dbSelectArea("SX1")
If !dbSeek(cPerg+"32")
	For i:=1 to Len(aRegistros)
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			FieldPut(j,aRegistros[i,j])
		Next
		MsUnlock()
	Next
Endif

restarea(aSvAlias)

Return(NIL)
