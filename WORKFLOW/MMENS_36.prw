#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MMENS_36   � Autor � AP6 IDE           � Data �  11/12/14   ���
�������������������������������������������������������������������������͹��
���Descricao �  Programa utilizado para alterar os campos enviados        ��� 
���				no mmessenger de cadastro de fornecedores                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function MMENS_36


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
	local msg
	msg := "Evento 036 - O Fornecedor abaixo acaba de ser incluido no sistema pelo usuario " +cUserName+chr(13)+chr(10)+chr(13)+chr(10)
	msg += ">> Empresa : "+cEmpAnt+chr(13)+chr(10)
	msg += ">> Cod.Fornecedor : "+SA2->A2_COD+" Loja : "+SA2->A2_LOJA+chr(13)+chr(10)
	msg += ">> Razao Social : "+SA2->A2_NOME+chr(13)+chr(10) 
	msg += ">> Nome Reduzido : "+SA2->A2_NREDUZ+chr(13)+chr(10)
	msg += ">> Conta Contabil: " +SA2->A2_CONTA+chr(13)+chr(10) 
	msg += +chr(13)+chr(10)+chr(13)+chr(10)
	msg += ">> E-Mail automatico enviado pelo modulo "+cModulo 
//	msg += ">> Recolhe INSS?: "+SA2->A2_RECINSS+chr(13)+chr(10)
//	msg += ">> Recolhe ISS?: "+SA2->A2_RECISS+chr(13)+chr(10)
//	msg += ">> Recolhe Cofins "+SA2->A2_RECCOFI+chr(13)+chr(10)

Return msg
