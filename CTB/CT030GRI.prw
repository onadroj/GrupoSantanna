#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CT030GRI  � Autor � AP6 IDE            � Data �  07/10/09   ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de Entrada apos gravar centro de custo               ���
���          � Serve para alterar SI3                                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CT030GRI


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

RecLock("SI3")
Replace I3_ENDER	With CTT->CTT_ENDER
Replace I3_NOME		With CTT->CTT_NOME
Replace I3_ENDER	With CTT->CTT_ENDER
Replace I3_BAIRRO	With CTT->CTT_BAIRRO
Replace I3_CEP		With CTT->CTT_CEP
Replace I3_MUNICIP	With CTT->CTT_MUNICI
Replace I3_ESTADO	With CTT->CTT_ESTADO
Replace I3_TIPO	  	With CTT->CTT_TIPO
Replace I3_CEI		With CTT->CTT_CEI
Replace I3_ENDEREC	With CTT->CTT_ENDER
Replace I3_VALFAT	With CTT->CTT_VALFAT
Replace I3_RETIDO	With CTT->CTT_RETIDO
MSUNLOCK()

Return
