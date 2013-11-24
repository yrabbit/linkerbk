;; vim: set expandtab ai textwidth=80:
                .TITLE  SIMLBL
                .IDENT  /V00.10/
;; Все секции начинаются с 0, поэтому нужно смещение
.=.+1000
Start:          jsr     PC,@140010      ; инициализируем монитор БК11М
                mov     #30204,R0
                jsr     PC,@140132      ; дисплей в 80 символов в строке (и пр.)
                mov     #Welcome,R0
                jsr     PC,@140160      ; вывод строки 
                jsr     PC,@140076      ; ожидание нажатия клавиши
                mov     #Bye,R0
                jsr     PC,@140160      ; еще вывод строки
                jsr     PC,@140076      ; еще ожидание нажтия клавиши
                jmp     @#140000        ; reset монитора
Welcome:        .ASCIZ  /Very simple MACRO-11 program./
Bye:            .ASCIZ  /Bye./
                .END    Start

