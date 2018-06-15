#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � RCHKCONT  � Autor � EDSON             � Data �  23/08/05   ���
�������������������������������������������������������������������������͹��
���Descricao � Emite relatorio de contadores acumulados inconsistentes de ���
���          � bens do modulo Manutencao de Ativos                        ���
�������������������������������������������������������������������������͹��
���Uso       � SIGAMNT                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RGPE001()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Apropria��o de loca��o de box"
Local cPict          := ""
Local titulo       := "Rateio da Folha por centro de custo/Banco"
Local nLin         := 80

Local Cabec1       :="CENTRO DE CUSTO          VALOR"
Local Cabec2       :=""
Local imprime      := .T.
Local aOrd := {"Por Banco","C. Custo"}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "RGPE001" 
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RGPE001" 
Private cPerg      := ""

Private cString := "SRC"

dbSelectArea("SRC")
dbSetOrder(1)


//ValidPerg()
//pergunte(cPerg,.F.)

//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  04/08/05   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local cQuery
Local cBanco	:=""
Local nTotal	:=0
Local nTotGeral :=0

cQuery:="SELECT SUBSTRING(RA_BCDEPSA,1,3) AS BANCO, RC_CC,SUM(RC_VALOR) AS VALOR FROM "     
cQuery+=RETSQLNAME("SRC")+" SRC ,"
cQuery+=RETSQLNAME("SRA")+" SRA "
cQuery+="WHERE RC_PD = '799' AND RA_MAT = RC_MAT "
cQuery+="AND SRC.D_E_L_E_T_ <> '*' "                                                                                                                    
cQuery+="GROUP BY SUBSTRING(RA_BCDEPSA,1,3), RC_CC "
cQuery+="ORDER BY BANCO "

TCQUERY cQuery NEW ALIAS "QRY"

dbSelectArea("QRY")
DbGoTop()
COUNT TO _RECCOUNT
DbGoTop()
SetRegua(_RECCOUNT)
DbGoTop()          
alert(_RECCOUNT)

//���������������������������������������������������������������������Ŀ
//� Posicionamento do primeiro registro e loop principal. Pode-se criar �
//� a logica da seguinte maneira: Posiciona-se na filial corrente e pro �
//� cessa enquanto a filial do registro for a filial corrente. Por exem �
//� plo, substitua o dbGoTop() e o While !EOF() abaixo pela sintaxe:    �
//�                                                                     �
//� dbSeek(xFilial())                                                   �
//� While !EOF() .And. xFilial() == A1_FILIAL                           �
//�����������������������������������������������������������������������


While !EOF()

   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif  
   IncRegua()

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

   If nLin > 50 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 9
   Endif
      /*
   if cBanco <> QRY->BANCO 
   		IF cBanco <> ""
			nLin++ 
			@nLin,000 PSAY "Total: "
			@nLin,020 PSAY nTotal PICTURE "@E 999,999,999.99"
			nLin:=nLin+2
		endif
				
		@nLin,000 PSAY QRY->BANCO
		@nLin,005 PSAY "-"       
		@nLin,007 PSAY nomedobanco(QRY->BANCO)
		nLin++  
		nTotGeral += nTotal
	   	nTotal := 0
   		cBanco := QRY->BANCO
   endif
   */
   @nLin,000 PSAY QRY->RC_CC
   @nLin,020 PSAY QRY->VALOR PICTURE "@E 999,999,999.99"
   nTotal +=QRY->VALOR
   nLin++
   dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo        

   nLin++
   @nLin,010 PSAY "Total Geral:"
   @nLin,035 PSAY nTotGeral  PICTURE "@E 999,999,999.99"
CLOSE

//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return     

static function nomedobanco(nBanco) 
Local cNomeBanco := ""
DO CASE
	CASE nBanco == "001"
		cNomeBanco := "BANCO DO BRASIL S.A."
	CASE nBanco == "104"
		cNomeBanco := "CAIXA ECONOMICA FEDERAL"
	CASE nBanco == "033"
		cNomeBanco := "BANCO SANTANDER S.A."
	CASE nBanco == "237"
		cNomeBanco := "BANCO BRADESCO S.A."
	CASE nBanco == "318"
		cNomeBanco := "BANCO BMG S.A."
	CASE nBanco == "341"
		cNomeBanco := "BANCO ITAU S.A."
	CASE nBanco == "356"
		cNomeBanco :="BANCO ABN AMRO REAL S.A." 
	CASE nBanco == "399"
		cNomeBanco :="HSBC BANK BRASIL S.A.-BANCO MULTIPLO"
	CASE nBanco == "409"
		cNomeBanco :="UNIBANCO - UNIAO DE BANCOS BRASILEIROS S.A."
	CASE nBanco == "477"
		cNomeBanco :="CITIBANK N.A."		
	OTHERWISE
		cNomeBanco := "BANCO NAO CADASTRADO"
ENDCASE
/*
001 - "BANCO DO BRASIL S.A."
033 - "BANCO SANTANDER S.A."
237 - "BANCO BRADESCO S.A."
318 - "BANCO BMG S.A."
341 - "BANCO ITAU S.A."
356 - "BANCO ABN AMRO REAL S.A."
399 - "HSBC BANK BRASIL S.A.-BANCO MULTIPLO"
409 - "UNIBANCO - UNIAO DE BANCOS BRASILEIROS S.A."
477 - "CITIBANK N.A."
*/
return(cNomeBanco)