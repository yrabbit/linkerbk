;; vim: set expandtab ai textwidth=80:
                ; Общие
                .MCALL  .BINIT,.BEXIT

                ; Драйвер экрана
                .MCALL  .BTSET
                .MCALL  .BSTR,.BPRIN

                ; Драйвер клавиатуры
                .MCALL  .BTTIN

                ; Управление памятью
                .MCALL  .BPAGE,.BMEM,.BJSR,.BWORK
                .MCALL  .BJMP


