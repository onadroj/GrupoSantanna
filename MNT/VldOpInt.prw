#INCLUDE "rwmake.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VLDOPINT  � Autor � Edson              � Data �  31/10/05   ���
�������������������������������������������������������������������������͹��
���Descricao � VALIDA COMPATIBILIDADE DO CENTRO DE CUSTO DO MOVIMENTO COM ���
���          � O CENTRO DE CUSTO DA OS INFORMADA                          ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function VLDOPINT
local cOrdem:=Substr(M->D3_OP,1,6)
local lOk:=.T.
local cCCusto:=RetField("STJ",1,xFilial("STJ")+cOrdem,"TJ_CCUSTO")

if !("OS" $ M->D3_OP)
   return(.T.)
endif

if cCCusto<>cCC
   MsgStop("Centro de Custo da OS diferente do Centro de Custo desta movimenta��o!")
   lOk:=.F.
endif

Return(lOk)