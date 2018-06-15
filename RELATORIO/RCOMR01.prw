#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RCOMR01   �Autor  � Vin�cius Moreira   � Data � 21/10/2013  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rateio dos lancamentos da folha por centro de custo        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AcademiaERP                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function RCOMR01()
//������������������������������������������Ŀ
//�Declaracao de variaveis                   �
//��������������������������������������������
Private oReport  := Nil
Private oSecCab	 := Nil
//Private cPerg 	 := PadR ("RCOMR01", Len (SX1->X1_GRUPO))
//������������������������������������������Ŀ
//�Criacao e apresentacao das perguntas      �
//��������������������������������������������
//PutSx1(cPerg,"01","C�digo de?"  ,'','',"mv_ch1","C",TamSx3 ("B1_COD")[1] ,0,,"G","","SB1","","","mv_par01","","","","","","","","","","","","","","","","")
//PutSx1(cPerg,"02","C�digo ate?" ,'','',"mv_ch2","C",TamSx3 ("B1_COD")[1] ,0,,"G","","SB1","","","mv_par02","","","","","","","","","","","","","","","","")
//������������������������������������������Ŀ
//�Definicoes/preparacao para impressao      �
//��������������������������������������������
ReportDef()
oReport	:PrintDialog()	

Return Nil
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportDef �Autor  � Vin�cius Moreira   � Data � 21/10/2013  ���
�������������������������������������������������������������������������͹��
���Desc.     � Defini��o da estrutura do relat�rio.                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef()

oReport := TReport():New("RCOMR01","Rateio da Folha",nil,{|oReport| PrintReport(oReport)},"Impress�o do rateio da folha de pagamento.")
oReport:SetLandscape(.T.)

oSecCab := TRSection():New( oReport , "Folha por Centro de Custo", {"QRY"} )
TRCell():New( oSecCab, "RC_CC"     , "QRY")
TRCell():New( oSecCab, "BANCO"    , "QRY")
//TRCell():New( oSecCab, "VALOR"    , "QRY")
TRCell():new(oSecCab, "VALOR", "QRY", 'Valor:'	,PesqPict('SRC',"RC_VALOR"),TamSX3("RC_VALOR")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/)

//TRFunction():New(/*Cell*/             ,/*cId*/,/*Function*/,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,/*Section*/)
TRFunction():New(oSecCab:Cell("VALOR"),/*cId*/,"SUM"     ,/*oBreak*/,/*cTitle*/,"@E 999,999.99",/*uFormula*/,.F.           ,.T.           ,.F.        ,oSecCab)

Return Nil
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RCOMR01   �Autor  � Vin�cius Moreira   � Data � 21/10/2013  ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PrintReport(oReport)

Local cQuery     := ""
//Pergunte(cPerg,.F.)

cQuery:="SELECT SUBSTRING(RA_BCDEPSA,1,3) AS BANCO, RC_CC,SUM(RC_VALOR) AS VALOR FROM "     
cQuery+=RETSQLNAME("SRC")+" SRC ,"
cQuery+=RETSQLNAME("SRA")+" SRA "
cQuery+="WHERE RC_PD = '799' AND RA_MAT = RC_MAT "
cQuery+="AND SRC.D_E_L_E_T_ <> '*' "
cQuery+="GROUP BY SUBSTRING(RA_BCDEPSA,1,3), RC_CC "
cQuery+="ORDER BY BANCO "

If Select("QRY") > 0
	Dbselectarea("QRY")
	QRY->(DbClosearea())
EndIf

TcQuery cQuery New Alias "QRY"

oSecCab:BeginQuery()
oSecCab:EndQuery({{"QRY"},cQuery})    
oSecCab:Print()

Return Nil