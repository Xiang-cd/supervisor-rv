
.\kernel.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <INITLOCATE>:
80000000:	00000d17          	auipc	s10,0x0
80000004:	00cd0d13          	addi	s10,s10,12 # 8000000c <START>
80000008:	000d0067          	jr	s10

8000000c <START>:
8000000c:	007f0d17          	auipc	s10,0x7f0
80000010:	ff4d0d13          	addi	s10,s10,-12 # 807f0000 <_sbss>
80000014:	007f0d97          	auipc	s11,0x7f0
80000018:	104d8d93          	addi	s11,s11,260 # 807f0118 <_ebss>

8000001c <bss_init_done>:
8000001c:	00000417          	auipc	s0,0x0
80000020:	2e440413          	addi	s0,s0,740 # 80000300 <EXCEPTION_HANDLER>
80000024:	30541073          	csrw	mtvec,s0
80000028:	305022f3          	csrr	t0,mtvec
8000002c:	00828a63          	beq	t0,s0,80000040 <mtvec_done>
80000030:	00000417          	auipc	s0,0x0
80000034:	4d040413          	addi	s0,s0,1232 # 80000500 <VECTORED_EXCEPTION_HANDLER>
80000038:	00146413          	ori	s0,s0,1
8000003c:	30541073          	csrw	mtvec,s0

80000040 <mtvec_done>:
80000040:	08000293          	li	t0,128
80000044:	30429073          	csrw	mie,t0
80000048:	00800117          	auipc	sp,0x800
8000004c:	fb810113          	addi	sp,sp,-72 # 80800000 <KERNEL_STACK_INIT>
80000050:	807f02b7          	lui	t0,0x807f0
80000054:	007f0317          	auipc	t1,0x7f0
80000058:	fb030313          	addi	t1,t1,-80 # 807f0004 <uregs_sp>
8000005c:	00532023          	sw	t0,0(t1)
80000060:	007f0317          	auipc	t1,0x7f0
80000064:	fbc30313          	addi	t1,t1,-68 # 807f001c <uregs_fp>
80000068:	00532023          	sw	t0,0(t1)
8000006c:	100002b7          	lui	t0,0x10000
80000070:	00700313          	li	t1,7
80000074:	00628123          	sb	t1,2(t0) # 10000002 <INITLOCATE-0x6ffffffe>
80000078:	08000313          	li	t1,128
8000007c:	006281a3          	sb	t1,3(t0)
80000080:	00c00313          	li	t1,12
80000084:	00628023          	sb	t1,0(t0)
80000088:	000280a3          	sb	zero,1(t0)
8000008c:	00300313          	li	t1,3
80000090:	006281a3          	sb	t1,3(t0)
80000094:	00028223          	sb	zero,4(t0)
80000098:	00100313          	li	t1,1
8000009c:	006280a3          	sb	t1,1(t0)
800000a0:	08000293          	li	t0,128
800000a4:	ffc28293          	addi	t0,t0,-4
800000a8:	ffc10113          	addi	sp,sp,-4
800000ac:	00012023          	sw	zero,0(sp)
800000b0:	fe029ae3          	bnez	t0,800000a4 <mtvec_done+0x64>
800000b4:	007f0297          	auipc	t0,0x7f0
800000b8:	04c28293          	addi	t0,t0,76 # 807f0100 <TCBT>
800000bc:	0022a023          	sw	sp,0(t0)
800000c0:	00010f93          	mv	t6,sp
800000c4:	08000293          	li	t0,128
800000c8:	ffc28293          	addi	t0,t0,-4
800000cc:	ffc10113          	addi	sp,sp,-4
800000d0:	00012023          	sw	zero,0(sp)
800000d4:	fe029ae3          	bnez	t0,800000c8 <mtvec_done+0x88>
800000d8:	007f0297          	auipc	t0,0x7f0
800000dc:	02828293          	addi	t0,t0,40 # 807f0100 <TCBT>
800000e0:	0022a223          	sw	sp,4(t0)
800000e4:	002fa223          	sw	sp,4(t6)
800000e8:	007f0397          	auipc	t2,0x7f0
800000ec:	01c38393          	addi	t2,t2,28 # 807f0104 <TCBT+0x4>
800000f0:	0003a383          	lw	t2,0(t2)
800000f4:	34039073          	csrw	mscratch,t2
800000f8:	007f0317          	auipc	t1,0x7f0
800000fc:	01830313          	addi	t1,t1,24 # 807f0110 <current>
80000100:	00732023          	sw	t2,0(t1)
80000104:	00f00293          	li	t0,15
80000108:	3a029073          	csrw	pmpcfg0,t0
8000010c:	fff00293          	li	t0,-1
80000110:	3b029073          	csrw	pmpaddr0,t0
80000114:	0040006f          	j	80000118 <WELCOME>

80000118 <WELCOME>:
80000118:	0040006f          	j	8000011c <SHELL>

8000011c <SHELL>:
8000011c:	0080006f          	j	80000124 <.OP_G>

80000120 <.USER>:
80000120:	00008067          	ret

80000124 <.OP_G>:
80000124:	00000d17          	auipc	s10,0x0
80000128:	ffcd0d13          	addi	s10,s10,-4 # 80000120 <.USER>
8000012c:	341d1073          	csrw	mepc,s10
80000130:	00002537          	lui	a0,0x2
80000134:	80050513          	addi	a0,a0,-2048 # 1800 <INITLOCATE-0x7fffe800>
80000138:	30053073          	csrc	mstatus,a0
8000013c:	0200c2b7          	lui	t0,0x200c
80000140:	ff828293          	addi	t0,t0,-8 # 200bff8 <INITLOCATE-0x7dff4008>
80000144:	0002a303          	lw	t1,0(t0)
80000148:	0042a383          	lw	t2,4(t0)
8000014c:	00989e37          	lui	t3,0x989
80000150:	680e0e13          	addi	t3,t3,1664 # 989680 <INITLOCATE-0x7f676980>
80000154:	01c30e33          	add	t3,t1,t3
80000158:	006e3333          	sltu	t1,t3,t1
8000015c:	006383b3          	add	t2,t2,t1
80000160:	020042b7          	lui	t0,0x2004
80000164:	0072a223          	sw	t2,4(t0) # 2004004 <INITLOCATE-0x7dffbffc>
80000168:	01c2a023          	sw	t3,0(t0)
8000016c:	007f0097          	auipc	ra,0x7f0
80000170:	e9408093          	addi	ra,ra,-364 # 807f0000 <_sbss>
80000174:	0820a023          	sw	sp,128(ra)
80000178:	0040a103          	lw	sp,4(ra)
8000017c:	0080a183          	lw	gp,8(ra)
80000180:	00c0a203          	lw	tp,12(ra)
80000184:	0100a283          	lw	t0,16(ra)
80000188:	0140a303          	lw	t1,20(ra)
8000018c:	0180a383          	lw	t2,24(ra)
80000190:	01c0a403          	lw	s0,28(ra)
80000194:	0200a483          	lw	s1,32(ra)
80000198:	0240a503          	lw	a0,36(ra)
8000019c:	0280a583          	lw	a1,40(ra)
800001a0:	02c0a603          	lw	a2,44(ra)
800001a4:	0300a683          	lw	a3,48(ra)
800001a8:	0340a703          	lw	a4,52(ra)
800001ac:	0380a783          	lw	a5,56(ra)
800001b0:	03c0a803          	lw	a6,60(ra)
800001b4:	0400a883          	lw	a7,64(ra)
800001b8:	0440a903          	lw	s2,68(ra)
800001bc:	0480a983          	lw	s3,72(ra)
800001c0:	04c0aa03          	lw	s4,76(ra)
800001c4:	0500aa83          	lw	s5,80(ra)
800001c8:	0540ab03          	lw	s6,84(ra)
800001cc:	0580ab83          	lw	s7,88(ra)
800001d0:	05c0ac03          	lw	s8,92(ra)
800001d4:	0600ac83          	lw	s9,96(ra)
800001d8:	0680ad83          	lw	s11,104(ra)
800001dc:	06c0ae03          	lw	t3,108(ra)
800001e0:	0700ae83          	lw	t4,112(ra)
800001e4:	0740af03          	lw	t5,116(ra)
800001e8:	0780af83          	lw	t6,120(ra)

800001ec <.ENTER_UESR>:
800001ec:	00000097          	auipc	ra,0x0
800001f0:	00c08093          	addi	ra,ra,12 # 800001f8 <.USERRET_USER>
800001f4:	30200073          	mret

800001f8 <.USERRET_USER>:
800001f8:	00100073          	ebreak

800001fc <USERRET_TIMEOUT>:
800001fc:	08100513          	li	a0,129
80000200:	474000ef          	jal	ra,80000674 <WRITE_SERIAL>
80000204:	00c0006f          	j	80000210 <USERRET_MACHINE+0x8>

80000208 <USERRET_MACHINE>:
80000208:	00700513          	li	a0,7
8000020c:	468000ef          	jal	ra,80000674 <WRITE_SERIAL>
80000210:	007f0497          	auipc	s1,0x7f0
80000214:	df048493          	addi	s1,s1,-528 # 807f0000 <_sbss>
80000218:	08000913          	li	s2,128
8000021c:	00012503          	lw	a0,0(sp)
80000220:	00a4a023          	sw	a0,0(s1)
80000224:	ffc90913          	addi	s2,s2,-4
80000228:	00448493          	addi	s1,s1,4
8000022c:	00410113          	addi	sp,sp,4
80000230:	fe0916e3          	bnez	s2,8000021c <USERRET_MACHINE+0x14>
80000234:	007f0497          	auipc	s1,0x7f0
80000238:	dcc48493          	addi	s1,s1,-564 # 807f0000 <_sbss>
8000023c:	0804a103          	lw	sp,128(s1)
80000240:	0a40006f          	j	800002e4 <.DONE>

80000244 <.USERRET2>:
80000244:	007f0097          	auipc	ra,0x7f0
80000248:	dbc08093          	addi	ra,ra,-580 # 807f0000 <_sbss>
8000024c:	0020a223          	sw	sp,4(ra)
80000250:	0030a423          	sw	gp,8(ra)
80000254:	0040a623          	sw	tp,12(ra)
80000258:	0050a823          	sw	t0,16(ra)
8000025c:	0060aa23          	sw	t1,20(ra)
80000260:	0070ac23          	sw	t2,24(ra)
80000264:	0080ae23          	sw	s0,28(ra)
80000268:	0290a023          	sw	s1,32(ra)
8000026c:	02a0a223          	sw	a0,36(ra)
80000270:	02b0a423          	sw	a1,40(ra)
80000274:	02c0a623          	sw	a2,44(ra)
80000278:	02d0a823          	sw	a3,48(ra)
8000027c:	02e0aa23          	sw	a4,52(ra)
80000280:	02f0ac23          	sw	a5,56(ra)
80000284:	0300ae23          	sw	a6,60(ra)
80000288:	0510a023          	sw	a7,64(ra)
8000028c:	0520a223          	sw	s2,68(ra)
80000290:	0530a423          	sw	s3,72(ra)
80000294:	0540a623          	sw	s4,76(ra)
80000298:	0550a823          	sw	s5,80(ra)
8000029c:	0560aa23          	sw	s6,84(ra)
800002a0:	0570ac23          	sw	s7,88(ra)
800002a4:	0580ae23          	sw	s8,92(ra)
800002a8:	0790a023          	sw	s9,96(ra)
800002ac:	07a0a223          	sw	s10,100(ra)
800002b0:	07b0a423          	sw	s11,104(ra)
800002b4:	07c0a623          	sw	t3,108(ra)
800002b8:	07d0a823          	sw	t4,112(ra)
800002bc:	07e0aa23          	sw	t5,116(ra)
800002c0:	07f0ac23          	sw	t6,120(ra)
800002c4:	0800a103          	lw	sp,128(ra)
800002c8:	00008513          	mv	a0,ra
800002cc:	00000097          	auipc	ra,0x0
800002d0:	f7808093          	addi	ra,ra,-136 # 80000244 <.USERRET2>
800002d4:	00152023          	sw	ra,0(a0)
800002d8:	00700513          	li	a0,7
800002dc:	398000ef          	jal	ra,80000674 <WRITE_SERIAL>
800002e0:	0040006f          	j	800002e4 <.DONE>

800002e4 <.DONE>:
800002e4:	e39ff06f          	j	8000011c <SHELL>
	...

80000300 <EXCEPTION_HANDLER>:
80000300:	34011173          	csrrw	sp,mscratch,sp
80000304:	00112023          	sw	ra,0(sp)
80000308:	340110f3          	csrrw	ra,mscratch,sp
8000030c:	00112223          	sw	ra,4(sp)
80000310:	00312423          	sw	gp,8(sp)
80000314:	00412623          	sw	tp,12(sp)
80000318:	00512823          	sw	t0,16(sp)
8000031c:	00612a23          	sw	t1,20(sp)
80000320:	00712c23          	sw	t2,24(sp)
80000324:	00812e23          	sw	s0,28(sp)
80000328:	02912023          	sw	s1,32(sp)
8000032c:	02a12223          	sw	a0,36(sp)
80000330:	02b12423          	sw	a1,40(sp)
80000334:	02c12623          	sw	a2,44(sp)
80000338:	02d12823          	sw	a3,48(sp)
8000033c:	02e12a23          	sw	a4,52(sp)
80000340:	02f12c23          	sw	a5,56(sp)
80000344:	03012e23          	sw	a6,60(sp)
80000348:	05112023          	sw	a7,64(sp)
8000034c:	05212223          	sw	s2,68(sp)
80000350:	05312423          	sw	s3,72(sp)
80000354:	05412623          	sw	s4,76(sp)
80000358:	05512823          	sw	s5,80(sp)
8000035c:	05612a23          	sw	s6,84(sp)
80000360:	05712c23          	sw	s7,88(sp)
80000364:	05812e23          	sw	s8,92(sp)
80000368:	07912023          	sw	s9,96(sp)
8000036c:	07a12223          	sw	s10,100(sp)
80000370:	07b12423          	sw	s11,104(sp)
80000374:	07c12623          	sw	t3,108(sp)
80000378:	07d12823          	sw	t4,112(sp)
8000037c:	07e12a23          	sw	t5,116(sp)
80000380:	07f12c23          	sw	t6,120(sp)
80000384:	341022f3          	csrr	t0,mepc
80000388:	06512e23          	sw	t0,124(sp)
8000038c:	342022f3          	csrr	t0,mcause
80000390:	80000337          	lui	t1,0x80000
80000394:	00730313          	addi	t1,t1,7 # 80000007 <KERNEL_STACK_INIT+0xff800007>
80000398:	04530a63          	beq	t1,t0,800003ec <.HANDLE_TIMER>
8000039c:	80000337          	lui	t1,0x80000
800003a0:	0062f333          	and	t1,t0,t1
800003a4:	04031263          	bnez	t1,800003e8 <.HANDLE_INT>
800003a8:	00800313          	li	t1,8
800003ac:	00530863          	beq	t1,t0,800003bc <.HANDLE_ECALL>
800003b0:	00300313          	li	t1,3
800003b4:	02530863          	beq	t1,t0,800003e4 <.HANDLE_BREAK>
800003b8:	2480006f          	j	80000600 <FATAL>

800003bc <.HANDLE_ECALL>:
800003bc:	07c12283          	lw	t0,124(sp)
800003c0:	00428293          	addi	t0,t0,4
800003c4:	06512e23          	sw	t0,124(sp)
800003c8:	01c12283          	lw	t0,28(sp)
800003cc:	01e00313          	li	t1,30
800003d0:	00628463          	beq	t0,t1,800003d8 <.HANDLE_ECALL_PUTC>
800003d4:	0300006f          	j	80000404 <CONTEXT_SWITCH>

800003d8 <.HANDLE_ECALL_PUTC>:
800003d8:	02412503          	lw	a0,36(sp)
800003dc:	298000ef          	jal	ra,80000674 <WRITE_SERIAL>
800003e0:	0240006f          	j	80000404 <CONTEXT_SWITCH>

800003e4 <.HANDLE_BREAK>:
800003e4:	e25ff06f          	j	80000208 <USERRET_MACHINE>

800003e8 <.HANDLE_INT>:
800003e8:	2180006f          	j	80000600 <FATAL>

800003ec <.HANDLE_TIMER>:
800003ec:	300022f3          	csrr	t0,mstatus
800003f0:	00002337          	lui	t1,0x2
800003f4:	80030313          	addi	t1,t1,-2048 # 1800 <INITLOCATE-0x7fffe800>
800003f8:	0062f2b3          	and	t0,t0,t1
800003fc:	00029463          	bnez	t0,80000404 <CONTEXT_SWITCH>
80000400:	dfdff06f          	j	800001fc <USERRET_TIMEOUT>

80000404 <CONTEXT_SWITCH>:
80000404:	07c12283          	lw	t0,124(sp)
80000408:	34129073          	csrw	mepc,t0
8000040c:	00012083          	lw	ra,0(sp)
80000410:	00812183          	lw	gp,8(sp)
80000414:	00c12203          	lw	tp,12(sp)
80000418:	01012283          	lw	t0,16(sp)
8000041c:	01412303          	lw	t1,20(sp)
80000420:	01812383          	lw	t2,24(sp)
80000424:	01c12403          	lw	s0,28(sp)
80000428:	02012483          	lw	s1,32(sp)
8000042c:	02412503          	lw	a0,36(sp)
80000430:	02812583          	lw	a1,40(sp)
80000434:	02c12603          	lw	a2,44(sp)
80000438:	03012683          	lw	a3,48(sp)
8000043c:	03412703          	lw	a4,52(sp)
80000440:	03812783          	lw	a5,56(sp)
80000444:	03c12803          	lw	a6,60(sp)
80000448:	04012883          	lw	a7,64(sp)
8000044c:	04412903          	lw	s2,68(sp)
80000450:	04812983          	lw	s3,72(sp)
80000454:	04c12a03          	lw	s4,76(sp)
80000458:	05012a83          	lw	s5,80(sp)
8000045c:	05412b03          	lw	s6,84(sp)
80000460:	05812b83          	lw	s7,88(sp)
80000464:	05c12c03          	lw	s8,92(sp)
80000468:	06012c83          	lw	s9,96(sp)
8000046c:	06412d03          	lw	s10,100(sp)
80000470:	06812d83          	lw	s11,104(sp)
80000474:	06c12e03          	lw	t3,108(sp)
80000478:	07012e83          	lw	t4,112(sp)
8000047c:	07412f03          	lw	t5,116(sp)
80000480:	07812f83          	lw	t6,120(sp)
80000484:	34011073          	csrw	mscratch,sp
80000488:	00412103          	lw	sp,4(sp)
8000048c:	30200073          	mret
80000490:	00000013          	nop
80000494:	00000013          	nop
80000498:	00000013          	nop
8000049c:	00000013          	nop
800004a0:	00000013          	nop
800004a4:	00000013          	nop
800004a8:	00000013          	nop
800004ac:	00000013          	nop
800004b0:	00000013          	nop
800004b4:	00000013          	nop
800004b8:	00000013          	nop
800004bc:	00000013          	nop
800004c0:	00000013          	nop
800004c4:	00000013          	nop
800004c8:	00000013          	nop
800004cc:	00000013          	nop
800004d0:	00000013          	nop
800004d4:	00000013          	nop
800004d8:	00000013          	nop
800004dc:	00000013          	nop
800004e0:	00000013          	nop
800004e4:	00000013          	nop
800004e8:	00000013          	nop
800004ec:	00000013          	nop
800004f0:	00000013          	nop
800004f4:	00000013          	nop
800004f8:	00000013          	nop
800004fc:	00000013          	nop

80000500 <VECTORED_EXCEPTION_HANDLER>:
80000500:	e01ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000504:	dfdff06f          	j	80000300 <EXCEPTION_HANDLER>
80000508:	df9ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000050c:	df5ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000510:	df1ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000514:	dedff06f          	j	80000300 <EXCEPTION_HANDLER>
80000518:	de9ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000051c:	de5ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000520:	de1ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000524:	dddff06f          	j	80000300 <EXCEPTION_HANDLER>
80000528:	dd9ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000052c:	dd5ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000530:	dd1ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000534:	dcdff06f          	j	80000300 <EXCEPTION_HANDLER>
80000538:	dc9ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000053c:	dc5ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000540:	dc1ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000544:	dbdff06f          	j	80000300 <EXCEPTION_HANDLER>
80000548:	db9ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000054c:	db5ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000550:	db1ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000554:	dadff06f          	j	80000300 <EXCEPTION_HANDLER>
80000558:	da9ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000055c:	da5ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000560:	da1ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000564:	d9dff06f          	j	80000300 <EXCEPTION_HANDLER>
80000568:	d99ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000056c:	d95ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000570:	d91ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000574:	d8dff06f          	j	80000300 <EXCEPTION_HANDLER>
80000578:	d89ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000057c:	d85ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000580:	d81ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000584:	d7dff06f          	j	80000300 <EXCEPTION_HANDLER>
80000588:	d79ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000058c:	d75ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000590:	d71ff06f          	j	80000300 <EXCEPTION_HANDLER>
80000594:	d6dff06f          	j	80000300 <EXCEPTION_HANDLER>
80000598:	d69ff06f          	j	80000300 <EXCEPTION_HANDLER>
8000059c:	d65ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005a0:	d61ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005a4:	d5dff06f          	j	80000300 <EXCEPTION_HANDLER>
800005a8:	d59ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005ac:	d55ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005b0:	d51ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005b4:	d4dff06f          	j	80000300 <EXCEPTION_HANDLER>
800005b8:	d49ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005bc:	d45ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005c0:	d41ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005c4:	d3dff06f          	j	80000300 <EXCEPTION_HANDLER>
800005c8:	d39ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005cc:	d35ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005d0:	d31ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005d4:	d2dff06f          	j	80000300 <EXCEPTION_HANDLER>
800005d8:	d29ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005dc:	d25ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005e0:	d21ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005e4:	d1dff06f          	j	80000300 <EXCEPTION_HANDLER>
800005e8:	d19ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005ec:	d15ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005f0:	d11ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005f4:	d0dff06f          	j	80000300 <EXCEPTION_HANDLER>
800005f8:	d09ff06f          	j	80000300 <EXCEPTION_HANDLER>
800005fc:	d05ff06f          	j	80000300 <EXCEPTION_HANDLER>

80000600 <FATAL>:
80000600:	08000513          	li	a0,128
80000604:	070000ef          	jal	ra,80000674 <WRITE_SERIAL>
80000608:	34102573          	csrr	a0,mepc
8000060c:	0d4000ef          	jal	ra,800006e0 <WRITE_SERIAL_XLEN>
80000610:	34202573          	csrr	a0,mcause
80000614:	0cc000ef          	jal	ra,800006e0 <WRITE_SERIAL_XLEN>
80000618:	34302573          	csrr	a0,mtval
8000061c:	0c4000ef          	jal	ra,800006e0 <WRITE_SERIAL_XLEN>
80000620:	00000517          	auipc	a0,0x0
80000624:	9ec50513          	addi	a0,a0,-1556 # 8000000c <START>
80000628:	00050067          	jr	a0
	...

80000674 <WRITE_SERIAL>:
80000674:	100002b7          	lui	t0,0x10000

80000678 <.TESTW>:
80000678:	00528303          	lb	t1,5(t0) # 10000005 <INITLOCATE-0x6ffffffb>
8000067c:	02037313          	andi	t1,t1,32
80000680:	00031463          	bnez	t1,80000688 <.WSERIAL>
80000684:	ff5ff06f          	j	80000678 <.TESTW>

80000688 <.WSERIAL>:
80000688:	00a28023          	sb	a0,0(t0)
8000068c:	00008067          	ret

80000690 <WRITE_SERIAL_WORD>:
80000690:	ff810113          	addi	sp,sp,-8
80000694:	00112023          	sw	ra,0(sp)
80000698:	00812223          	sw	s0,4(sp)
8000069c:	00050413          	mv	s0,a0
800006a0:	0ff57513          	andi	a0,a0,255
800006a4:	fd1ff0ef          	jal	ra,80000674 <WRITE_SERIAL>
800006a8:	00845513          	srli	a0,s0,0x8
800006ac:	0ff57513          	andi	a0,a0,255
800006b0:	fc5ff0ef          	jal	ra,80000674 <WRITE_SERIAL>
800006b4:	01045513          	srli	a0,s0,0x10
800006b8:	0ff57513          	andi	a0,a0,255
800006bc:	fb9ff0ef          	jal	ra,80000674 <WRITE_SERIAL>
800006c0:	01845513          	srli	a0,s0,0x18
800006c4:	0ff57513          	andi	a0,a0,255
800006c8:	fadff0ef          	jal	ra,80000674 <WRITE_SERIAL>
800006cc:	00040513          	mv	a0,s0
800006d0:	00012083          	lw	ra,0(sp)
800006d4:	00412403          	lw	s0,4(sp)
800006d8:	00810113          	addi	sp,sp,8
800006dc:	00008067          	ret

800006e0 <WRITE_SERIAL_XLEN>:
800006e0:	ffc10113          	addi	sp,sp,-4
800006e4:	00112023          	sw	ra,0(sp)
800006e8:	fa9ff0ef          	jal	ra,80000690 <WRITE_SERIAL_WORD>
800006ec:	00012083          	lw	ra,0(sp)
800006f0:	00410113          	addi	sp,sp,4
800006f4:	00008067          	ret

800006f8 <WRITE_SERIAL_STRING>:
800006f8:	00050593          	mv	a1,a0
800006fc:	00008613          	mv	a2,ra
80000700:	00058503          	lb	a0,0(a1)
80000704:	f71ff0ef          	jal	ra,80000674 <WRITE_SERIAL>
80000708:	00158593          	addi	a1,a1,1
8000070c:	00058503          	lb	a0,0(a1)
80000710:	fe051ae3          	bnez	a0,80000704 <WRITE_SERIAL_STRING+0xc>
80000714:	00060067          	jr	a2

80000718 <READ_SERIAL>:
80000718:	100002b7          	lui	t0,0x10000

8000071c <.TESTR>:
8000071c:	00528303          	lb	t1,5(t0) # 10000005 <INITLOCATE-0x6ffffffb>
80000720:	00137313          	andi	t1,t1,1
80000724:	00031463          	bnez	t1,8000072c <.RSERIAL>
80000728:	ff5ff06f          	j	8000071c <.TESTR>

8000072c <.RSERIAL>:
8000072c:	00028503          	lb	a0,0(t0)
80000730:	00008067          	ret

80000734 <READ_SERIAL_WORD>:
80000734:	fec10113          	addi	sp,sp,-20
80000738:	00112023          	sw	ra,0(sp)
8000073c:	00812223          	sw	s0,4(sp)
80000740:	00912423          	sw	s1,8(sp)
80000744:	01212623          	sw	s2,12(sp)
80000748:	01312823          	sw	s3,16(sp)
8000074c:	fcdff0ef          	jal	ra,80000718 <READ_SERIAL>
80000750:	00a06433          	or	s0,zero,a0
80000754:	fc5ff0ef          	jal	ra,80000718 <READ_SERIAL>
80000758:	00a064b3          	or	s1,zero,a0
8000075c:	fbdff0ef          	jal	ra,80000718 <READ_SERIAL>
80000760:	00a06933          	or	s2,zero,a0
80000764:	fb5ff0ef          	jal	ra,80000718 <READ_SERIAL>
80000768:	00a069b3          	or	s3,zero,a0
8000076c:	0ff47413          	andi	s0,s0,255
80000770:	0ff4f493          	andi	s1,s1,255
80000774:	0ff97913          	andi	s2,s2,255
80000778:	0ff9f993          	andi	s3,s3,255
8000077c:	01306533          	or	a0,zero,s3
80000780:	00851513          	slli	a0,a0,0x8
80000784:	01256533          	or	a0,a0,s2
80000788:	00851513          	slli	a0,a0,0x8
8000078c:	00956533          	or	a0,a0,s1
80000790:	00851513          	slli	a0,a0,0x8
80000794:	00856533          	or	a0,a0,s0
80000798:	00012083          	lw	ra,0(sp)
8000079c:	00412403          	lw	s0,4(sp)
800007a0:	00812483          	lw	s1,8(sp)
800007a4:	00c12903          	lw	s2,12(sp)
800007a8:	01012983          	lw	s3,16(sp)
800007ac:	01410113          	addi	sp,sp,20
800007b0:	00008067          	ret

800007b4 <READ_SERIAL_XLEN>:
800007b4:	ff810113          	addi	sp,sp,-8
800007b8:	00112023          	sw	ra,0(sp)
800007bc:	00812223          	sw	s0,4(sp)
800007c0:	f75ff0ef          	jal	ra,80000734 <READ_SERIAL_WORD>
800007c4:	00050413          	mv	s0,a0
800007c8:	00040513          	mv	a0,s0
800007cc:	00012083          	lw	ra,0(sp)
800007d0:	00412403          	lw	s0,4(sp)
800007d4:	00810113          	addi	sp,sp,8
800007d8:	00008067          	ret
	...

80001000 <UTEST_SIMPLE>:
80001000:	001f0f13          	addi	t5,t5,1
80001004:	00008067          	ret

80001008 <UTEST_1PTB>:
80001008:	040002b7          	lui	t0,0x4000
8000100c:	fff28293          	addi	t0,t0,-1 # 3ffffff <INITLOCATE-0x7c000001>
80001010:	00000313          	li	t1,0
80001014:	00100393          	li	t2,1
80001018:	00200e13          	li	t3,2
8000101c:	fe0298e3          	bnez	t0,8000100c <UTEST_1PTB+0x4>
80001020:	00008067          	ret

80001024 <UTEST_2DCT>:
80001024:	010002b7          	lui	t0,0x1000
80001028:	00100313          	li	t1,1
8000102c:	00200393          	li	t2,2
80001030:	00300e13          	li	t3,3
80001034:	0063c3b3          	xor	t2,t2,t1
80001038:	00734333          	xor	t1,t1,t2
8000103c:	0063c3b3          	xor	t2,t2,t1
80001040:	007e4e33          	xor	t3,t3,t2
80001044:	01c3c3b3          	xor	t2,t2,t3
80001048:	007e4e33          	xor	t3,t3,t2
8000104c:	01c34333          	xor	t1,t1,t3
80001050:	006e4e33          	xor	t3,t3,t1
80001054:	01c34333          	xor	t1,t1,t3
80001058:	fff28293          	addi	t0,t0,-1 # ffffff <INITLOCATE-0x7f000001>
8000105c:	fc029ce3          	bnez	t0,80001034 <UTEST_2DCT+0x10>
80001060:	00008067          	ret

80001064 <UTEST_3CCT>:
80001064:	040002b7          	lui	t0,0x4000
80001068:	00029463          	bnez	t0,80001070 <UTEST_3CCT+0xc>
8000106c:	00008067          	ret
80001070:	0040006f          	j	80001074 <UTEST_3CCT+0x10>
80001074:	fff28293          	addi	t0,t0,-1 # 3ffffff <INITLOCATE-0x7c000001>
80001078:	ff1ff06f          	j	80001068 <UTEST_3CCT+0x4>
8000107c:	fff28293          	addi	t0,t0,-1

80001080 <UTEST_4MDCT>:
80001080:	020002b7          	lui	t0,0x2000
80001084:	ffc10113          	addi	sp,sp,-4
80001088:	00512023          	sw	t0,0(sp)
8000108c:	00012303          	lw	t1,0(sp)
80001090:	fff30313          	addi	t1,t1,-1
80001094:	00612023          	sw	t1,0(sp)
80001098:	00012283          	lw	t0,0(sp)
8000109c:	fe0296e3          	bnez	t0,80001088 <UTEST_4MDCT+0x8>
800010a0:	00410113          	addi	sp,sp,4
800010a4:	00008067          	ret

800010a8 <UTEST_PUTC>:
800010a8:	01e00413          	li	s0,30
800010ac:	04f00513          	li	a0,79
800010b0:	00000073          	ecall
800010b4:	04b00513          	li	a0,75
800010b8:	00000073          	ecall
800010bc:	00008067          	ret

800010c0 <UTEST_SPIN>:
800010c0:	0000006f          	j	800010c0 <UTEST_SPIN>

800010c4 <UTEST_CRYPTONIGHT>:
800010c4:	80400537          	lui	a0,0x80400
800010c8:	002005b7          	lui	a1,0x200
800010cc:	000806b7          	lui	a3,0x80
800010d0:	00200737          	lui	a4,0x200
800010d4:	ffc70713          	addi	a4,a4,-4 # 1ffffc <INITLOCATE-0x7fe00004>
800010d8:	00a585b3          	add	a1,a1,a0
800010dc:	00100413          	li	s0,1
800010e0:	00050613          	mv	a2,a0

800010e4 <.INIT_LOOP>:
800010e4:	00862023          	sw	s0,0(a2)
800010e8:	00d41493          	slli	s1,s0,0xd
800010ec:	00944433          	xor	s0,s0,s1
800010f0:	01145493          	srli	s1,s0,0x11
800010f4:	00944433          	xor	s0,s0,s1
800010f8:	00541493          	slli	s1,s0,0x5
800010fc:	00944433          	xor	s0,s0,s1
80001100:	00460613          	addi	a2,a2,4
80001104:	feb610e3          	bne	a2,a1,800010e4 <.INIT_LOOP>
80001108:	00000613          	li	a2,0
8000110c:	00000293          	li	t0,0

80001110 <.MAIN_LOOP>:
80001110:	00e472b3          	and	t0,s0,a4
80001114:	005502b3          	add	t0,a0,t0
80001118:	0002a283          	lw	t0,0(t0) # 2000000 <INITLOCATE-0x7e000000>
8000111c:	0062c2b3          	xor	t0,t0,t1
80001120:	00544433          	xor	s0,s0,t0
80001124:	00d41493          	slli	s1,s0,0xd
80001128:	00944433          	xor	s0,s0,s1
8000112c:	01145493          	srli	s1,s0,0x11
80001130:	00944433          	xor	s0,s0,s1
80001134:	00541493          	slli	s1,s0,0x5
80001138:	00944433          	xor	s0,s0,s1
8000113c:	00e47333          	and	t1,s0,a4
80001140:	00650333          	add	t1,a0,t1
80001144:	00532023          	sw	t0,0(t1)
80001148:	00028313          	mv	t1,t0
8000114c:	00d41493          	slli	s1,s0,0xd
80001150:	00944433          	xor	s0,s0,s1
80001154:	01145493          	srli	s1,s0,0x11
80001158:	00944433          	xor	s0,s0,s1
8000115c:	00541493          	slli	s1,s0,0x5
80001160:	00944433          	xor	s0,s0,s1
80001164:	00160613          	addi	a2,a2,1
80001168:	fad614e3          	bne	a2,a3,80001110 <.MAIN_LOOP>
8000116c:	00008067          	ret
