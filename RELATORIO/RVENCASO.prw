#Include "PROTHEUS.ch"

User Function RVENCASO()     
PRIVATE titulo		:= "" 
PRIVATE nomeprog	:= "TESTE"
PRIVATE aSelFil		:= {} 
PRIVATE cPerg		:= "_VENCASO" 

ValidPerg()

RVENCASOR4()

Return


Static Function RVENCASOR4()         
Local aArea := GetArea()

Pergunte(cPerg,.T.)

oReport := ReportDef()      

IF ValType( oReport ) == "O"
	oReport :PrintDialog()      
ENDIF
        
RestArea(aArea) 

Return                                


Static Function ReportDef() 
Local oReport
local aArea	   		:= GetArea()   
Local cReport		:= "Rela��o de ASOs a vencer"
Local cTitulo		:= "ASOs a vencer no m�s seguinte"				   			 
Local cDesc			:= "Este programa ira imprimir a rela��o de ASOs a vencer no m�s seguinte"	  		 

PRIVATE cPerg		:= "_VENCASO"		   


//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//��������������������������������������������������������������������������

oReport	:= TReport():New( cReport,cTitulo,cPerg, { |oReport| ReportPrint( oReport ) }, cDesc ) 
oReport:SetPortrait(.T.)
oReport:ParamReadOnly()

//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da se�ao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se��o.                   �
//�ExpA4 : Array com as Ordens do relat�rio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
oSection0  := TRSection():New( oReport, "Funcion�rios", {"SRA"},, .F., .F. )	  

TRCell():New( oSection0, "RA_CC"     , "SRA","C.CUSTO"/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)  
TRCell():New( oSection0, "RA_MAT"    , "SRA","MATRICULA"/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)  
TRCell():New( oSection0, "RA_NOME"   , "SRA","NOME"/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)  
TRCell():New( oSection0, "DSFUNC"    ,,"FUN��O"/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"LEFT",,"LEFT") //RJ_DESC 
TRCell():New( oSection0, "RA_EXAMEDI", "SRA","VENC.EXAME"/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/) 
TRCell():New( oSection0, "DSSIT"     ,,"SITUA��O"/*Titulo*/,/*Picture*/,55/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"LEFT",,"LEFT") //X5_DESCRI

oreport:DisableOrientation()

Return(oReport)

Static Function ReportPrint( oReport )
Local oSection0 	:= oReport:Section(1)
Local cQuery		:= "SRA"

cFil := xFilial("SRA")

_Ano := Year(MsDate())
_Mes := Month(MsDate())
_Mes += 1
If _Mes == 13
	_Mes := 1
	_Ano += 1
Endif        

Titulo = "RELA��O DE ASOs A VENCER EM "+Upper(MesExtenso(_Mes))+" / "+Alltrim(Str(_Ano))

oReport:SetCustomText({|| CtCGCCabTR(,,,,,dDataBase,titulo,,,,,oReport)} )

cFilter := "SRA->RA_FILIAL=='"+cFil+"' .and. "
cFilter += "SRA->RA_SITFOLH<>'D' .and. "
cFilter += "SRA->RA_CC >= '"+mv_par01+"' .and. SRA->RA_CC <= '"+mv_par02+"' .and. "
cFilter += "Substr(DTOS(SRA->RA_EXAMEDI),1,6)== '"+Alltrim(Str(_Ano))+Strzero(_Mes,2)+"' "

SRA->(DbSetOrder(2)) //RA_FILIAL+RA_CC+RA_MAT
SRA->(DbGotop())

oSection0:SetFilter( cFilter )

/*
oBreak2 := TRBreak():New( oSection0, {|| SRA->RA_CC } )
oBreak2:SetPageBreak(.T.)
*/

oSection0:Cell("DSFUNC"):SetBlock( { || RetField("SRJ",1,xFilial("SRJ")+SRA->RA_CODFUNC,"RJ_DESC") } )
oSection0:Cell("DSSIT"):SetBlock( { || RetField("SX5",1,xFilial("SX5")+"31"+SRA->RA_SITFOLH,"X5_DESCRI") } )

oSection0:Print()

oReport:IncMeter()

Return
                     
Static Function ValidPerg
cPerg := PADR(cPerg,10)

//PutSx1(cGrupo,cOrdem,cPergunt,cPerSpa,cPerEng,cVar,cTipo,nTamanho,nDecimal,nPresel,cGSC,cValid,cF3,cGrpSxg,cPyme,cVar01,cDef01,cDefSpa1,cDefEng1,cCnt01,cDef02,cDefSpa2,cDefEng2,cDef03,cDefSpa3,cDefEng3,cDef04,cDefSpa4,cDefEng4,cDef05,cDefSpa5,cDefEng5,aHelpPor,aHelpEng,aHelpSpa,cHelp)
PutSx1(cPerg,"01","Do Centro de Custo   ?","Do Centro de Custo   ?","Do Centro de Custo   ?","mv_ch1","C",9,0,0,"G","","_CT","","","mv_par01","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Ate Centro de Custo  ?","Ate Centro de Custo  ?","Ate Centro de Custo  ?","mv_ch2","C",9,0,0,"G","","_CT","","","mv_par02","","","","","","","","","","","","","","","","")

Return

Static Function Scheddef()
Local _aParam
Local aOrd := {}

_aParam := {"R",;        //Tipo R para relatorio P para processo   
			"_VENCASO",;		// Pergunte do relatorio, caso nao use passar ParamDef            
			"SRA",;  	// Alias            
			aOrd,;   	//Array de ordens   
			"ASOs a vencer."}    

Return(_aParam)