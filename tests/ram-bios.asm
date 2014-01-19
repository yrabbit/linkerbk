;; vim: set expandtab ai textwidth=80:
                .TITLE  RAMBS
                .IDENT  /V00.10/
                .INCLUDE lib/bk11m/bk11m.inc
                .INCLUDE lib/ram-bios/ram-bios.inc
                .INCLUDE lib/mkdos/mkdos.inc

                .PSECT  MAINPS
.=.+1000        ;; Все секции начинаются с 0, поэтому нужно смещение
Start:          AFTER$MKDOS
                .BINIT                  ; инициализируем монитор БК11М
                .BTSET  #30204          ; дисплей в 80 символов в строке (и пр.)

                .BPRIN   #HelloStr
                .BTTIN                  ; ожидание нажатия клавиши

                ; Запрашиваем и выводим на экран некоторые
                ; параметры RAM-BIOS
                CAT$    #GetVersion     ; запросить версию RAM-BIOS
                mov     R1,-(SP)
                mov     R2,-(SP)
                mov     #NumberBuf,R1
                mov     R1,R4
                jsr     PC,ToStr
                .BSTR   #VersionStr
                .BPRIN  R4
                mov     R4,R1
                mov     (SP)+,R0
                jsr     PC,ToStr
                .BSTR   #NumRecordsStr
                .BPRIN  R4
                mov     R4,R1
                mov     (SP)+,R0
                jsr     PC,ToStr
                .BSTR   #CatalogAddrStr
                .BPRIN  R4
                ; Добавляем первый программный модуль
                mov     #Module,R1
                clr     R2
                mov     #"CY,Cat.Name(R1)
                mov     #<YCodeEnd-YCode>/2+1,Cat.Len(R1)
                mov     #<Cat.Flags.NoSplit!Cat.Flags.Run!Cat.Flags.Del>,Cat.Flags(R1)
                CAT$    #CreateModule
                ; Читаем смещение в сегменте добавленного модуля
                CAT$    #ReadWriteCatRecord
                .WORD   "CY,Cat.Off
                mov     R1,R0
                mov     R4,R1
                jsr     PC,ToStr
                .BSTR   #SegmentOffStr
                .BPRIN  R4

                ; Добавляем второй программный модуль
                mov     #Module,R1
                clr     R2
                mov     #"DY,Cat.Name(R1)
                mov     #<YCodeEnd-YCode>/2+1,Cat.Len(R1)
                mov     #<Cat.Flags.NoSplit!Cat.Flags.Run!Cat.Flags.Del>,Cat.Flags(R1)
                CAT$    #CreateModule
                ; Читаем смещение в сегменте добавленного модуля
                CAT$    #ReadWriteCatRecord
                .WORD   "DY,Cat.Off
                mov     R1,R0
                mov     R4,R1
                jsr     PC,ToStr
                .BSTR   #SegmentOffStr
                .BPRIN  R4

                ; Пересылка подпрограммы в оба модуля
                MOV$G   NASEG.Current,#YCode,"CY,0,<#YCodeEnd-YCode>/2+1
                MOV$G   NASEG.Current,#YCode,"DY,0,<#YCodeEnd-YCode>/2+1

                ; Прочитать первое слово из второго модуля
                clr     R0
                mov     PC,R1
                CHW$G   0,"DY
                mov     R4,R1
                jsr     PC,ToStr
                .BSTR   #WordStr
                .BPRIN  R4

                ; Выполняем обе подпрограммы
                mov     #123,R3
                CAL$G   0,"CY
                mov     #346,R3
                CAL$G   0,"DY

                ; Забираем результаты
                MOV$G   "CY,#Pic-YCode,NASEG.Current,#60000,#PicSize/2
                MOV$G   "DY,#Pic-YCode,NASEG.Current,#PicSize+60000,#PicSize/2

                ; Удаляем модули
                mov     #"CY,R1
                CAT$    #DeleteModule
                mov     #"DY,R1
                CAT$    #DeleteModule
                .BTTIN

                BACK$TO$MKDOS  RAM
                EXIT$

Module:         .BLKB   20              ; данные добавляемого модуля
HelloStr:       .ASCIZ  /Ask RAM-BIOS.../
VersionStr:     .ASCIZ  /Version: /
NumRecordsStr:  .ASCIZ  /Number of catalog records: /
CatalogAddrStr: .ASCIZ  /Address of catalog: /
SegmentOffStr:  .ASCIZ  /Offset in the segment: /
LogSegStr:      .ASCIZ  /Logical segment number: /
WordStr:        .ASCIZ  /First word of module: /
NumberBuf:      .BLKB   7
                .EVEN
; Перевод числа из R0 с строку восьмеричных цифр в буфере R1
ToStr:          mov     #5,R2
                add     R2,R1
                inc     R1
                clrb    (R1)
1$:                          
                movb    R0,-(R1)
                bicb    #370,(R1)
                bisb    #'0,(R1)
                ror     R0
                ror     R0
                ror     R0
                sob     R2,1$
                bicb    #376,R0
                bisb    #'0,R0
                movb    R0,-(R1)
                rts     PC

; Подпрограмма, помещаемая в память SMK и выполняющаяся прямо в этой памяти.
; 
PicSize=2400*2  ; память, занятная картинкой
YCode:          mov     PC,R1
                add     #Pic - .,R1
                mov     #PicSize,R0
1$:             movb    R3,(R1)+
                sob     R0,1$
                rts     PC
Pic:            .BLKB   PicSize
YCodeEnd:                
                .END    Start

