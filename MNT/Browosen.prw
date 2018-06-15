#include "rwmake.ch"

User Function Browosen()

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    �BROWOSEN  � Autor �EDSON                  � Data �08.03.05  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �TELA DE BROWSE DE OS ENCERRADAS                             ���
���          �                                                            ���
���          �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       �BROWSE                                                      ���
�������������������������������������������������������������������������Ĵ��
���Tabelas   �STJ STL                                                     ���
�������������������������������������������������������������������������Ĵ��
���Modulo    �MANUTENCAO DE ATIVOS                                        ���
��������������������������������������������������������������������������ٱ�
���14/09/11 - Edson - Inclus�o de filtro por equipamento e data           ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Private cCadastro := "OS Encerradas"

Private aRotina   := {{ "Pesquisar" ,"AxPesqui"                     ,0,1},;
                      { "Visualizar","AxVisual"                     ,0,2},;
                      { "Insumos"   ,'ExecBlock("Browinos",.F.,.F.)',0,2},;
                      { "Filtrar"   ,"U_FILTRAOSEN()",0,1},;
                      { "Limpar Filtro"   ,"U_LIMPAFILTROOSEN()",0,1}}

dbSelectArea("STJ")
dbGoTop()
SET FILTER TO STJ->TJ_TERMINO=="S" .AND. STJ->TJ_SITUACA<>"C"
dbGoTop()
dbSetOrder(1)
mBrowse(6,1,22,75,"STJ")
SET FILTER TO

Return

User Function FILTRAOSEN()
Local aPergs := {}
Local cCodRec := space(08)
Local aRet := {} 
Local aBem := CriaVar("TJ_CODBEM")
Local aCond := ""

aAdd( aPergs ,{9,"Informe o c�digo do bem e/ou a data das OS.",150,10,.F.})
aAdd( aPergs ,{1,"Bem : ",aBem,"@!",'.T.',,'.T.',40,.F.})
aAdd( aPergs ,{1,"Data Inicial: ",dDataBase,"99/99/9999",'.T.',,'.T.',40,.F.})
aAdd( aPergs ,{1,"Data Final: ",dDataBase,"99/99/9999",'.T.',,'.T.',40,.F.})

If ParamBox(aPergs ,"Filtrar por... ",aRet)
	dbSelectArea("STJ")
	SET FILTER TO
	dbGoTop()
	aCond:="STJ->TJ_TERMINO=='S' .AND. STJ->TJ_SITUACA<>'C'"
	If !empty(aRet[2])
	    aCond+=" .AND. STJ->TJ_CODBEM=='"+aRet[2]+"'"
	Endif
	If !empty(aRet[3]) .AND. !empty(aRet[4])
	    aCond+=" .AND. (DTOS(STJ->TJ_DTORIGI)>='"+DTOS(aRet[3])+"' .AND. DTOS(STJ->TJ_DTORIGI)<='"+DTOS(aRet[4])+"')"
	Endif
	SET FILTER TO &aCond
	dbGoTop()
	dbSetOrder(1)
EndIf
Return

User Function LIMPAFILTROOSEN()
dbSelectArea("STJ")
SET FILTER TO
dbGoTop()
SET FILTER TO STJ->TJ_TERMINO=="S" .AND. STJ->TJ_SITUACA<>"C"
dbGoTop()
dbSetOrder(1)
Return
