#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT103INF  � Autor � GATASSE            � Data �  24/01/05   ���
�������������������������������������������������������������������������͹��
���Descricao � PONTO DE ENTRADA AO RECUPERAR O ITEM DA NF ORIGEM          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � SD2 JA POSICIONADO. UTILIZADO PARA BUSCAR CONTA E CC       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function MT103INF      
LOCAL NPOS1:=AScan(aHeader,{|aItem| AllTrim(aItem[2]) == "D1_CONTA"})
LOCAL NPOS2:=AScan(aHeader,{|aItem| AllTrim(aItem[2]) == "D1_CC"})
///LOCAL NPOS3:=AScan(aHeader,{|aItem| AllTrim(aItem[2]) == "D1_CCUNID"})
acols[n,NPOS1]:=SD2->D2_CONTA
acols[n,NPOS2]:=SD2->D2_CUSTO
//acols[n,NPOS3]:=SD2->D2_CCUNID
Return
