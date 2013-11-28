;; vim: set expandtab ai textwidth=80:
                .TITLE  TSTAB2
                .IDENT  /V00.11/
                .INCLUDE lib/bk11m/bk11m.inc

                ;; Вектор прерывания от клавиатуры
KeyboardVect=60
KeyboardPSW=KeyboardVect+2

.=.+1000        ;; Все секции начинаются с 0, поэтому нужно смещение
Start:          .BINIT                  ; инициализируем монитор БК11М
                .BTSET  #30204          ; дисплей в 80 символов в строке (и пр.)

                .BPRIN   #HelloStr
                ;; Запоминаем старый обработчик клавиатуры
                mov     @#KeyboardVect,OldHandler
                mov     @#KeyboardPSW,OldHandler+2

                ;; <<Тут установка нового обработчика и какая-то программа>>

                .BTTIN                  ; ожидание нажатия клавиши
                .BEXIT                  ; выход
OldHandler:     .BLKW   2               ; место под данные старого обработчика
                                        ; клавиатуры
HelloStr:       .ASCIZ  /Hi, there! :)/                                        
                .END    Start

