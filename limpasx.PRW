#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO51    � Autor � AP6 IDE            � Data �  13/06/14   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���                       

�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function limpasx


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local aCampo 
Local i
aCampo := {"B1_CC","C1_CC","C2_CC","C7_CC","D1_CC","E1_CUSTO","E2_CUSTO",;
"E5_CUSTO","E5_CCD","E5_CCC","H1_CCUSTO","H9_CCUSTO","HB_CC","I2_CCD",   ;
"I2_CCC","I3_CCUNID","I9_CCD","I9_CCC","IA_CC","IB_CCC","IB_CCD",        ;
"IC_CCD","IC_CCC","N3_CUSTBEM","N3_CCUSTO","O3_CATIV","OC_CC","P0_CC",   ;
"P2_CC","PB_CC","R1_CC","RC_CC","RE_CCD","RE_CCP","RI_CC","RK_CC",       ;
"RZ_CC","Z8_CUSTO","Z9_CUSTO","ZD_CCD","ZD_CCC","CNB_CC"}
nTam := len(aCampo)

dbSelectArea("SX3")
dbSetOrder(2)                    
for i:= 1 to nTam
	alert("aCampo["+i+"] = "+aCampo[i])
	if dbSeek(xfilial("SX3")+aCampo[i])     
		If reclock("SX3",.F.)
			SX3->X3_VLDUSER := ""
			SX3->(MsUnlock())
		Endif
	Endif	
next

Return
