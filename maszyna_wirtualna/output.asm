        jump.i  #lab0                   ;jump.i  lab0
lab0:
        sub.i   #5,#2,8                 ;sub.i   5,2,$t0
        mov.i   8,0                     ;mov.i   $t0,x
        sub.i   #0,0,12                 ;sub.i   0,x,$t1
        mov.i   12,4                    ;mov.i   $t1,y
        write.i 0                       ;write.i x
        exit                            ;exit    
