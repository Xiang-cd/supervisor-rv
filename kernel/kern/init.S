#include <common.h>
#include <exception.h>
#include <serial.h>

    .section .bss
    .p2align 2

    // TCBT = Thread Control Block Table
    .global TCBT
TCBT:
    .dword 0
    .dword 0

    // 当前线程 TCB 地址
    .global current
current:
    .dword 0

    // 页表
#ifdef ENABLE_PAGING
    .section .data
    .global PAGE_TABLE
    // 一个页 4096 字节 = 2^12
    .p2align 12
    // 预留空间，在之后的代码里进行初始化
PAGE_TABLE:
    .rept 1024
    .long 0
    .endr

    // RV64 的 Sv39 下页表比 Sv32 多了一级
#ifdef RV64
PAGE_TABLE_2:
    .rept 1024
    .long 0
    .endr
#endif

    // 用户代码的页表
PAGE_TABLE_USER_CODE:
    .rept 1024
    .long 0
    .endr

#ifdef RV64
PAGE_TABLE_USER_CODE_2:
    .rept 1024
    .long 0
    .endr
#endif

    // 内核代码的页表
PAGE_TABLE_KERNEL_CODE:
#ifdef RV32
    .long 0x200000fb                // 0x80000000 -> 0x80000000 DAGUX-RV
    .long 0x200004fb                // 0x80001000 -> 0x80001000 DAGUX-RV
    .rept 254
    .long 0
    .endr
    .long 0x200400fb                // 0x80000000 -> 0x80100000 DAGUX-RV
    .rept 767
    .long 0
    .endr
#else
    .dword 0x200000fb                // 0x80000000 -> 0x80000000 DAGUX-RV
    .rept 511
    .dword 0
    .endr
#endif

    // 用户栈的页表
PAGE_TABLE_USER_STACK:
    .rept 1024
    .long 0
    .endr
#ifdef RV64
PAGE_TABLE_USER_STACK_2:
    .rept 1024
    .long 0
    .endr
#endif
PAGE_TABLE_USER_STACK_3:
    .rept 1024
    .long 0
    .endr
#endif

    .section .rodata
    // 启动时输出的信息
monitor_version:
    .asciz "O."

    .text
    .p2align 2

    .global START
START:
    // 清空 BSS
    // _sbss 和 _ebss 在 ld script 中定义
    la s10, _sbss
    la s11, _ebss
# bss_init:
#     beq s10, s11, bss_init_done
#     sw  zero, 0(s10)
#     addi s10, s10, 4
#     j   bss_init
bss_init_done:

#ifdef ENABLE_INT
    // 设置异常处理地址寄存器 mtvec
    la s0, EXCEPTION_HANDLER
    csrw mtvec, s0

    // 判断是否设置成功（mtvec 是 WARL）
    csrr t0, mtvec
    beq t0, s0, mtvec_done

    // 不成功，尝试 MODE=VECTORED
    la s0, VECTORED_EXCEPTION_HANDLER
    ori s0, s0, 1
    csrw mtvec, s0
mtvec_done:

    // 打开时钟中断
    li t0, MIE_MTIE
    csrw mie, t0
#endif

    // 设置内核栈
    la sp, KERNEL_STACK_INIT

    // 设置用户栈
    li t0, USER_STACK_INIT
    // 设置用户态程序的 sp(x2) 和 fp(x8) 寄存器
    // uregs_sp 和 uregs_fp 在 ld script 中定义
    la t1, uregs_sp
    STORE t0, 0(t1)
    la t1, uregs_fp
    STORE t0, 0(t1)

#ifdef ENABLE_UART16550
    // 配置串口，见 serial.h 中的叙述进行配置
    li t0, COM1
    // 打开 FIFO，并且清空 FIFO
    li t1, COM_FCR_CONFIG 
    sb t1, %lo(COM_FCR_OFFSET)(t0)
    // 打开 DLAB
    li t1, COM_LCR_DLAB
    sb t1, %lo(COM_LCR_OFFSET)(t0)
    // 设置 Baudrate
    li t1, COM_DLL_VAL
    sb t1, %lo(COM_DLL_OFFSET)(t0)
    sb x0, %lo(COM_DLM_OFFSET)(t0)
    // 关闭 DLAB，打开 WLEN8
    li t1, COM_LCR_CONFIG
    sb t1, %lo(COM_LCR_OFFSET)(t0)
    sb x0, %lo(COM_MCR_OFFSET)(t0)
    // 打开串口中断
    li t1, COM_IER_RDI
    sb t1, %lo(COM_IER_OFFSET)(t0)
#endif

    // 从内核栈顶清空并留出 TF_SIZE 大小的空间用于存储中断帧
    # li t0, TF_SIZE
    li t0, 32*4
.LC0:
    addi t0, t0, -XLEN
    addi sp, sp, -XLEN
    STORE zero, 0(sp)
    bne t0, zero, .LC0

    // 保存中断帧地址到 TCBT
    la t0, TCBT
    STORE sp, 0(t0)

    // t6 保存 idle 中断帧位置
    mv t6, sp

    // 初始化栈空间
    # li t0, TF_SIZE
    li t0, 32*4
.LC1:
    addi t0, t0, -XLEN
    addi sp, sp, -XLEN
    STORE zero, 0(sp)
    bne t0, zero, .LC1

    // 载入TCBT地址
    la t0, TCBT
    // thread1(shell/user) 的中断帧地址设置
    STORE sp, XLEN(t0)
    // 设置 idle 线程栈指针(调试用?)
    STORE sp, TF_sp(t6)

    // 取得 thread1 的 TCB 地址
    la t2, TCBT + XLEN
    LOAD t2, 0(t2)

#ifdef ENABLE_INT
    // 设置当前线程为 thread1
    csrw mscratch, t2
#endif

    la t1, current
    sw t2, 0(t1)



#ifdef ENABLE_INT
    // 设置 PMP Config
#ifdef RV32
    // 0x00000000-0xffffffff RWX
    li t0, 0b00001111
    csrw pmpcfg0, t0
    li t0, 0xffffffff
    csrw pmpaddr0, t0
#else
    // 0x0000000000000000-0xffffffffffffffff RWX
    li t0, 0b00001111
    csrw pmpcfg0, t0
    li t0, 0xffffffffffffffff
    csrw pmpaddr0, t0
#endif
#endif

    // 进入主线程
    j WELCOME

WELCOME:
    // 装入启动信息并打印

    // 开始交互
    j SHELL