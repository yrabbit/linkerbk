;; vim: set expandtab ai textwidth=80:
                .TITLE  SIMLBL
                .IDENT  /V00.10/
;; Начальный адрес безымянной секции
.=.+1000
Start:          jsr     PC,@140010      ; инициализация монитора
                mov     #30204,R0
                jsr     PC,@140132      ; режим экрана
                mov     #Welcome,R0
                jsr     PC,@140160      ; вывод строки
                jsr     PC,@140076      ; ввод символа
                mov     #Bye,R0
                jsr     PC,@140160      ; вывод второй строки
                jsr     PC,@140076      ; ввод символа
                jmp     @#140000
Welcome:        .ASCIZ  /Very simple MACRO-11 program./
Bye:            .ASCIZ  /Bye./
                .END    Start

