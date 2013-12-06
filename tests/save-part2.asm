;; vim: set expandtab ai textwidth=80:
                .TITLE  BUILT2
                .IDENT  /V01.00/
                .INCLUDE lib/bk11m/bk11m.inc

;; Адрес с которого располагается перемещаемая секция
LoadAddr==40000               
;; =============================================
;;  Содержит подпрограмму SayHi, которая 
;;  выводит на экран строчку.
;;  Установлен атрибут SAV.
;; =============================================
                .PSECT  SUBS,SAV
.=.+LoadAddr                
                .LIMIT          ; для автоматического вычисления размеров
                                ; секции
SayHi::         .BPRIN  #HiStr
                rts     PC
HiStr:          .ASCIZ  /I'm overlay!/                
                .END 
