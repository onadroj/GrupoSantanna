#include "rwmake.ch"

User Function Gera769()



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    �Gera769  � Autor �MAURICIO/GATASSE       � Data �13.07.00  ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �ROTEIRO DE CALCULO FOL 304, UTILIZADO PARA GERAR A VERBA 769���
���          �NA FOLHA DE PAGAMENTO                                       ���
���          �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       �GERAVERBA 769            ���
�������������������������������������������������������������������������Ĵ��
���Tabelas   �SRV e SRM                                                 ���
�������������������������������������������������������������������������Ĵ��
���Modulo    �GESTAO PESSOAL                                              ���
��������������������������������������������������������������������������ٱ�
���Ultima altera��o: 02/11/2001 - removida a verifica��o da empresa 01 pois��
���   o sistema estava ficando desposicionado no SIGAMAT.EMP               ��
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

cAlias := Alias()
nOrd := IndexOrd()
cRec := Recno()


Val761 := (fBuscaPD("703,704,709,710","V",)*0.2) //  kdkdkd
Val727 := (fBuscaPD("703,704,709,710","V",)*0.03)  // dkdkdk
Val768 := (fBuscaPD("703,704,709,710","V",)*0.058)
//Do Case
//   Case SM0->M0_Codigo == "01"
//	   Val768 := ((fBuscaPD("703,704,709,710","V",)*0.058-((fBuscaPD("703,704,709,710","V",)*0.01))-((fBuscaPD("703,704,709,710","V",)*0.015))-((fBuscaPD("703,704,709,710","V",)*0.025))))
//   Case SM0->M0_Codigo <> "01"
//		Val768 := (fBuscaPD("703,704,709,710","V",)*0.058)
//EndCase


resultado := Round((((Val761+Val727+Val768)+((-1)*fBuscaPD("401,402,403","V",))-fBuscaPD("109","V",)+(fBuscaPD("145,147","V",)*0.2))),2)

fGeraVerba("769",resultado,,,,,,,,,.T. )

dbSelectArea(cAlias)
dbSetOrder(nOrd)
dbGoTo(cRec)  

return(.t.)