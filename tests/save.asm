;; vim: set expandtab ai textwidth=80:
                .TITLE  BUILT
                .IDENT  /V01.00/
                .INCLUDE lib/bk11m/bk11m.inc
                .INCLUDE lib/mkdos/mkdos.inc

                .PSECT  MAIN
;; Все секции начинаются с 0, поэтому нужно смещение
.=.+1000
Start:          AFTER$MKDOS             ; если планируем использовать функции
                                        ; MKDOS
                .BINIT                  ; инициализируем монитор БК11М

                ; подготавливаем распределение памяти ``под себя'',
                ; с 40000 страница 1  --- здесь будет пересылаемая секция
                ; с 100000 страница 2 --- просто так, чтобы там заведомо не было
                ; MKDOS.
                .BPAGE 1,0
                .BPAGE 2,1

                .BTSET  #30204
                .BPRIN  #Prompt
                .BTTIN

                ; пересылаем секцию
                mov     #EndOfMain,R1   ; секция должна начинаться с .LIMIT
                mov     (R1),R2         ; R2 --- начальный адрес для размещения
                                        ; секции
                mov     2(R1),R0        ; R0 --- длина секции 
                sub     R2,R0
                ror     R0
                adc     R0
1$:             mov    (R1)+,(R2)+                
                sob     R0,1$
                ; вызываем функцию из перемещенной секции
                jsr     PC,SayHi

                .BPRIN  #Loaded
                .BTTIN
                BACK$TO$MKDOS           ; назад в MKDOS

Prompt:         .ASCIZ  /Press any key to load overlay.../
Loaded:         .ASCIZ  /Overlay loaded./
                .EVEN
EndOfMain:      ; Это конец основной секции и начало перемешаемой секции
                .END    Start

