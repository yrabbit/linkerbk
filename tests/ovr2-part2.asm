;; vim: set expandtab ai textwidth=80:
                .TITLE  PART2
                .IDENT  /V01.00/
                .INCLUDE lib/bk11m/bk11m.inc

;; =============================================
;;  Оверлей. 
;;  Содержит подпрограмму SayHi, которая 
;;  выводит на экран строчку.
;; =============================================
                .PSECT  SUBS
SayHi::         .BPRIN  #HiStr
                rts     PC
HiStr:          .ASCIZ  /I'm overlay!/                
                .END 
