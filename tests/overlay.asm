;; vim: set expandtab ai textwidth=80:
                .TITLE  OVERL
                .IDENT  /V00.11/
                .INCLUDE lib/bk11m/bk11m.inc
                .INCLUDE lib/mkdos/mkdos.inc

;; Адрес с которого располагается оверлеи                
LoadAddr=100000               

;; Все секции начинаются с 0, поэтому нужно смещение
.=.+1000
Start:          AFTER$MKDOS             ; если планируем использовать функции
                                        ; MKDOS
                .BINIT                  ; инициализируем монитор БК11М

                ; подготавливаем распределение памяти ``под себя'',
                ; с 40000 страница 1  --- просто так.
                ; с 100000 страница 2 --- здесь будут оверлеи.
                .BPAGE 1,0
                .BPAGE 5,1

                .BTSET  #30204
                .BPRIN  #Prompt
                .BTTIN

                ; загружаем оверлей
                MKDOS$TAPE #TapeParams


                .BPRIN  #Loaded
                .BTTIN
                .BEXIT
Prompt:         .ASCIZ  /Press any key to load overlay.../<12>
Loaded:         .ASCIZ  /Overlay loaded./
                .EVEN
TapeParams:     .BYTE   3,0                
                .WORD   LoadAddr,0
1$:             .ASCII  /overlay/
                .BLKB   ^D16-<.-1$>
                .BLKB   ^D16+4
                .END    Start

