#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT103LRAT     � Autor � AP6 IDE        � Data �  15/01/15   ���
�������������������������������������������������������������������������͹��
���Descricao � Este ponto de entrada est� localizado na fun��o NfeRatCC e ���
���          � permite indicar se os campos: Centro de Custo, Conta       ���
���          � Cont�bil, Item da Conta e Classe de Valor  permaneceram    ���
���          � preenchidos no acols, mesmo quando for utilizado o Rateio  ���
���          � de Centro de Custo por Item. 							  ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function MT103LRAT() 

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
Local lRet  := .T.
Local aHSDE := PARAMIXB[1]
Local aISDe := PARAMIXB[2]
//Valida��es
//Retorno
lRet:=MSGYESNO("Limpa os campos: Centro de Custo, Conta Cont�bil, Item da Conta e Classe de Valor do Acols ? ")
RETURN lRet


Return
