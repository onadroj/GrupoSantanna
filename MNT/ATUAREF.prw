#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ATUAREF   � Autor � GATASSE            � Data �  29/11/04   ���
�������������������������������������������������������������������������͹��
���Descricao � GRAVA REFORMAS E ZERA CONTADOR ACUMULADO PARA BENS FILHOS  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function ATUAREF
Private cCadastro := "Cadastro de Reformas"
Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
             {"Visualizar","AxVisual",0,2} ,;
             {"Incluir","u_ATUAREF1()",0,3} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "SZQ"

dbSelectArea("SZQ")
dbSetOrder(1)
SET FILTER TO ZQ_CODBEM=ST9->T9_CODBEM
dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)
SET FILTER TO 
Return
