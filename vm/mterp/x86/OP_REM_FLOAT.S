%verify "executed"
    /* rem_float vAA, vBB, vCC */
    movzbl   3(rPC),%ecx            # ecx<- BB
    movzbl   2(rPC),%eax            # eax<- CC
    flds     (rFP,%ecx,4)           # vCC to fp stack
    flds     (rFP,%eax,4)           # vCC to fp stack
    movzbl   rINST_HI,%ecx         # ecx<- AA
    FETCH_INST_WORD(2)
1:
    fprem
    fstsw     %ax
    sahf
    jp        1b
    fstp      %st(1)
    ADVANCE_PC(2)
    fstps    (rFP,%ecx,4)           # %st to vAA
    GOTO_NEXT
