;; vim: set expandtab ai textwidth=80:
                .TITLE  OVERL
                .IDENT  /V00.11/
                .INCLUDE lib/bk11m/bk11m.inc
                .INCLUDE lib/mkdos/mkdos.inc
                ;.MCALL  AFTER$MKDOS,MKDOS$TAPE
LoadAddr=40000               

;; Все секции начинаются с 0, поэтому нужно смещение
.=.+1000
Start:          AFTER$MKDOS             ; если планируем использовать функции
                                        ; MKDOS
                .BINIT                  ; инициализируем монитор БК11М
                .BSTR   #Prompt
                .BTTIN
                MKDOS$TAPE #TapeParams
                .BSTR   #Loaded
                .BTTIN
                .BEXIT
Prompt:         .ASCIZ  /Press any key to load overlay.../
Loaded:         .ASCIZ  /Overlay loaded./
                .EVEN
TapeParams:     .BYTE   3,0                
                .WORD   41000,0
1$:             .ASCII  /overlay/
                .BLKB   ^D16-<.-1$>
                .BLKB   ^D16+4
                .END    Start

