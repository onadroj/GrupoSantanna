//PROGRAMA PARA CRIACAO DO ITEM CONTABIL 

#include "rwmake.ch"
#include "topconn.ch"

User Function CRIAITEM()

	cCabecalho := OemToAnsi("Atualiza��o do Item Contabil - Fornecedores")
	cMsgRegua  := "Processando..."
	Processa( {|| PrcCtb01()} ,cCabecalho,cMsgRegua )
	cCabecalho := OemToAnsi("Atualiza��o do Item Contabil - Contratos Clientes")
	cMsgRegua  := "Processando..."
	Processa( {|| PrcCtb02()} ,cCabecalho,cMsgRegua )
Return

Static Function PrcCtb01()
*****************************************************************************************************
*
*
****

Local cItemCont := ""

dbSelectArea("SA2")
dbGoTop()

While !Eof()	
	dbSelectArea("CTD")
	dbSetOrder(1)
	dbSeek(xFilial("CTD")+"F"+SA2->A2_COD+SA2->A2_LOJA)	
	If Eof()
		cItemCont := "F"+SA2->A2_COD+SA2->A2_LOJA
		RecLock("CTD",.T.)
		Replace CTD_FILIAL With xFilial("CTD") , ;
		CTD_ITEM   With cItemcont      , ;
		CTD_DESC01 With SA2->A2_NOME   , ;
		CTD_CLASSE With "2"            , ;
		CTD_DTEXIS With CTOD("01/01/1980") , ;
		CTD_BLOQ   With '2'		
		MsUnlock("CTD")
	EndIf
	dbSelectArea("SA2")
	dbSkip()
End

Return


Static Function PrcCtb02()
*****************************************************************************************************
* Criacao do Item Contabil para Contratos - Clientes
*
****

Local cItemCont := ""

dbSelectArea("SA1")
dbGoTop()

While !Eof()
	
	dbSelectArea("CTD")
	dbSetOrder(1)
	dbSeek(xFilial("CTD")+"C"+SA1->A1_COD+SA1->A1_LOJA)
	
	If Eof()
		cItemCont := "C"+SA1->A1_COD+SA1->A1_LOJA
		RecLock("CTD",.T.)
		Replace CTD_FILIAL With xFilial("CTD") , ;
		CTD_ITEM   With cItemcont      , ;
		CTD_DESC01 With SA1->A1_NOME   , ;
		CTD_CLASSE With "2"            , ;
		CTD_DTEXIS With CTOD("01/01/1980") , ;
		CTD_BLOQ   With '2'
		
		MsUnlock("CTD")
	EndIf
	dbSelectArea("SA1")
	dbSkip()
End

Return
