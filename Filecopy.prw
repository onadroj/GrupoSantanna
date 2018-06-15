#INCLUDE "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �filecopy  �Autor  �GATASSE             � Data �  28/09/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �  COPIA ARQUIVOS NO SIGA                                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

USER function filecopy(cSource,cTarget)

local cbuffer,   fOFile, fIFile, nNumRead
cBuffer:=space(512)
fIFile:=fOpen(cSource)
if FError() !=0
	msgstop(cSource +" , nao pode ser aberto! Verifique se o caminho e�valido.")
	return
endif
fOFile:=FCreate(cTarget)
if FError() !=0
	msgstop(cTarget +" , nao pode ser criado! Verifique se o caminho e�valido.")
	return
endif
nNumRead:=FRead(fIFile,@cBuffer,512)
do while nNumRead==512
	FWrite(fOFile, cBuffer,512)
	nNumRead:=FRead(fIFile,@cBuffer,512)
end do
FWrite(FOfile,cBuffer,nNumRead)
FClose(fIFile)
FClose(fOFile)
return

