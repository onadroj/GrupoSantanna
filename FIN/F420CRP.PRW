#INCLUDE "rwmake.ch" 

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F420CRP   � Autor � EDSON              � Data �  27/05/11   ���
�������������������������������������������������������������������������͹��
���Descricao � ATUALIZA O N�MERO DA �LTIMA REMESSA NAS DEMAIS CONTAS DA   ���
���          � MESMA AGENCIA PARA O BRADESCO NA MEGANOVA                  ���
�������������������������������������������������������������������������͹��
���Uso       � FINANCEIRO                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F420CRP
Local aArea := GetArea()
Local _cUltdsk

If cEmpAnt#"06" .OR. (cEmpAnt=="06" .AND. cBanco#"237")
   Return
Endif

dbSelectArea("SEE")
dbSetOrder(1)
If dbSeek(xFilial("SEE")+cBanco+cAgencia+cConta+cSubCta) 
   _cUltdsk := SEE->EE_ULTDSK
   DbGoTop()
   While !Eof()
     If SEE->EE_CODIGO==cBanco .AND. Alltrim(SEE->EE_AGENCIA)==Alltrim(cAgencia) .AND. Alltrim(SEE->EE_SUBCTA)==cSubCta
        RecLock("SEE",.F.)
        SEE->EE_ULTDSK:=_cUltdsk
        Msunlock()
     Endif
     DbSkip()
   EndDo
Endif
RestArea(aArea)
Return