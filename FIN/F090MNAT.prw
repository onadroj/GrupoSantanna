#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO18    � Autor � AP6 IDE            � Data �  04/07/14   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F090MNAT   


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
/***
   Este ponto de entrada nao atende pois o usuario nao ter� conhecimtno previo
   se os titulos serao multinatureza ou nao
***/
Local aArea := GetArea()
Local lRet := .F.
If MSGYESNO("Clique em 'Sim' para ja vir marcado o chekbox de rateio por Multi Naturezas ou 'N�o' para vir desmarcado","F090MNAT")	
	lRet := .T.
Endif
RestArea(aArea)
Return lRet
                               
