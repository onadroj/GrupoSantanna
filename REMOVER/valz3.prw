#include "rwmake.ch"

User Function VALZ3(nTipo)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � VALZ3  � Autor � EDSON                   � Data � 20.07.09 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Valida inclus�o, altera��o e exclus�o do cadastro de       ���
���          � Liberadores Border�s de Pagamentos                         ���
���          �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � FINANCEIRO                                                 ���
�������������������������������������������������������������������������Ĵ��
���Tabelas   � SZ3                                                        ���
�������������������������������������������������������������������������Ĵ��
���Modulo    � FINANCEIRO                                                 ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Local lRetorno := .T.
Local cCod, cCateg, cAtivo, cCodsis 

aAreaX := GetArea()

If nTipo == 1
   MsgStop("Este cadastro n�o permite exclus�o de registros." + chr(13) ;
           + "Utilize o campo Ativo, para desabilitar o usu�rio!")
   lRetorno := .F.
Else
   cCod := M->Z3_CODIGO
   cCateg := M->Z3_CATEG  
   cAtivo := M->Z3_ATIVO
   cCodsis := M->Z3_CODSIS
   
   DbSelectArea("SZ3")
   DbSetOrder(1)
   DbGoTop()
   While ! EOF()
      If SZ3->Z3_CODIGO <> cCod .AND. SZ3->Z3_CODSIS == cCodsis
         MsgStop("Usu�rio j� cadastrado!") 
         lRetorno := .F.
         Exit
      ElseIf cCateg <> "A" .AND. cAtivo == "S"
         If SZ3->Z3_CODIGO <> cCod .AND. SZ3->Z3_CATEG == cCateg .AND. SZ3->Z3_ATIVO == "S"
            MsgStop("Existe outro usu�rio ativo na mesma categoria." + chr(13) ;
                    + "S� � permitido um usu�rio ativo nesta categoria!") 
            lRetorno := .F.
            Exit 
         End If             
      End If
      DbSkip()
   End
End If

RestArea(aAreaX)
Return(lRetorno)
