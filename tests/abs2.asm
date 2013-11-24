;; vim: set expandtab ai textwidth=80:
                .TITLE  TSTAB2
                .IDENT  /V00.11/
                KeyboardVect=60
                KeyboardPSW=KeyboardVect+2
;; Все секции начинаются с 0, поэтому нужно смещение
.=.+1000
Start:          jsr     PC,@140010      ; инициализируем монитор БК11М
                mov     #30204,R0
                jsr     PC,@140132      ; дисплей в 80 символов в строке (и пр.)

                ;; Запоминаем старый обработчик клавиатуры
                mov     @#KeyboardVect,OldHandler
                mov     @#KeyboardPSW,OldHandler+2

                ;; <<Тут установка нового обработчика и какая-то программа>>

                jsr     PC,@140076      ; ожидание нажатия клавиши
                jmp     @#140000        ; reset монитора
OldHandler:     .BLKW   2               ; место под данные старого обработчика
                                        ; клавиатуры
                .END    Start

