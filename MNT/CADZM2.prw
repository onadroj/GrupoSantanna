#INCLUDE "rwmake.ch"

/*/
Cadastro de FAIXAS DE mANUTEN��O
   VFX Sistemas 
  F�bio Jose
  Outubro-2010
/*/

User Function CADZM2


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

//Private cPerg   := "1"
Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "ZM2"

dbSelectArea("ZM2")
dbSetOrder(1)

cPerg   := "1"

Pergunte(cPerg,.F.)
SetKey(123,{|| Pergunte(cPerg,.T.)}) // Seta a tecla F12 para acionamento dos parametros

AxCadastro(cString,"fAIXAS DE mANUTEN��ES .",cVldExc,cVldAlt)

Set Key 123 To // Desativa a tecla F12 do acionamento dos parametros


Return
