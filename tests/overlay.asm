;; vim: set expandtab ai textwidth=80:
                .TITLE  OVERL
                .IDENT  /V00.11/
                .MCALL  .BINIT,.BEXIT
                .MCALL  AFTER$MKDOS,MKDOS$TAPE
LoadAddr=40000               

;; Все секции начинаются с 0, поэтому нужно смещение
.=.+1000
Start:          AFTER$MKDOS             ; если планируем использовать функции
                                        ; MKDOS
                .BINIT                  ; инициализируем монитор БК11М
                MKDOS$TAPE #TapeParams
                .BEXIT
                .EVEN
TapeParams:     .BLKB   3,0                
                .END    Start

