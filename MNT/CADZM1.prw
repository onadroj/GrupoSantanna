#INCLUDE "rwmake.ch"

/*/
Cadastro de Ocorrencias
   VFX Sistemas 
  Fábio Jose
  Outubro-2010
/*/

User Function CADZM1


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Private cPerg   := "1"
Local cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
Local cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "ZM1"

dbSelectArea("ZM1")
dbSetOrder(1)

cPerg   := "1"

Pergunte(cPerg,.F.)
SetKey(123,{|| Pergunte(cPerg,.T.)}) // Seta a tecla F12 para acionamento dos parametros

AxCadastro(cString,"Ocorrencias com equipamentos . . .",cVldExc,cVldAlt)

Set Key 123 To // Desativa a tecla F12 do acionamento dos parametros


Return
