addi t0, zero, 0
lui t0, 0x80000
addi t0, t0, 0x60
addi t1, zero, 5
sb t1, 0x3(t0)
lb t2, 0x3(t0)
beq t1, t2, succ

addi t3, zero, 1023
sw t3, 0x4(t0)
beq zero, zero, end

succ: 
    addi t3, zero, 1024
    sw t3, 0x4(t0)

end:
    beq zero, zero, end
