;; vim: set expandtab ai textwidth=80:
                .TITLE  OVRTST
                .IDENT  /V00.11/
                .INCLUDE lib/bk11m/bk11m.inc
                .INCLUDE lib/mkdos/mkdos.inc

;; Адрес с которого располагается оверлеи                
LoadAddr=40000               

;; Все секции начинаются с 0, поэтому нужно смещение
.=.+1000
Start:          AFTER$MKDOS             ; если планируем использовать функции
                                        ; MKDOS
                .BINIT                  ; инициализируем монитор БК11М

                ; подготавливаем распределение памяти ``под себя'',
                ; с 40000 страница 1  --- здесь будут оверлеи
                ; с 100000 страница 2 --- просто так, чтобы там заведомо не было
                ; MKDOS.
                .BPAGE 1,0
                .BPAGE 2,1

                .BTSET  #30204
                .BPRIN  #Prompt
                .BTTIN

                ; загружаем оверлей
                MKDOS$TAPE #TapeParams

                ; вызываем функцию из оверлея
                jsr     PC,SayHi


                .BPRIN  #Loaded
                .BTTIN
                BACK$TO$MKDOS

Prompt:         .ASCIZ  /Press any key to load overlay.../
Loaded:         .ASCIZ  /Overlay loaded./
                .EVEN
TapeParams:     .BYTE   3,0                
                .WORD   LoadAddr,0
1$:             .ASCII  /overlay-SUBS.v/
                .BLKB   ^D16-<.-1$>
                .BLKB   ^D16+4

;; ==========
;;  Оверлей. 
;; ==========
                .PSECT  SUBS
.=.+LoadAddr                
SayHi:          .BPRIN  #HiStr
                rts     PC
HiStr:          .ASCIZ  /I'm overlay!/                
                .END    Start

