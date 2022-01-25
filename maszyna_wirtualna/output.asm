        jump.i  #lab0                   ;jump.i  lab0
lab0:
        div.i   #14,#3,8                ;div.i   14,3,$t0
        add.i   #3,#5,12                ;add.i   3,5,$t1
        mod.i   8,12,16                 ;mod.i   $t0,$t1,$t2
        sub.i   16,#5,20                ;sub.i   $t2,5,$t3
        mov.i   20,0                    ;mov.i   $t3,x
        mul.i   0,#5,24                 ;mul.i   x,5,$t4
        add.i   24,#2,28                ;add.i   $t4,2,$t5
        mov.i   28,4                    ;mov.i   $t5,y
        write.i 4                       ;write.i y
        exit                            ;exit    
