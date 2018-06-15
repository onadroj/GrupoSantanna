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

User Function RCHKCONT


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Apropria��o de loca��o de box"
Local cPict          := ""
Local titulo       := "Contadores acumulados inconsistentes"
Local nLin         := 80

Local Cabec1       :="BEM                 NOME                                       DATA       HORA     CONTADOR     ACUMULADO      CORRETO"
Local Cabec2       :=""
Local imprime      := .T.
Local aOrd := {"por equipamento"}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 80
Private tamanho          := "G"
Private nomeprog         := "RCHKCONT" 
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RCHKCONT" 
Private cPerg      := "CHKCNT"

Private cString := "ST9"

dbSelectArea("ST9")
dbSetOrder(1)


ValidPerg()
pergunte(cPerg,.F.)

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
Local nContador:=0
Local nAcumulado:=0           
Local nAcum:=0
Local lAchou

cQuery:="SELECT T9_CODBEM, T9_NOME FROM "+RETSQLNAME("ST9")+" " 
cQuery+="WHERE D_E_L_E_T_<>'*' "
cQuery+="AND T9_CODBEM >= '"+mv_par02+"' AND T9_CODBEM <= '"+mv_par03+"' "
cQuery+="AND T9_CCUSTO >= '"+mv_par04+"' AND T9_CCUSTO <= '"+mv_par05+"' "
cQuery+="AND T9_TEMCONT='S' AND T9_SITBEM='A' "
cQuery+="ORDER BY T9_CODBEM"

TCQUERY cQuery NEW ALIAS "QRY"

dbSelectArea("QRY")
DbGoTop()
COUNT TO _RECCOUNT
DbGoTop()
SetRegua(_RECCOUNT)


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
            
    aArea:=GetArea()
    DbSelectArea("STP")
    DbSetOrder(5)
    DbSeek(xFilial("STP")+QRY->T9_CODBEM+DTOS(mv_par01),.T.)
    nContador := STP->TP_POSCONT
    nAcumulado := STP->TP_ACUMCON
    lAchou:=.F.
    While !EOF() .AND. STP->TP_CODBEM==QRY->T9_CODBEM
       nAcum:=nAcumulado + STP->TP_POSCONT - nContador
//       if STP->TP_POSCONT<nContador .AND. STP->TP_ACUMCON>=nAcumulado .AND. STP->TP_TIPOLAN<>"Q"
       if STP->TP_POSCONT<nContador .AND. STP->TP_TIPOLAN<>"Q"
		  @nLin,000 PSAY QRY->T9_CODBEM
		  @nLin,020 PSAY QRY->T9_NOME
		  @nLin,063 PSAY Dtoc(STP->TP_DTLEITU)
		  @nLin,074 PSAY STP->TP_HORA
          @nLin,081 PSAY STP->TP_POSCONT   Picture "@E 999,999,999"
		  @nLin,094 PSAY STP->TP_ACUMCON   Picture "@E 999,999,999"
		  @nLin,128 PSAY "Provavelmente houve troca de KM para H,o acumulado deste bem precisa ser ajustado nesta data"
          nLin++                                        
		  @nLin,128 PSAY "Verifique tamb�m os bens da estrutura deste equipamento"
          nLin++                                        
          lAchou:=.T.
          Exit                                         
       elseif STP->TP_ACUMCON<>nAcum .AND. STP->TP_TIPOLAN<>"Q" .AND. STP->TP_POSCONT>=nContador
		  @nLin,000 PSAY QRY->T9_CODBEM
		  @nLin,020 PSAY QRY->T9_NOME
		  @nLin,063 PSAY Dtoc(STP->TP_DTLEITU)
		  @nLin,074 PSAY STP->TP_HORA
          @nLin,081 PSAY STP->TP_POSCONT   Picture "@E 999,999,999"
		  @nLin,094 PSAY STP->TP_ACUMCON   Picture "@E 999,999,999"
		  @nLin,109 PSAY nAcum   Picture "@E 999,999,999"
		  @nLin,128 PSAY "Ajuste necessario"
          nLin++                                        
          lAchou:=.T.
          nAcumulado := nAcum
       elseif STP->TP_ACUMCON<>nAcumulado .AND. STP->TP_TIPOLAN=="Q"
		  @nLin,000 PSAY QRY->T9_CODBEM
		  @nLin,020 PSAY QRY->T9_NOME
		  @nLin,063 PSAY Dtoc(STP->TP_DTLEITU)
		  @nLin,074 PSAY STP->TP_HORA
          @nLin,081 PSAY STP->TP_POSCONT   Picture "@E 999,999,999"
		  @nLin,094 PSAY STP->TP_ACUMCON   Picture "@E 999,999,999"
		  @nLin,109 PSAY nAcumulado   Picture "@E 999,999,999"
		  @nLin,128 PSAY "Houve quebra de contador nesta data - ajuste necessario"
          nLin++                                        
          lAchou:=.T.
       else
          nAcumulado := STP->TP_ACUMCON
       endif
       nContador := STP->TP_POSCONT
       DbSkip()
    Enddo
    RestArea(aArea)

    if lAchou
       nLin++                                        
    endif

   dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo
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


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �VALIDPERG � Autor � AP5 IDE            � Data �  17/12/02   ���
�������������������������������������������������������������������������͹��
���Descri��o � Verifica a existencia das perguntas criando-as caso seja   ���
���          � necessario (caso nao existam).                             ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","A Partir Da Data     ?","","","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Do Bem               ?","","","mv_ch2","C",16,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","ST9","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Ate o Bem            ?","","","mv_ch3","C",16,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","ST9","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Do Centro de Custo   ?","","","mv_ch4","C",9,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","CTT","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Ate o Centro de Custo?","","","mv_ch5","C",9,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","CTT","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return

