! --------------------------------------------------
! Fast and Accurate Motorola 68000 Emulation Library
! FAME SH4 version 2.1 (03/23/2007)
! Oscar Orallo Pelaez
! Assembly file generated on Apr  4 2011 23:25:03
! --------------------------------------------------
! Generation options:
! - Code generation format for GNU assembler (GAS)
! - CPU address bus width (24 bits)
! - Program counter bit width (24 bits)
! - Emulate dummy reads (OFF)
! - Emulate undocumented behaviour (OFF)
! - Single memory address space
! - Emulate group 0 error exceptions (OFF)
! - Prefix of API function identifiers: m68k
! - Accurate timing emulation (OFF)
! - Direct mapping for memory management (12 bits)
! - Keep track of executed CPU clocks (ON)
! - Use running state indicator in execinfo (ON)
! - Emulate trace mode exception (OFF)
! - CPU clocks spent in IRQ processing (ON)
! - Check for address exceptions in branches (OFF)
! - Bypass TAS writeback (OFF)
! - Declare CPU context as global variable (ON)
! --------------------------------------------------
.global __io_cycle_counter
.data
.align 5
.global _m68kcontext
_m68kcontext:
contextbegin:
fetch:     .long 0
readbyte:  .long 0
readword:  .long 0
writebyte: .long 0
writeword: .long 0
s_fetch:     .long 0
s_readbyte:  .long 0
s_readword:  .long 0
s_writebyte: .long 0
s_writeword: .long 0
u_fetch:     .long 0
u_readbyte:  .long 0
u_readword:  .long 0
u_writebyte: .long 0
u_writeword: .long 0
resethandler: .long 0
iackhandler:  .long 0
icusthandler: .long 0
reg:
dreg: .long 0,0,0,0,0,0,0,0
areg: .long 0,0,0,0,0,0,0
a7:   .long 0
asp:  .long 0
pc:   .long 0
cycles_counter: .long 0
interrupts: .byte 0,0,0,0,0,0,0,0
sreg: .word 0
execinfo: .word 0
contextend:
execexit_addr: .long execexit
fdl_addr: .long fdl
cycles_needed:    .long 0
__io_cycle_counter: .long 0
io_fetchbase:     .long 0
io_fetchbased_pc: .long 0
fetch_vector:	    .long sfmhtbl, srwmhtbl
fetch_idx:        .long 0
readbyte_idx:     .long 0
readword_idx:     .long 0
writebyte_idx:    .long 0
writeword_idx:    .long 0
decode_extw_addr: .long decode_extw
rb_addr: .long readmemorybyte
rw_addr: .long readmemoryword
rl_addr: .long readmemorydword
wb_addr: .long writememorybyte
ww_addr: .long writememoryword
wl_addr: .long writememorydword
wdecb_addr: .long writememorydecbyte
wdecw_addr: .long writememorydecword
wdecl_addr: .long writememorydecdword
sfmhtbl:
.rept 4096
 .long 0
 .endr
srbmhtbl:
.rept 4096
 .long 0
 .endr
srwmhtbl:
.rept 4096
 .long 0
 .endr
swbmhtbl:
.rept 4096
 .long 0
 .endr
swwmhtbl:
.rept 4096
 .long 0
 .endr
.text
top:
.align 5
.global _m68k_init
_m68k_init:
rts
mov #0,r0
.align 5
.global _m68k_emulate
_m68k_emulate:
mov.l execinfo_addr,r1
mov.w @r1,r0
tst #0x80,r0
bt notstopped
mov.l cycles_counter_addr,r0
mov.l @r0,r1
add r4,r1
mov.l r1,@r0
rts
mov #0,r0
.align 5
notstopped:
mov.l r8,@-r15
mov r4,r7
mov.l r9,@-r15
mov.l r10,@-r15
mov.l r11,@-r15
mov.l r12,@-r15
mov.l fetch_idx_addr,r11
mov.l r13,@-r15
mov.l jmptbl_addr,r12
mov.l r14,@-r15
mov.l reg_addr,r13
sts.l pr,@-r15
mov.l areg_addr,r14
or #1,r0
mov.w r0,@r1
mov r0,r2
mov.l @(fdl_addr-areg,r14),r10
mov.l @(sreg - areg,r14),r0
mov #3,r8
and r0,r8
mov r0,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l pc_addr,r1
mov.l r4,@(cycles_needed-pc,r1)
mov.l @r1,r6
flush_irqs:
mov.l sreg_addr1,r1
mov.l interrupts_addr1,r0
mov.w @r1,r1
mov #7,r4
shlr8 r1
mov.b @r0,r2
and r4,r1
mov r2,r5
sub r1,r4
mov #7,r1
shll16 r2
shll8 r2
.loop1:
shll r2
bt .int
dt r4
cmp/pl r4
bt/s .loop1
dt r1
bra .noint
mov #0,r0
.align 5
.int:
mov r5,r2
mov r1,r5
mov #1,r1
shld r5,r1
xor r1,r2
mov.l r5,@-r15
mov.b r2,@r0
mov.b @(r0,r5),r4
mov #0,r5
mov.l g1_exception_addr,r0
jsr @r0
shll2 r4
mov #0xf8,r0
mov.l @r15+,r5
mov.l sreg_addr1,r2
add #1,r2
mov.b @r2,r1
add #-44,r7
and r0,r1
or r5,r1
mov.b r1,@r2
mov.l iackhandler_addr,r0
mov.l @r0,r1
tst r1,r1
bt .intdone
mov.l r3,@-r15
mov.l __io_cycle_counter_addr1,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
jsr @r1
nop
mov.l __io_cycle_counter_addr1,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
mov.l @r15+,r3
.intdone:
mov #1,r0
.noint:
cmp/pz r7
bf/s irqclk_exit
mov #0,r5
execbase:
bsr basefunction
pref @r13
add r5,r6
execloop:
mov.w @r6+,r0
shll2 r0
mov.l @(r0,r12),r4
mov #0x1C,r2
jmp @r4
and r0,r2
.align 5
execexit:
add #-2,r6
irqclk_exit:
mov.l pc_addr,r2
sub r5,r6
rotl r3
mov r8,r0
addc r9,r9
shlr2 r0
rotr r3
and #1,r0
xor r0,r9
mov r8,r0
tst r3,r3
addc r9,r9
and #3,r0
shll2 r9
or r0,r9
mov.l sreg_addr1,r0
mov.b r9,@r0
mov.l r6,@r2
mov.l @(cycles_needed-pc,r2),r4
sub r7,r4
mov.l @(cycles_counter-pc,r2),r6
add r4,r6
mov.l r6,@(cycles_counter-pc,r2)
mov.l execinfo_addr,r1
mov.w @r1,r0
xor #1,r0
mov.w r0,@r1
lds.l	@r15+,pr
mov.l @r15+,r14
mov.l @r15+,r13
mov.l @r15+,r12
mov.l @r15+,r11
mov.l @r15+,r10
mov.l @r15+,r9
rts
mov.l @r15+,r8
.align 2
interrupts_addr1: .long interrupts
pc_addr: .long pc
reg_addr: .long reg
areg_addr: .long areg
fetch_vector_addr: .long fetch_vector
sreg_addr1: .long sreg
jmptbl_addr: .long jmptbl
cycles_counter_addr: .long cycles_counter
execinfo_addr: .long execinfo
fetch_idx_addr: .long fetch_idx
g1_exception_addr: .long group_1_exception
basefunction_addr: .long basefunction
iackhandler_addr: .long iackhandler
__io_cycle_counter_addr1: .long __io_cycle_counter
.align 5
.global _m68k_reset
_m68k_reset:
mov.l r11,@-r15
mov.l fetchidx_addr,r11
mov #1,r0
mov.l execinfo_addr2,r2
mov.w @r2,r1
tst r1,r0
bf return
mov.l sup_fetch_addr,r0
mov.l @r0,r1
mov #2,r0
tst r1,r1
bt return
mov.l reg_addr2,r0
mov #64,r1
add r1,r0
shlr2 r1
xor r4,r4
gp:
mov.l r4,@-r0
dt r1
bf gp
mov.l asp_addr2,r2
mov.l r4,@r2
mov.l interrupts_addr2,r2
mov.b r4,@r2
mov.l execinfo_addr2,r2
mov.w r4,@r2
mov.l sreg_addr2,r2
mov #0x27,r4
shll8 r4
mov.w r4,@r2
mov.l sfmhtbl_addr2,r0
mov.l fetch_idx_addr2,r1
mov.l r0,@r1
mov.l srbmhtbl_addr2,r0
mov.l r0,@(4,r1)
mov.l srwmhtbl_addr2,r0
mov.l r0,@(8,r1)
mov.l swbmhtbl_addr2,r0
mov.l r0,@(12,r1)
mov.l swwmhtbl_addr2,r0
mov.l r0,@(16,r1)
sts pr,r4
bsr basefunction
xor r6,r6
lds r4,pr
add r5,r6
mov.l @r6+,r0
swap.w r0,r0
mov.l a7_addr2,r2
mov.l r0,@r2
mov.l @r6,r0
swap.w r0,r0
mov.l pc_addr2,r2
mov.l r0,@r2
mov #0,r0
return:
rts
mov.l @r15+,r11
.align 2
reg_addr2: .long reg
execinfo_addr2: .long execinfo
interrupts_addr2: .long interrupts
pc_addr2: .long pc
sreg_addr2: .long sreg
a7_addr2: .long a7
asp_addr2: .long asp
sup_fetch_addr: .long s_fetch
sup_readbyte: .long s_readbyte
sup_readword: .long s_readword
sup_writebyte: .long s_writebyte
sup_writeword: .long s_writeword
act_fetch: .long fetch
act_readbyte: .long readbyte
act_readword: .long readword
act_writebyte: .long writebyte
act_writeword: .long writeword
fetchidx_addr: .long fetch_idx
sfmhtbl_addr2: .long sfmhtbl
srbmhtbl_addr2: .long srbmhtbl
srwmhtbl_addr2: .long srwmhtbl
swbmhtbl_addr2: .long swbmhtbl
swwmhtbl_addr2: .long swwmhtbl
fetch_idx_addr2: .long fetch_idx
.align 5
.global _m68k_raise_irq
_m68k_raise_irq:
mov r4,r0
and #7,r0
tst r0,r0
bt badinput
mov #0xff,r4
extu.b r4,r4
cmp/gt r4,r5
bt badinput
mov #-2,r4
cmp/ge r4,r5
bf badinput
cmp/eq r5,r4
bf notspurious
bra notauto
mov #0x18,r5
notspurious:
mov #-1,r4
cmp/eq r5,r4
bf notauto
mov #0x18,r5
add r0,r5
notauto:
mov #1,r4
shld r0,r4
mov.l interrupts_addr3,r1
mov.b @r1,r6
tst r6,r4
bf failure
or r4,r6
mov.b r5,@(r0,r1)
mov.b r6,@r1
mov #0x80,r1
mov.l execinfo_addr3,r6
extu.b r1,r1
mov.w @r6,r7
tst r1,r7
bt .notstopped
mov.l sreg_addr3,r1
mov.w @r1,r5
shlr8 r5
mov #7,r1
cmp/eq r1,r0
movt r4
and r1,r5
add r4,r0
cmp/hs r0,r5
movt r2
mov #0x7f,r0
shld r1,r2
and r0,r7
or r2,r7
mov.w r7,@r6
.notstopped:
rts
mov #0,r0
failure:
rts
mov #-1,r0
badinput:
rts
mov #-2,r0
.align 2
interrupts_addr3: .long interrupts
execinfo_addr3: .long execinfo
sreg_addr3: .long sreg
.align 5
.global _m68k_lower_irq
_m68k_lower_irq:
mov #6,r1
cmp/gt r1,r4
bt .badlevel
tst r4,r4
bt .badlevel
mov #1,r1
shld r4,r1
mov.l interrupts_addr4,r2
mov.b @r2,r3
tst r3,r1
bt .failstat
not r1,r1
and r1,r3
mov.b r3,@r2
rts
mov #0,r0
.failstat:
rts
mov #-1,r0
.badlevel:
rts
mov #-2,r0
.align 2
interrupts_addr4: .long interrupts
.align 5
.global _m68k_set_irq_type
_m68k_set_irq_type:
mov #1,r0
and r0,r5
tst r4,r4
bt .si_irq
mov #interrupts-contextbegin,r0
mov.b @(r0,r4),r1
shlr r1
shll r1
or r5,r1
mov.b r1,@(r0,r4)
rts
mov #0,r0
.si_irq:
mov.l interrupts_addr5,r1
mov.b @r1,r0
and #0xFE,r0
or r5,r0
mov.b r0,@r1
rts
mov #0,r0
.align 2
interrupts_addr5: .long interrupts
.align 5
.global _m68k_get_irq_vector
_m68k_get_irq_vector:
mov r4,r0
and #7,r0
tst r0,r0
bt badlev
mov #1,r1
shld r0,r1
mov.l interrupts_addr6,r2
mov.b @r2,r3
tst r3,r1
bt notraised
mov.b @(r0,r2),r0
rts
extu.b r0,r0
notraised:
rts
mov #-1,r0
badlev:
rts
mov #-2,r0
.align 2
interrupts_addr6: .long interrupts
.align 5
.global _m68k_change_irq_vector
_m68k_change_irq_vector:
mov r4,r0
and #7,r0
tst r0,r0
bt .badin
mov #1,r1
shld r0,r1
mov.l interrupts_addr7,r7
mov.b @r7,r3
tst r3,r1
bt .nraised
mov #255,r4
extu.b r4,r4
cmp/gt r4,r5
bt .badin
mov #-2,r4
cmp/gt r5,r4
bt .badin
cmp/eq r5,r4
bf .notspurious
bra .notauto
mov #0x18,r5
.notspurious:
dt r4
cmp/eq r5,r4
bf .notauto
mov #0x18,r5
add r0,r5
.notauto:
mov.b r5,@(r0,r7)
rts
mov #0,r0
.nraised:
rts
mov #-1,r0
.badin:
rts
mov #-2,r0
.align 2
interrupts_addr7: .long interrupts
.align 5
.global _m68k_get_context_size
_m68k_get_context_size:
mov.l contextend_addr8,r0
mov.l contextbegin_addr8,r1
rts
sub r1,r0
.align 2
contextbegin_addr8: .long contextbegin
contextend_addr8: .long contextend
.align 5
.global _m68k_get_context
_m68k_get_context:
mov.l contextbegin_addr9,r2
mov.l contextend_addr9,r1
loopgc:
mov.l @r2+,r0
mov.l r0,@r4
add #4,r4
cmp/eq r2,r1
bf loopgc
rts
mov #0,r0
.align 2
contextbegin_addr9: .long contextbegin
contextend_addr9: .long contextend
.align 5
.global _m68k_set_context
_m68k_set_context:
mov.l contxtb,r2
mov.l contxte,r1
lloop:
mov.l @r4+,r0
mov.l r0,@r2
add #4,r2
cmp/eq r2,r1
bf lloop
mov.l idxtbl_size,r1
mov.l sfmhtbl_addr,r2
mov #0,r0
mloop:
mov.l r0,@r2
add #4,r2
dt r1
bf mloop
mov.l sfmhtbl_addr,r4
mov.l s_fetch_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm0:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm0
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop0:
mov.l r1,@r0
add r6,r0
dt r2
bf loop0
bra begincmm0
add #12,r1
endcmm0:
mov.l srbmhtbl_addr,r4
mov.l s_readbyte_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm1:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm1
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop1:
mov.l r1,@r0
add r6,r0
dt r2
bf loop1
bra begincmm1
add #16,r1
endcmm1:
mov.l srwmhtbl_addr,r4
mov.l s_readword_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm2:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm2
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop2:
mov.l r1,@r0
add r6,r0
dt r2
bf loop2
bra begincmm2
add #16,r1
endcmm2:
mov.l swbmhtbl_addr,r4
mov.l s_writebyte_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm3:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm3
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop3:
mov.l r1,@r0
add r6,r0
dt r2
bf loop3
bra begincmm3
add #16,r1
endcmm3:
mov.l swwmhtbl_addr,r4
mov.l s_writeword_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm4:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm4
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop4:
mov.l r1,@r0
add r6,r0
dt r2
bf loop4
bra begincmm4
add #16,r1
endcmm4:
rts
mov #0,r0
.align 2
interrupts_addr10: .long interrupts
idxtbl_size: .long 20480
contxte: .long contextend
contxtb: .long contextbegin
sfmhtbl_addr: .long sfmhtbl
srbmhtbl_addr: .long srbmhtbl
swbmhtbl_addr: .long swbmhtbl
srwmhtbl_addr: .long srwmhtbl
swwmhtbl_addr: .long swwmhtbl
s_fetch_addr: .long s_fetch
s_readbyte_addr: .long s_readbyte
s_writebyte_addr: .long s_writebyte
s_readword_addr: .long s_readword
s_writeword_addr: .long s_writeword
.align 5
.global _m68k_get_register
_m68k_get_register:
mov #17,r0
cmp/gt r0,r4
bt cont_get
mov #16,r0
cmp/gt r0,r4
bf .set_dareg
bra _m68k_get_pc
nop
.set_dareg:
mov.l reg_addr11,r0
shll2 r4
rts
mov.l @(r0,r4),r0
cont_get:
mov #18,r0
cmp/eq r0,r4
bf inv_idx
mov.l sreg_addr11,r0
mov.w @r0,r0
rts
extu.w r0,r0
inv_idx:
rts
mov #-1,r0
.align 2
sreg_addr11: .long sreg
reg_addr11: .long reg
.align 5
.global _m68k_get_pc
_m68k_get_pc:
mov.l execinfo_addr12,r0
mov.w @r0,r0
tst #1,r0
bf running
mov.l pc_addr12,r0
rts
mov.l @r0,r0
running:
mov.l io_fetchbased_pc_addr12,r0
mov.l @r0,r0
mov.l io_fetchbase_addr12,r1
mov.l @r1,r1
rts
sub r1,r0
.align 2
pc_addr12: .long pc
execinfo_addr12: .long execinfo
io_fetchbase_addr12: .long io_fetchbase
io_fetchbased_pc_addr12: .long io_fetchbased_pc
.align 5
.global _m68k_set_register
_m68k_set_register:
mov #17,r0
cmp/gt r0,r4
bt .cont_set
mov #16,r0
cmp/gt r0,r4
bt .set_pc
mov.l reg_addr13,r0
shll2 r4
mov.l r5,@(r0,r4)
rts
mov #0,r0
.set_pc:
shll8 r5
shlr8 r5
mov.l execinfo_addr13,r0
mov #1,r2
mov.b @r0,r1
tst r2,r1
bf .cpulive
mov.l pc_addr13,r0
mov.l r5,@r0
rts
mov #0,r0
.cpulive:
mov.l io_fetchbase_addr13,r0
mov.l @r0,r1
mov.l io_fetchbased_pc_addr13,r2
add r5,r1
mov.l r1,@r2
rts
mov #0,r0
.cont_set:
mov #18,r0
cmp/eq r0,r4
bf .inv_idx
mov.l sreg_addr13,r0
mov.w r5,@r0
rts
mov #0,r0
.inv_idx:
rts
mov #-1,r0
.align 2
sreg_addr13: .long sreg
reg_addr13: .long reg
execinfo_addr13: .long execinfo
pc_addr13: .long pc
io_fetchbase_addr13: .long io_fetchbase
io_fetchbased_pc_addr13: .long io_fetchbased_pc
.align 5
.global _m68k_fetch
_m68k_fetch:
mov #3,r0
and r0,r5
mov r4,r2
mov #-12,r0
shld r0,r4
mov.l fetch_vector_addr14,r0
shll2 r5
mov.l @(r0,r5),r0
shll2 r4
mov.l @(r0,r4),r0
mov r2,r4
tst r0,r0
bt .outofrange
mov #4,r1
tst r1,r5
bt .base_prg
bra .base_dat
nop
.outofrange:
rts
mov #-1,r0
.base_prg:
mov.l @(8,r0),r0
mov.w @(r0,r4),r0
rts
extu.w r0,r0
.base_dat:
mov.l @(8,r0),r1
tst r1,r1
bf .callio
mov.l @(12,r0),r0
mov.w @(r0,r4),r0
rts
extu.w r0,r0
.callio:
sts.l	pr,@-r15
jsr @r1
nop
lds.l	@r15+,pr
rts
extu.w r0,r0
.align 2
fetch_vector_addr14: .long fetch_vector
.align 5
.global _m68k_get_cycles_counter
_m68k_get_cycles_counter:
mov.l execinfo_addr15,r0
mov.w @r0,r0
tst #1,r0
bt/s cpuidle
mov #0,r1
mov.l cycles_needed_addr15,r2
mov.l @r2,r1
mov.l __io_cycle_counter_addr15,r0
mov.l @r0,r0
sub r0,r1
cpuidle:
mov.l cycles_counter_addr15,r0
mov.l @r0,r0
rts
add r1,r0
.align 2
execinfo_addr15: .long execinfo
cycles_counter_addr15: .long cycles_counter
cycles_needed_addr15: .long cycles_needed
__io_cycle_counter_addr15: .long __io_cycle_counter
.align 5
.global _m68k_control_cycles_counter
_m68k_control_cycles_counter:
tst r4,r4
bf _m68k_trip_cycles_counter
bra _m68k_get_cycles_counter
nop
rts
nop
.align 5
.global _m68k_trip_cycles_counter
_m68k_trip_cycles_counter:
mov.l cycles_needed_addr16,r4
mov.l @r4,r3
mov.l execinfo_addr16,r5
mov.b @r5,r0
tst #1,r0
bt .cpuidle
mov.l __io_cycle_counter_addr16,r1
mov.l @r1,r7
sub r7,r3
.cpuidle:
mov.l cycles_counter_addr16,r2
mov.l @r2,r6
add r3,r6
mov.l r6,@r2
tst #1,r0
bt .cpuidle2
mov.l @r1,r3
.cpuidle2:
mov.l r3,@r4
mov.l @r2,r0
xor r1,r1
rts
mov.l r1,@r2
.align 2
execinfo_addr16: .long execinfo
cycles_needed_addr16: .long cycles_needed
__io_cycle_counter_addr16: .long __io_cycle_counter
cycles_counter_addr16: .long cycles_counter
.align 5
.global _m68k_release_timeslice
_m68k_release_timeslice:
mov.l execinfo_addr17,r0
mov.w @r0,r0
tst #1,r0
bt/s cpu_idle
mov #0,r0
mov.l __io_cycle_counter_addr17,r2
mov.l r0,@r2
cpu_idle:
rts
mov #0,r0
.align 2
execinfo_addr17: .long execinfo
__io_cycle_counter_addr17: .long __io_cycle_counter
.align 5
.global _m68k_stop_emulating
_m68k_stop_emulating:
mov.l execinfo_addr18,r0
mov.w @r0,r0
tst #1,r0
bt se_cpu_idle
mov.l __io_cycle_counter_addr18,r2
mov.l @r2,r3
mov.l cycles_needed_addr18,r1
mov.l @r1,r0
sub r3,r0
mov.l r0,@r1
mov #0,r0
mov.l r0,@r2
se_cpu_idle:
rts
mov #0,r0
.align 2
execinfo_addr18: .long execinfo
cycles_needed_addr18: .long cycles_needed
__io_cycle_counter_addr18: .long __io_cycle_counter
.align 5
.global _m68k_add_cycles
_m68k_add_cycles:
mov.l execinfo_addr19,r0
mov.w @r0,r0
tst #1,r0
bt ac_cpu_idle
mov.l __io_cycle_counter_addr19,r2
mov.l @r2,r1
bra ac_end_proc
sub r4,r1
ac_cpu_idle:
mov.l cycles_counter_addr19,r2
mov.l @r2,r1
add r4,r1
ac_end_proc:
mov #0,r0
rts
mov.l r1,@r2
.align 2
execinfo_addr19: .long execinfo
cycles_counter_addr19: .long cycles_counter
__io_cycle_counter_addr19: .long __io_cycle_counter
.align 5
.global _m68k_release_cycles
_m68k_release_cycles:
mov.l execinfo_addr20,r0
mov.w @r0,r0
tst #1,r0
bt rc_cpu_idle
mov.l __io_cycle_counter_addr20,r2
mov.l @r2,r1
bra rc_end_proc
add r4,r1
rc_cpu_idle:
mov.l cycles_counter_addr20,r2
mov.l @r2,r1
sub r4,r1
rc_end_proc:
mov #0,r0
rts
mov.l r1,@r2
.align 2
execinfo_addr20: .long execinfo
cycles_counter_addr20: .long cycles_counter
__io_cycle_counter_addr20: .long __io_cycle_counter
.align 5
.global _m68k_get_cpu_state
_m68k_get_cpu_state:
mov.l execinfo_addr21,r0
mov.w @r0,r0
rts
extu.w r0,r0
.align 2
execinfo_addr21: .long execinfo
.align 5
basefunction:
shll8 r6
shlr8 r6
mov r6,r0
mov #-12,r1
shld r1,r0
mov.l @r11,r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt outofrange
rts
mov.l @(8,r0),r5
outofrange:
xor r5,r5
mov.l execinfo_addr22,r1
mov.w @r1,r0
or #2,r0
rts
mov.w r0,@r1
.align 2
execinfo_addr22: .long execinfo
.align 5
readmemorybyte:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov r4,r0
mov #-12,r1
shld r1,r0
mov.l @(readbyte_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readb_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readb_callio
mov.l @(12,r0),r0
add r4,r0
xor #1,r0
mov.b @r0,r3
rts
mov.l @r15+,r4
.align 5
readb_callio:
mov.l r2,@-r15
mov.l __io_cycle_counter_addr23,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
exts.b r0,r3
lds.l	@r15+,pr
mov.l __io_cycle_counter_addr23,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
mov.l @r15+,r2
rts
mov.l @r15+,r4
readb_outofrange:
bra readw_outofrange
nop
.align 2
__io_cycle_counter_addr23: .long __io_cycle_counter
.align 5
readmemoryword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov r4,r0
mov #-12,r1
shld r1,r0
mov.l @(readword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readw_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readw_callio
mov.l @(12,r0),r0
mov.w @(r0,r4),r3
rts
mov.l @r15+,r4
.align 5
readw_callio:
mov.l r2,@-r15
mov.l __io_cycle_counter_addr25,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
exts.w r0,r3
lds.l	@r15+,pr
mov.l __io_cycle_counter_addr25,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
mov.l @r15+,r2
rts
mov.l @r15+,r4
readw_outofrange:
mov #-1,r3
rts
mov.l @r15+,r4
.align 2
__io_cycle_counter_addr25: .long __io_cycle_counter
.align 5
readmemorydword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov r4,r0
mov #-12,r1
shld r1,r0
mov.l @(readword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readl_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readl_callio
mov.l @(12,r0),r1
add r1,r4
mov.w @r4+,r0
mov.w @r4,r3
shll16 r3
xtrct r0,r3
rts
mov.l @r15+,r4
readl_outofrange:
bra readw_outofrange
nop
.align 5
readl_callio:
mov.l r2,@-r15
sts.l	pr,@-r15
mov.l r4,@-r15
mov.l r1,@-r15
mov.l __io_cycle_counter_addr27,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
jsr @r1
nop
mov.l @r15+,r1
mov.l @r15+,r4
mov.l r0,@-r15
jsr @r1
add #2,r4
mov.l @r15+,r3
lds.l	@r15+,pr
shll16 r3
extu.w r0,r0
mov.l @r15+,r2
or r0,r3
mov.l __io_cycle_counter_addr27,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
rts
mov.l @r15+,r4
.align 2
__io_cycle_counter_addr27: .long __io_cycle_counter
.align 5
writememorybyte:
writememorydecbyte:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov r4,r0
mov #-12,r1
shld r1,r0
mov.l @(writebyte_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writeb_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writeb_callio
mov.l @(12,r0),r0
add r4,r0
xor #1,r0
mov.b r3,@r0
rts
mov.l @r15+,r4
writeb_outofrange:
bra writew_outofrange
nop
.align 5
writeb_callio:
mov.l r2,@-r15
mov.l r3,@-r15
mov.l __io_cycle_counter_addr29,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
extu.b r3,r5
lds.l	@r15+,pr
mov.l __io_cycle_counter_addr29,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
mov.l @r15+,r3
mov.l @r15+,r2
rts
mov.l @r15+,r4
.align 2
__io_cycle_counter_addr29: .long __io_cycle_counter
.align 5
writememoryword:
writememorydecword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov r4,r0
mov #-12,r1
shld r1,r0
mov.l @(writeword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writew_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writew_callio
mov.l @(12,r0),r0
mov.w r3,@(r0,r4)
rts
mov.l @r15+,r4
writew_outofrange:
rts
mov.l @r15+,r4
.align 5
writew_callio:
mov.l r2,@-r15
mov.l r3,@-r15
mov.l __io_cycle_counter_addr31,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
extu.w r3,r5
lds.l	@r15+,pr
mov.l __io_cycle_counter_addr31,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
mov.l @r15+,r3
mov.l @r15+,r2
rts
mov.l @r15+,r4
.align 2
__io_cycle_counter_addr31: .long __io_cycle_counter
.align 5
writememorydword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov r4,r0
mov #-12,r1
shld r1,r0
mov.l @(writeword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writel_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writel_callio
mov.l @(12,r0),r0
mov r3,r1
shlr16 r1
mov.w r1,@(r0,r4)
add #2,r4
mov.w r3,@(r0,r4)
rts
mov.l @r15+,r4
writel_outofrange:
bra readw_outofrange
nop
.align 5
writel_callio:
mov.l @(8,r0),r1
mov.l __io_cycle_counter_addr33,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
mov.l r2,@-r15
mov.l r3,@-r15
sts.l	pr,@-r15
mov.l r4,@-r15
mov.l r1,@-r15
mov r3,r5
jsr @r1
shlr16 r5
mov.l @r15+,r1
mov.l @r15+,r4
mov.l @(4,r15),r5
add #2,r4
jsr @r1
extu.w r5,r5
lds.l	@r15+,pr
mov.l @r15+,r3
mov.l @r15+,r2
mov.l __io_cycle_counter_addr33,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
rts
mov.l @r15+,r4
.align 2
__io_cycle_counter_addr33: .long __io_cycle_counter
.align 5
writememorydecdword:
sts.l pr,@-r15
mov.l writememoryword_addr35,r0
jsr @r0
add #2,r4
mov.l writememoryword_addr35,r0
swap.w r3,r3
jsr @r0
add #-2,r4
lds.l @r15+,pr
rts
swap.w r3,r3
.align 2
writememoryword_addr35: .long writememoryword
.align 5
decode_extw:
mov.w @r6+,r0
exts.b r0,r4
shlr8 r0
shlr2 r0
tst #0x02,r0
and #0x3c,r0
bf/s longwd
mov.l @(r0,r13),r0
exts.w r0,r0
longwd:
add r1,r4
rts
add r0,r4
.align 5
group_1_exception:
group_2_exception:
mov.l icusthandler_addr36,r0
mov.l @r0,r0
tst r0,r0
bt .vect_except
mov r4,r1
mov.l @(r0,r1),r1
tst r1,r1
bt .vect_except
mov.l r3,@-r15
rotl r3
mov r8,r0
addc r9,r9
shlr2 r0
rotr r3
and #1,r0
xor r0,r9
mov r8,r0
tst r3,r3
addc r9,r9
and #3,r0
shll2 r9
or r0,r9
mov.l sreg_addr36,r0
mov.b r9,@r0
mov.l __io_cycle_counter_addr36,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
sts.l pr,@-r15
jsr @r1
shlr2 r4
lds.l @r15+,pr
mov.l __io_cycle_counter_addr36,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
mov.l @r15+,r3
mov.l @(sreg - areg,r14),r0
mov #3,r8
and r0,r8
mov r0,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
rts
sub r5,r6
.align 5
.vect_except:
sts.l	pr,@-r15
mov.l r3,@-r15
mov.l readmemorydword_addr36,r0
jsr @r0
sub r5,r6
mov r3,r2
mov.l @r15,r3
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov r3,r5
mov.l @(sreg-areg,r14),r0
mov #0x20,r1
shll8 r1
tst r1,r0
bf ln37
or r1,r0
mov.l r0,@(sreg-areg,r14)
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln37:
mov.l sreg_addr36,r1
mov.b @(1,r1),r0
mov r6,r3
and #0x27,r0
mov.b r0,@(1,r1)
mov.l @(60,r13),r4
mov.l writememorydword_addr36,r0
jsr @r0
add #-4,r4
mov r5,r3
mov.l writememoryword_addr36,r0
jsr @r0
add #-2,r4
mov.l @r15+,r3
mov.l r4,@(60,r13)
lds.l	@r15+,pr
rts
mov r2,r6
.align 2
readmemoryword_addr36: .long readmemoryword
readmemorydword_addr36: .long readmemorydword
writememoryword_addr36: .long writememoryword
writememorydword_addr36: .long writememorydword
icusthandler_addr36: .long icusthandler
__io_cycle_counter_addr36: .long __io_cycle_counter
execinfo_addr36: .long execinfo
sreg_addr36: .long sreg
.align 5
privilege_violation:
add #-2,r6
bsr group_1_exception
mov #0x20,r4
mov.l bf_addr38,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-34,r7
.align 2
bf_addr38: .long basefunction
.align 5
fdl:
mov.w @r6+,r0
cmp/pl r7
shll2 r0
bt/s fdl_exec
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl_exec:
mov #0x1C,r2
jmp @r4
and r0,r2
.align 5
fdl_cp:
mov.w @r6+,r0
cmp/pl r7
shll2 r0
bt/s continue39
mov.l @(r0,r12),r4
bra fdl39
mov.l @(execexit_addr-areg,r14),r4
continue39:
mov.l flush_irqs_addr,r1
add #-2,r6
jmp @r1
sub r5,r6
fdl39:
mov #0x1C,r2
jmp @r4
and r0,r2
.align 2
flush_irqs_addr: .long flush_irqs
! Opcodes 0000 - 0007
K000:
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
or r1,r3
mov.b r3,@r2
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 0010 - 0017
K010:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0018 - 001F
K018:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0020 - 0027
K020:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 0028 - 002F
K028:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 0030 - 0037
K030:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 0038
K038:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 0039
K039:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 003C
K03C:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
or r2,r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-20,r7
! Opcodes 0040 - 0047
K040:
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
or r1,r3
mov.w r3,@r2
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 0050 - 0057
K050:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0058 - 005F
K058:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0060 - 0067
K060:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 0068 - 006F
K068:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 0070 - 0077
K070:
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 0078
K078:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 0079
K079:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 007C
K07C:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok40
mov.l priviolation_addr40,r0
jmp @r0
nop
.align 2
priviolation_addr40: .long privilege_violation
pcheck_ok40:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
or r2,r3
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln41
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln41:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr43,r4
jmp @r4
add #-20,r7
.align 2
fdl_cp_addr43: .long fdl_cp
! Opcodes 0080 - 0087
K080:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
or r1,r3
mov.l r3,@r2
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0090 - 0097
K090:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 0098 - 009F
K098:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 00A0 - 00A7
K0A0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 00A8 - 00AF
K0A8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcodes 00B0 - 00B7
K0B0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 00B8
K0B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 00B9
K0B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-36,r7
! Opcodes 0100 - 0107
K100:
mov.b @r13,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0108 - 010F
K108:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.w r2,@r13
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0110 - 0117
K110:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0118 - 011F
K118:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0120 - 0127
K120:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0128 - 012F
K128:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0130 - 0137
K130:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0138
K138:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0139
K139:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 013A
K13A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 013B
K13B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 013C
K13C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0140 - 0147
K140:
mov.b @r13,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0148 - 014F
K148:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@r13
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0150 - 0157
K150:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0158 - 015F
K158:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0160 - 0167
K160:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0168 - 016F
K168:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0170 - 0177
K170:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0178
K178:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0179
K179:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0180 - 0187
K180:
mov.b @r13,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0188 - 018F
K188:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @r13,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0190 - 0197
K190:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0198 - 019F
K198:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 01A0 - 01A7
K1A0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 01A8 - 01AF
K1A8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 01B0 - 01B7
K1B0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 01B8
K1B8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 01B9
K1B9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 01C0 - 01C7
K1C0:
mov.b @r13,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 01C8 - 01CF
K1C8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @r13,r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 01D0 - 01D7
K1D0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 01D8 - 01DF
K1D8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 01E0 - 01E7
K1E0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 01E8 - 01EF
K1E8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 01F0 - 01F7
K1F0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 01F8
K1F8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 01F9
K1F9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0200 - 0207
K200:
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
and r1,r3
mov.b r3,@r2
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 0210 - 0217
K210:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0218 - 021F
K218:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0220 - 0227
K220:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 0228 - 022F
K228:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 0230 - 0237
K230:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 0238
K238:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 0239
K239:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 023C
K23C:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
and r2,r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-20,r7
! Opcodes 0240 - 0247
K240:
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
and r1,r3
mov.w r3,@r2
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 0250 - 0257
K250:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0258 - 025F
K258:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0260 - 0267
K260:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 0268 - 026F
K268:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 0270 - 0277
K270:
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 0278
K278:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 0279
K279:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 027C
K27C:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok44
mov.l priviolation_addr44,r0
jmp @r0
nop
.align 2
priviolation_addr44: .long privilege_violation
pcheck_ok44:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
and r2,r3
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln45
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln45:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr47,r4
jmp @r4
add #-20,r7
.align 2
fdl_cp_addr47: .long fdl_cp
! Opcodes 0280 - 0287
K280:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
and r1,r3
mov.l r3,@r2
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 0290 - 0297
K290:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 0298 - 029F
K298:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 02A0 - 02A7
K2A0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 02A8 - 02AF
K2A8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcodes 02B0 - 02B7
K2B0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 02B8
K2B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 02B9
K2B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-36,r7
! Opcodes 0300 - 0307
K300:
mov.b @(4,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0308 - 030F
K308:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #4,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0310 - 0317
K310:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0318 - 031F
K318:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0320 - 0327
K320:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0328 - 032F
K328:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0330 - 0337
K330:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0338
K338:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0339
K339:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 033A
K33A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 033B
K33B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 033C
K33C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0340 - 0347
K340:
mov.b @(4,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0348 - 034F
K348:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(4,r13)
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0350 - 0357
K350:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0358 - 035F
K358:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0360 - 0367
K360:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0368 - 036F
K368:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0370 - 0377
K370:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0378
K378:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0379
K379:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0380 - 0387
K380:
mov.b @(4,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0388 - 038F
K388:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(4,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0390 - 0397
K390:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0398 - 039F
K398:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 03A0 - 03A7
K3A0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 03A8 - 03AF
K3A8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 03B0 - 03B7
K3B0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 03B8
K3B8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 03B9
K3B9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 03C0 - 03C7
K3C0:
mov.b @(4,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 03C8 - 03CF
K3C8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(4,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 03D0 - 03D7
K3D0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 03D8 - 03DF
K3D8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 03E0 - 03E7
K3E0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 03E8 - 03EF
K3E8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 03F0 - 03F7
K3F0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 03F8
K3F8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 03F9
K3F9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(4,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0400 - 0407
K400:
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-8,r7
! Opcodes 0410 - 0417
K410:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 0418 - 041F
K418:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-16,r7
! Opcodes 0420 - 0427
K420:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-18,r7
! Opcodes 0428 - 042F
K428:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 0430 - 0437
K430:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-22,r7
! Opcode 0438
K438:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcode 0439
K439:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 0440 - 0447
K440:
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-8,r7
! Opcodes 0450 - 0457
K450:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 0458 - 045F
K458:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-16,r7
! Opcodes 0460 - 0467
K460:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-18,r7
! Opcodes 0468 - 046F
K468:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 0470 - 0477
K470:
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-22,r7
! Opcode 0478
K478:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcode 0479
K479:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 0480 - 0487
K480:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-16,r7
! Opcodes 0490 - 0497
K490:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 0498 - 049F
K498:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-28,r7
! Opcodes 04A0 - 04A7
K4A0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-30,r7
! Opcodes 04A8 - 04AF
K4A8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-32,r7
! Opcodes 04B0 - 04B7
K4B0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-34,r7
! Opcode 04B8
K4B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-32,r7
! Opcode 04B9
K4B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-36,r7
! Opcodes 0500 - 0507
K500:
mov.b @(8,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0508 - 050F
K508:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #8,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0510 - 0517
K510:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0518 - 051F
K518:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0520 - 0527
K520:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0528 - 052F
K528:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0530 - 0537
K530:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0538
K538:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0539
K539:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 053A
K53A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 053B
K53B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 053C
K53C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0540 - 0547
K540:
mov.b @(8,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0548 - 054F
K548:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(8,r13)
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0550 - 0557
K550:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0558 - 055F
K558:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0560 - 0567
K560:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0568 - 056F
K568:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0570 - 0577
K570:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0578
K578:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0579
K579:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0580 - 0587
K580:
mov.b @(8,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0588 - 058F
K588:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(8,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0590 - 0597
K590:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0598 - 059F
K598:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 05A0 - 05A7
K5A0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 05A8 - 05AF
K5A8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 05B0 - 05B7
K5B0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 05B8
K5B8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 05B9
K5B9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 05C0 - 05C7
K5C0:
mov.b @(8,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 05C8 - 05CF
K5C8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(8,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 05D0 - 05D7
K5D0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 05D8 - 05DF
K5D8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 05E0 - 05E7
K5E0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 05E8 - 05EF
K5E8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 05F0 - 05F7
K5F0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 05F8
K5F8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 05F9
K5F9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(8,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0600 - 0607
K600:
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-8,r7
! Opcodes 0610 - 0617
K610:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 0618 - 061F
K618:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-16,r7
! Opcodes 0620 - 0627
K620:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-18,r7
! Opcodes 0628 - 062F
K628:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 0630 - 0637
K630:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-22,r7
! Opcode 0638
K638:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcode 0639
K639:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 0640 - 0647
K640:
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-8,r7
! Opcodes 0650 - 0657
K650:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 0658 - 065F
K658:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-16,r7
! Opcodes 0660 - 0667
K660:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-18,r7
! Opcodes 0668 - 066F
K668:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 0670 - 0677
K670:
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-22,r7
! Opcode 0678
K678:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcode 0679
K679:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 0680 - 0687
K680:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-16,r7
! Opcodes 0690 - 0697
K690:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 0698 - 069F
K698:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-28,r7
! Opcodes 06A0 - 06A7
K6A0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-30,r7
! Opcodes 06A8 - 06AF
K6A8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-32,r7
! Opcodes 06B0 - 06B7
K6B0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-34,r7
! Opcode 06B8
K6B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-32,r7
! Opcode 06B9
K6B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-36,r7
! Opcodes 0700 - 0707
K700:
mov.b @(12,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0708 - 070F
K708:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #12,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0710 - 0717
K710:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0718 - 071F
K718:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0720 - 0727
K720:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0728 - 072F
K728:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0730 - 0737
K730:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0738
K738:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0739
K739:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 073A
K73A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 073B
K73B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 073C
K73C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0740 - 0747
K740:
mov.b @(12,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0748 - 074F
K748:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(12,r13)
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0750 - 0757
K750:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0758 - 075F
K758:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0760 - 0767
K760:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0768 - 076F
K768:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0770 - 0777
K770:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0778
K778:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0779
K779:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0780 - 0787
K780:
mov.b @(12,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0788 - 078F
K788:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(12,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0790 - 0797
K790:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0798 - 079F
K798:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 07A0 - 07A7
K7A0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 07A8 - 07AF
K7A8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 07B0 - 07B7
K7B0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 07B8
K7B8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 07B9
K7B9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 07C0 - 07C7
K7C0:
mov.b @(12,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 07C8 - 07CF
K7C8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(12,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 07D0 - 07D7
K7D0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 07D8 - 07DF
K7D8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 07E0 - 07E7
K7E0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 07E8 - 07EF
K7E8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 07F0 - 07F7
K7F0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 07F8
K7F8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 07F9
K7F9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @(12,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0800 - 0807
K800:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-10,r7
! Opcodes 0810 - 0817
K810:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0818 - 081F
K818:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0820 - 0827
K820:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcodes 0828 - 082F
K828:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcodes 0830 - 0837
K830:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-18,r7
! Opcode 0838
K838:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 0839
K839:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-20,r7
! Opcode 083A
K83A:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 083B
K83B:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-18,r7
! Opcode 083C
K83C:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.b @r6,r3
add #2,r6
mov.l @r15+,r0
mov #1,r1
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0840 - 0847
K840:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-12,r7
! Opcodes 0850 - 0857
K850:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0858 - 085F
K858:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0860 - 0867
K860:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcodes 0868 - 086F
K868:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0870 - 0877
K870:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-22,r7
! Opcode 0878
K878:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcode 0879
K879:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-24,r7
! Opcodes 0880 - 0887
K880:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-14,r7
! Opcodes 0890 - 0897
K890:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0898 - 089F
K898:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 08A0 - 08A7
K8A0:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcodes 08A8 - 08AF
K8A8:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 08B0 - 08B7
K8B0:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-22,r7
! Opcode 08B8
K8B8:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcode 08B9
K8B9:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-24,r7
! Opcodes 08C0 - 08C7
K8C0:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-12,r7
! Opcodes 08D0 - 08D7
K8D0:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 08D8 - 08DF
K8D8:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 08E0 - 08E7
K8E0:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcodes 08E8 - 08EF
K8E8:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 08F0 - 08F7
K8F0:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-22,r7
! Opcode 08F8
K8F8:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcode 08F9
K8F9:
mov.w @r6+,r0
rotl r3
movt r1
shll2 r1
xor r1,r8
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-24,r7
! Opcodes 0900 - 0907
K900:
mov #16,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0908 - 090F
K908:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #16,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0910 - 0917
K910:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0918 - 091F
K918:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0920 - 0927
K920:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0928 - 092F
K928:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0930 - 0937
K930:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0938
K938:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0939
K939:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 093A
K93A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 093B
K93B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 093C
K93C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0940 - 0947
K940:
mov #16,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0948 - 094F
K948:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(16,r13)
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0950 - 0957
K950:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0958 - 095F
K958:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0960 - 0967
K960:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0968 - 096F
K968:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0970 - 0977
K970:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0978
K978:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0979
K979:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0980 - 0987
K980:
mov #16,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0988 - 098F
K988:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(16,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0990 - 0997
K990:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0998 - 099F
K998:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 09A0 - 09A7
K9A0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 09A8 - 09AF
K9A8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 09B0 - 09B7
K9B0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 09B8
K9B8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 09B9
K9B9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 09C0 - 09C7
K9C0:
mov #16,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 09C8 - 09CF
K9C8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(16,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 09D0 - 09D7
K9D0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 09D8 - 09DF
K9D8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 09E0 - 09E7
K9E0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 09E8 - 09EF
K9E8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 09F0 - 09F7
K9F0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 09F8
K9F8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 09F9
K9F9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0A00 - 0A07
KA00:
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
xor r1,r3
mov.b r3,@r2
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 0A10 - 0A17
KA10:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0A18 - 0A1F
KA18:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0A20 - 0A27
KA20:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 0A28 - 0A2F
KA28:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 0A30 - 0A37
KA30:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 0A38
KA38:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 0A39
KA39:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 0A3C
KA3C:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
xor r2,r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-20,r7
! Opcodes 0A40 - 0A47
KA40:
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
xor r1,r3
mov.w r3,@r2
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 0A50 - 0A57
KA50:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0A58 - 0A5F
KA58:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0A60 - 0A67
KA60:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 0A68 - 0A6F
KA68:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 0A70 - 0A77
KA70:
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 0A78
KA78:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 0A79
KA79:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 0A7C
KA7C:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok48
mov.l priviolation_addr48,r0
jmp @r0
nop
.align 2
priviolation_addr48: .long privilege_violation
pcheck_ok48:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
xor r2,r3
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln49
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln49:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr51,r4
jmp @r4
add #-20,r7
.align 2
fdl_cp_addr51: .long fdl_cp
! Opcodes 0A80 - 0A87
KA80:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
xor r1,r3
mov.l r3,@r2
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 0A90 - 0A97
KA90:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 0A98 - 0A9F
KA98:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 0AA0 - 0AA7
KAA0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 0AA8 - 0AAF
KAA8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcodes 0AB0 - 0AB7
KAB0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 0AB8
KAB8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 0AB9
KAB9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-36,r7
! Opcodes 0B00 - 0B07
KB00:
mov #20,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0B08 - 0B0F
KB08:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #20,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0B10 - 0B17
KB10:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0B18 - 0B1F
KB18:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0B20 - 0B27
KB20:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0B28 - 0B2F
KB28:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0B30 - 0B37
KB30:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0B38
KB38:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0B39
KB39:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 0B3A
KB3A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0B3B
KB3B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0B3C
KB3C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0B40 - 0B47
KB40:
mov #20,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0B48 - 0B4F
KB48:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(20,r13)
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0B50 - 0B57
KB50:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0B58 - 0B5F
KB58:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0B60 - 0B67
KB60:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0B68 - 0B6F
KB68:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0B70 - 0B77
KB70:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0B78
KB78:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0B79
KB79:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0B80 - 0B87
KB80:
mov #20,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0B88 - 0B8F
KB88:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(20,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0B90 - 0B97
KB90:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0B98 - 0B9F
KB98:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0BA0 - 0BA7
KBA0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0BA8 - 0BAF
KBA8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0BB0 - 0BB7
KBB0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0BB8
KBB8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0BB9
KBB9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0BC0 - 0BC7
KBC0:
mov #20,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0BC8 - 0BCF
KBC8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(20,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0BD0 - 0BD7
KBD0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0BD8 - 0BDF
KBD8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0BE0 - 0BE7
KBE0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0BE8 - 0BEF
KBE8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0BF0 - 0BF7
KBF0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0BF8
KBF8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0BF9
KBF9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0C00 - 0C07
KC00:
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-8,r7
! Opcodes 0C10 - 0C17
KC10:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-12,r7
! Opcodes 0C18 - 0C1F
KC18:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-12,r7
! Opcodes 0C20 - 0C27
KC20:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-14,r7
! Opcodes 0C28 - 0C2F
KC28:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-16,r7
! Opcodes 0C30 - 0C37
KC30:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-18,r7
! Opcode 0C38
KC38:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-16,r7
! Opcode 0C39
KC39:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-24,r0
shad r0,r3
jmp @r10
add #-20,r7
! Opcodes 0C40 - 0C47
KC40:
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-8,r7
! Opcodes 0C50 - 0C57
KC50:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-12,r7
! Opcodes 0C58 - 0C5F
KC58:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-12,r7
! Opcodes 0C60 - 0C67
KC60:
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-14,r7
! Opcodes 0C68 - 0C6F
KC68:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-16,r7
! Opcodes 0C70 - 0C77
KC70:
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-18,r7
! Opcode 0C78
KC78:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-16,r7
! Opcode 0C79
KC79:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
mov #-16,r0
shad r0,r3
jmp @r10
add #-20,r7
! Opcodes 0C80 - 0C87
KC80:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-14,r7
! Opcodes 0C90 - 0C97
KC90:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-20,r7
! Opcodes 0C98 - 0C9F
KC98:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-20,r7
! Opcodes 0CA0 - 0CA7
KCA0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-22,r7
! Opcodes 0CA8 - 0CAF
KCA8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-24,r7
! Opcodes 0CB0 - 0CB7
KCB0:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-26,r7
! Opcode 0CB8
KCB8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-24,r7
! Opcode 0CB9
KCB9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
addc r8,r8
jmp @r10
add #-28,r7
! Opcodes 0D00 - 0D07
KD00:
mov #24,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0D08 - 0D0F
KD08:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #24,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0D10 - 0D17
KD10:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0D18 - 0D1F
KD18:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0D20 - 0D27
KD20:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0D28 - 0D2F
KD28:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0D30 - 0D37
KD30:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0D38
KD38:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0D39
KD39:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 0D3A
KD3A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0D3B
KD3B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0D3C
KD3C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0D40 - 0D47
KD40:
mov #24,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0D48 - 0D4F
KD48:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(24,r13)
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0D50 - 0D57
KD50:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0D58 - 0D5F
KD58:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0D60 - 0D67
KD60:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0D68 - 0D6F
KD68:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0D70 - 0D77
KD70:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0D78
KD78:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0D79
KD79:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0D80 - 0D87
KD80:
mov #24,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0D88 - 0D8F
KD88:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(24,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0D90 - 0D97
KD90:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0D98 - 0D9F
KD98:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0DA0 - 0DA7
KDA0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0DA8 - 0DAF
KDA8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0DB0 - 0DB7
KDB0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0DB8
KDB8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0DB9
KDB9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0DC0 - 0DC7
KDC0:
mov #24,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0DC8 - 0DCF
KDC8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(24,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0DD0 - 0DD7
KDD0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0DD8 - 0DDF
KDD8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0DE0 - 0DE7
KDE0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0DE8 - 0DEF
KDE8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0DF0 - 0DF7
KDF0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0DF8
KDF8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0DF9
KDF9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0F00 - 0F07
KF00:
mov #28,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
jmp @r10
add #-6,r7
! Opcodes 0F08 - 0F0F
KF08:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #28,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0F10 - 0F17
KF10:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0F18 - 0F1F
KF18:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0F20 - 0F27
KF20:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-10,r7
! Opcodes 0F28 - 0F2F
KF28:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcodes 0F30 - 0F37
KF30:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0F38
KF38:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0F39
KF39:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-16,r7
! Opcode 0F3A
KF3A:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-12,r7
! Opcode 0F3B
KF3B:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-14,r7
! Opcode 0F3C
KF3C:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.b @r6,r3
add #2,r6
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
and r1,r3
jmp @r10
add #-8,r7
! Opcodes 0F40 - 0F47
KF40:
mov #28,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
xor r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0F48 - 0F4F
KF48:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(28,r13)
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0F50 - 0F57
KF50:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0F58 - 0F5F
KF58:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0F60 - 0F67
KF60:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0F68 - 0F6F
KF68:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0F70 - 0F77
KF70:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0F78
KF78:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0F79
KF79:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0F80 - 0F87
KF80:
mov #28,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
not r4,r4
and r4,r1
mov.l r1,@r2
jmp @r10
add #-10,r7
! Opcodes 0F88 - 0F8F
KF88:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(28,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 0F90 - 0F97
KF90:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0F98 - 0F9F
KF98:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0FA0 - 0FA7
KFA0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0FA8 - 0FAF
KFA8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0FB0 - 0FB7
KFB0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0FB8
KFB8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0FB9
KFB9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 0FC0 - 0FC7
KFC0:
mov #28,r0
mov.b @(r0,r13),r0
rotl r3
movt r1
shll2 r1
xor r1,r8
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
shlr r3
or r4,r1
mov.l r1,@r2
jmp @r10
add #-8,r7
! Opcodes 0FC8 - 0FCF
KFC8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(28,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcodes 0FD0 - 0FD7
KFD0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0FD8 - 0FDF
KFD8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-12,r7
! Opcodes 0FE0 - 0FE7
KFE0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-14,r7
! Opcodes 0FE8 - 0FEF
KFE8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcodes 0FF0 - 0FF7
KFF0:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-18,r7
! Opcode 0FF8
KFF8:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-16,r7
! Opcode 0FF9
KFF9:
rotl r3
movt r1
shll2 r1
xor r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
shlr r3
jmp @r10
add #-20,r7
! Opcodes 1000 - 1007
L000:
add r13,r2
mov.b @r2,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1008 - 100F
L008:
add r14,r2
mov.b @r2,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1010 - 1017
L010:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1018 - 101F
L018:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1020 - 1027
L020:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1028 - 102F
L028:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1030 - 1037
L030:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1038
L038:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1039
L039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 103A
L03A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 103B
L03B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 103C
L03C:
mov.b @r6,r3
add #2,r6
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1080 - 1087
L080:
add r13,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1088 - 108F
L088:
add r14,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1090 - 1097
L090:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1098 - 109F
L098:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 10A0 - 10A7
L0A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 10A8 - 10AF
L0A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 10B0 - 10B7
L0B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 10B8
L0B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 10B9
L0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 10BA
L0BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 10BB
L0BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 10BC
L0BC:
mov.b @r6,r3
add #2,r6
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 10C0 - 10C7
L0C0:
add r13,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 10C8 - 10CF
L0C8:
add r14,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 10D0 - 10D7
L0D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 10D8 - 10DF
L0D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 10E0 - 10E7
L0E0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 10E8 - 10EF
L0E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 10F0 - 10F7
L0F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 10F8
L0F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 10F9
L0F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 10FA
L0FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 10FB
L0FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 10FC
L0FC:
mov.b @r6,r3
add #2,r6
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1100 - 1107
L100:
add r13,r2
mov.b @r2,r3
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1108 - 110F
L108:
add r14,r2
mov.b @r2,r3
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1110 - 1117
L110:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1118 - 111F
L118:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1120 - 1127
L120:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1128 - 112F
L128:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1130 - 1137
L130:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1138
L138:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1139
L139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 113A
L13A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 113B
L13B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 113C
L13C:
mov.b @r6,r3
add #2,r6
mov.l @(32,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1140 - 1147
L140:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1148 - 114F
L148:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1150 - 1157
L150:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1158 - 115F
L158:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1160 - 1167
L160:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1168 - 116F
L168:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1170 - 1177
L170:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1178
L178:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1179
L179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 117A
L17A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 117B
L17B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 117C
L17C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1180 - 1187
L180:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1188 - 118F
L188:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1190 - 1197
L190:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1198 - 119F
L198:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 11A0 - 11A7
L1A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 11A8 - 11AF
L1A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 11B0 - 11B7
L1B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 11B8
L1B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 11B9
L1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 11BA
L1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 11BB
L1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 11BC
L1BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 11C0 - 11C7
L1C0:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 11C8 - 11CF
L1C8:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 11D0 - 11D7
L1D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 11D8 - 11DF
L1D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 11E0 - 11E7
L1E0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 11E8 - 11EF
L1E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 11F0 - 11F7
L1F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 11F8
L1F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 11F9
L1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 11FA
L1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 11FB
L1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 11FC
L1FC:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1200 - 1207
L200:
add r13,r2
mov.b @r2,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1208 - 120F
L208:
add r14,r2
mov.b @r2,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1210 - 1217
L210:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1218 - 121F
L218:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1220 - 1227
L220:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1228 - 122F
L228:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1230 - 1237
L230:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1238
L238:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1239
L239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 123A
L23A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 123B
L23B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 123C
L23C:
mov.b @r6,r3
add #2,r6
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1280 - 1287
L280:
add r13,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1288 - 128F
L288:
add r14,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1290 - 1297
L290:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1298 - 129F
L298:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 12A0 - 12A7
L2A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 12A8 - 12AF
L2A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 12B0 - 12B7
L2B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 12B8
L2B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 12B9
L2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 12BA
L2BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 12BB
L2BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 12BC
L2BC:
mov.b @r6,r3
add #2,r6
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 12C0 - 12C7
L2C0:
add r13,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 12C8 - 12CF
L2C8:
add r14,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 12D0 - 12D7
L2D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 12D8 - 12DF
L2D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 12E0 - 12E7
L2E0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 12E8 - 12EF
L2E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 12F0 - 12F7
L2F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 12F8
L2F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 12F9
L2F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 12FA
L2FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 12FB
L2FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 12FC
L2FC:
mov.b @r6,r3
add #2,r6
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1300 - 1307
L300:
add r13,r2
mov.b @r2,r3
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1308 - 130F
L308:
add r14,r2
mov.b @r2,r3
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1310 - 1317
L310:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1318 - 131F
L318:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1320 - 1327
L320:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1328 - 132F
L328:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1330 - 1337
L330:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1338
L338:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1339
L339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 133A
L33A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 133B
L33B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 133C
L33C:
mov.b @r6,r3
add #2,r6
mov.l @(36,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1340 - 1347
L340:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1348 - 134F
L348:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1350 - 1357
L350:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1358 - 135F
L358:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1360 - 1367
L360:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1368 - 136F
L368:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1370 - 1377
L370:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1378
L378:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1379
L379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 137A
L37A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 137B
L37B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 137C
L37C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1380 - 1387
L380:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1388 - 138F
L388:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1390 - 1397
L390:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1398 - 139F
L398:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 13A0 - 13A7
L3A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 13A8 - 13AF
L3A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 13B0 - 13B7
L3B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 13B8
L3B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 13B9
L3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 13BA
L3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 13BB
L3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 13BC
L3BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 13C0 - 13C7
L3C0:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 13C8 - 13CF
L3C8:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 13D0 - 13D7
L3D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 13D8 - 13DF
L3D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 13E0 - 13E7
L3E0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 13E8 - 13EF
L3E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 13F0 - 13F7
L3F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 13F8
L3F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 13F9
L3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 13FA
L3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 13FB
L3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 13FC
L3FC:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1400 - 1407
L400:
add r13,r2
mov.b @r2,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1408 - 140F
L408:
add r14,r2
mov.b @r2,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1410 - 1417
L410:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1418 - 141F
L418:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1420 - 1427
L420:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1428 - 142F
L428:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1430 - 1437
L430:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1438
L438:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1439
L439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 143A
L43A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 143B
L43B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 143C
L43C:
mov.b @r6,r3
add #2,r6
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1480 - 1487
L480:
add r13,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1488 - 148F
L488:
add r14,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1490 - 1497
L490:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1498 - 149F
L498:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 14A0 - 14A7
L4A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 14A8 - 14AF
L4A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 14B0 - 14B7
L4B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 14B8
L4B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 14B9
L4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 14BA
L4BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 14BB
L4BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 14BC
L4BC:
mov.b @r6,r3
add #2,r6
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 14C0 - 14C7
L4C0:
add r13,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 14C8 - 14CF
L4C8:
add r14,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 14D0 - 14D7
L4D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 14D8 - 14DF
L4D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 14E0 - 14E7
L4E0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 14E8 - 14EF
L4E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 14F0 - 14F7
L4F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 14F8
L4F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 14F9
L4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 14FA
L4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 14FB
L4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 14FC
L4FC:
mov.b @r6,r3
add #2,r6
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1500 - 1507
L500:
add r13,r2
mov.b @r2,r3
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1508 - 150F
L508:
add r14,r2
mov.b @r2,r3
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1510 - 1517
L510:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1518 - 151F
L518:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1520 - 1527
L520:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1528 - 152F
L528:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1530 - 1537
L530:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1538
L538:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1539
L539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 153A
L53A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 153B
L53B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 153C
L53C:
mov.b @r6,r3
add #2,r6
mov.l @(40,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1540 - 1547
L540:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1548 - 154F
L548:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1550 - 1557
L550:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1558 - 155F
L558:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1560 - 1567
L560:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1568 - 156F
L568:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1570 - 1577
L570:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1578
L578:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1579
L579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 157A
L57A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 157B
L57B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 157C
L57C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1580 - 1587
L580:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1588 - 158F
L588:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1590 - 1597
L590:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1598 - 159F
L598:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 15A0 - 15A7
L5A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 15A8 - 15AF
L5A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 15B0 - 15B7
L5B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 15B8
L5B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 15B9
L5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 15BA
L5BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 15BB
L5BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 15BC
L5BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1600 - 1607
L600:
add r13,r2
mov.b @r2,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1608 - 160F
L608:
add r14,r2
mov.b @r2,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1610 - 1617
L610:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1618 - 161F
L618:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1620 - 1627
L620:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1628 - 162F
L628:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1630 - 1637
L630:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1638
L638:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1639
L639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 163A
L63A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 163B
L63B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 163C
L63C:
mov.b @r6,r3
add #2,r6
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1680 - 1687
L680:
add r13,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1688 - 168F
L688:
add r14,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1690 - 1697
L690:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1698 - 169F
L698:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 16A0 - 16A7
L6A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 16A8 - 16AF
L6A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 16B0 - 16B7
L6B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 16B8
L6B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 16B9
L6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 16BA
L6BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 16BB
L6BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 16BC
L6BC:
mov.b @r6,r3
add #2,r6
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 16C0 - 16C7
L6C0:
add r13,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 16C8 - 16CF
L6C8:
add r14,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 16D0 - 16D7
L6D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 16D8 - 16DF
L6D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 16E0 - 16E7
L6E0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 16E8 - 16EF
L6E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 16F0 - 16F7
L6F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 16F8
L6F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 16F9
L6F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 16FA
L6FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 16FB
L6FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 16FC
L6FC:
mov.b @r6,r3
add #2,r6
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1700 - 1707
L700:
add r13,r2
mov.b @r2,r3
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1708 - 170F
L708:
add r14,r2
mov.b @r2,r3
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1710 - 1717
L710:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1718 - 171F
L718:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1720 - 1727
L720:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1728 - 172F
L728:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1730 - 1737
L730:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1738
L738:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1739
L739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 173A
L73A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 173B
L73B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 173C
L73C:
mov.b @r6,r3
add #2,r6
mov.l @(44,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1740 - 1747
L740:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1748 - 174F
L748:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1750 - 1757
L750:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1758 - 175F
L758:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1760 - 1767
L760:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1768 - 176F
L768:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1770 - 1777
L770:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1778
L778:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1779
L779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 177A
L77A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 177B
L77B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 177C
L77C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1780 - 1787
L780:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1788 - 178F
L788:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1790 - 1797
L790:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1798 - 179F
L798:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 17A0 - 17A7
L7A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 17A8 - 17AF
L7A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 17B0 - 17B7
L7B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 17B8
L7B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 17B9
L7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 17BA
L7BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 17BB
L7BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 17BC
L7BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1800 - 1807
L800:
add r13,r2
mov.b @r2,r3
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1808 - 180F
L808:
add r14,r2
mov.b @r2,r3
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1810 - 1817
L810:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1818 - 181F
L818:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1820 - 1827
L820:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1828 - 182F
L828:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1830 - 1837
L830:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1838
L838:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1839
L839:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 183A
L83A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 183B
L83B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 183C
L83C:
mov.b @r6,r3
add #2,r6
mov #16,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1880 - 1887
L880:
add r13,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1888 - 188F
L888:
add r14,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1890 - 1897
L890:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1898 - 189F
L898:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 18A0 - 18A7
L8A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 18A8 - 18AF
L8A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 18B0 - 18B7
L8B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 18B8
L8B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 18B9
L8B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 18BA
L8BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 18BB
L8BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 18BC
L8BC:
mov.b @r6,r3
add #2,r6
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 18C0 - 18C7
L8C0:
add r13,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 18C8 - 18CF
L8C8:
add r14,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 18D0 - 18D7
L8D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 18D8 - 18DF
L8D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 18E0 - 18E7
L8E0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 18E8 - 18EF
L8E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 18F0 - 18F7
L8F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 18F8
L8F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 18F9
L8F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 18FA
L8FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 18FB
L8FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 18FC
L8FC:
mov.b @r6,r3
add #2,r6
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1900 - 1907
L900:
add r13,r2
mov.b @r2,r3
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1908 - 190F
L908:
add r14,r2
mov.b @r2,r3
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1910 - 1917
L910:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1918 - 191F
L918:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1920 - 1927
L920:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1928 - 192F
L928:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1930 - 1937
L930:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1938
L938:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1939
L939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 193A
L93A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 193B
L93B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 193C
L93C:
mov.b @r6,r3
add #2,r6
mov.l @(48,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1940 - 1947
L940:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1948 - 194F
L948:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1950 - 1957
L950:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1958 - 195F
L958:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1960 - 1967
L960:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1968 - 196F
L968:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1970 - 1977
L970:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1978
L978:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1979
L979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 197A
L97A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 197B
L97B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 197C
L97C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1980 - 1987
L980:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1988 - 198F
L988:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1990 - 1997
L990:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1998 - 199F
L998:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 19A0 - 19A7
L9A0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 19A8 - 19AF
L9A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 19B0 - 19B7
L9B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 19B8
L9B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 19B9
L9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 19BA
L9BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 19BB
L9BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 19BC
L9BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1A00 - 1A07
LA00:
add r13,r2
mov.b @r2,r3
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1A08 - 1A0F
LA08:
add r14,r2
mov.b @r2,r3
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1A10 - 1A17
LA10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1A18 - 1A1F
LA18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1A20 - 1A27
LA20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1A28 - 1A2F
LA28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1A30 - 1A37
LA30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1A38
LA38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1A39
LA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1A3A
LA3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1A3B
LA3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1A3C
LA3C:
mov.b @r6,r3
add #2,r6
mov #20,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1A80 - 1A87
LA80:
add r13,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1A88 - 1A8F
LA88:
add r14,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1A90 - 1A97
LA90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1A98 - 1A9F
LA98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1AA0 - 1AA7
LAA0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1AA8 - 1AAF
LAA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1AB0 - 1AB7
LAB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1AB8
LAB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1AB9
LAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1ABA
LABA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1ABB
LABB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1ABC
LABC:
mov.b @r6,r3
add #2,r6
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1AC0 - 1AC7
LAC0:
add r13,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1AC8 - 1ACF
LAC8:
add r14,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1AD0 - 1AD7
LAD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1AD8 - 1ADF
LAD8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1AE0 - 1AE7
LAE0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1AE8 - 1AEF
LAE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1AF0 - 1AF7
LAF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1AF8
LAF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1AF9
LAF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1AFA
LAFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1AFB
LAFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1AFC
LAFC:
mov.b @r6,r3
add #2,r6
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1B00 - 1B07
LB00:
add r13,r2
mov.b @r2,r3
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1B08 - 1B0F
LB08:
add r14,r2
mov.b @r2,r3
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1B10 - 1B17
LB10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1B18 - 1B1F
LB18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1B20 - 1B27
LB20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1B28 - 1B2F
LB28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1B30 - 1B37
LB30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1B38
LB38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1B39
LB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1B3A
LB3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1B3B
LB3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1B3C
LB3C:
mov.b @r6,r3
add #2,r6
mov.l @(52,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1B40 - 1B47
LB40:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1B48 - 1B4F
LB48:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1B50 - 1B57
LB50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1B58 - 1B5F
LB58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1B60 - 1B67
LB60:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1B68 - 1B6F
LB68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1B70 - 1B77
LB70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1B78
LB78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1B79
LB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1B7A
LB7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1B7B
LB7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1B7C
LB7C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1B80 - 1B87
LB80:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1B88 - 1B8F
LB88:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1B90 - 1B97
LB90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1B98 - 1B9F
LB98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1BA0 - 1BA7
LBA0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1BA8 - 1BAF
LBA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 1BB0 - 1BB7
LBB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1BB8
LBB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1BB9
LBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 1BBA
LBBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1BBB
LBBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1BBC
LBBC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1C00 - 1C07
LC00:
add r13,r2
mov.b @r2,r3
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1C08 - 1C0F
LC08:
add r14,r2
mov.b @r2,r3
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1C10 - 1C17
LC10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1C18 - 1C1F
LC18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1C20 - 1C27
LC20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1C28 - 1C2F
LC28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1C30 - 1C37
LC30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1C38
LC38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1C39
LC39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1C3A
LC3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1C3B
LC3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1C3C
LC3C:
mov.b @r6,r3
add #2,r6
mov #24,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1C80 - 1C87
LC80:
add r13,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1C88 - 1C8F
LC88:
add r14,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1C90 - 1C97
LC90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1C98 - 1C9F
LC98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1CA0 - 1CA7
LCA0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1CA8 - 1CAF
LCA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1CB0 - 1CB7
LCB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1CB8
LCB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1CB9
LCB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1CBA
LCBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1CBB
LCBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1CBC
LCBC:
mov.b @r6,r3
add #2,r6
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1CC0 - 1CC7
LCC0:
add r13,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1CC8 - 1CCF
LCC8:
add r14,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1CD0 - 1CD7
LCD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1CD8 - 1CDF
LCD8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1CE0 - 1CE7
LCE0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1CE8 - 1CEF
LCE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1CF0 - 1CF7
LCF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1CF8
LCF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1CF9
LCF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1CFA
LCFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1CFB
LCFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1CFC
LCFC:
mov.b @r6,r3
add #2,r6
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1D00 - 1D07
LD00:
add r13,r2
mov.b @r2,r3
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1D08 - 1D0F
LD08:
add r14,r2
mov.b @r2,r3
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1D10 - 1D17
LD10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1D18 - 1D1F
LD18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1D20 - 1D27
LD20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1D28 - 1D2F
LD28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1D30 - 1D37
LD30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1D38
LD38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1D39
LD39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1D3A
LD3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1D3B
LD3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1D3C
LD3C:
mov.b @r6,r3
add #2,r6
mov.l @(56,r13),r4
add #-1,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1D40 - 1D47
LD40:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1D48 - 1D4F
LD48:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1D50 - 1D57
LD50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1D58 - 1D5F
LD58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1D60 - 1D67
LD60:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1D68 - 1D6F
LD68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1D70 - 1D77
LD70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1D78
LD78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1D79
LD79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1D7A
LD7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1D7B
LD7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1D7C
LD7C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1D80 - 1D87
LD80:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1D88 - 1D8F
LD88:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1D90 - 1D97
LD90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1D98 - 1D9F
LD98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1DA0 - 1DA7
LDA0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1DA8 - 1DAF
LDA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 1DB0 - 1DB7
LDB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1DB8
LDB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1DB9
LDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 1DBA
LDBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1DBB
LDBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1DBC
LDBC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1E00 - 1E07
LE00:
add r13,r2
mov.b @r2,r3
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1E08 - 1E0F
LE08:
add r14,r2
mov.b @r2,r3
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 1E10 - 1E17
LE10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1E18 - 1E1F
LE18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1E20 - 1E27
LE20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 1E28 - 1E2F
LE28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1E30 - 1E37
LE30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1E38
LE38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1E39
LE39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1E3A
LE3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 1E3B
LE3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 1E3C
LE3C:
mov.b @r6,r3
add #2,r6
mov #28,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1E80 - 1E87
LE80:
add r13,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1E88 - 1E8F
LE88:
add r14,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1E90 - 1E97
LE90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1E98 - 1E9F
LE98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1EA0 - 1EA7
LEA0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1EA8 - 1EAF
LEA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1EB0 - 1EB7
LEB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1EB8
LEB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1EB9
LEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1EBA
LEBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1EBB
LEBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1EBC
LEBC:
mov.b @r6,r3
add #2,r6
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1EC0 - 1EC7
LEC0:
add r13,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1EC8 - 1ECF
LEC8:
add r14,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1ED0 - 1ED7
LED0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1ED8 - 1EDF
LED8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1EE0 - 1EE7
LEE0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1EE8 - 1EEF
LEE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1EF0 - 1EF7
LEF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1EF8
LEF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1EF9
LEF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1EFA
LEFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1EFB
LEFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1EFC
LEFC:
mov.b @r6,r3
add #2,r6
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1F00 - 1F07
LF00:
add r13,r2
mov.b @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1F08 - 1F0F
LF08:
add r14,r2
mov.b @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 1F10 - 1F17
LF10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1F18 - 1F1F
LF18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1F20 - 1F27
LF20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1F28 - 1F2F
LF28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1F30 - 1F37
LF30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1F38
LF38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1F39
LF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1F3A
LF3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 1F3B
LF3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 1F3C
LF3C:
mov.b @r6,r3
add #2,r6
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1F40 - 1F47
LF40:
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1F48 - 1F4F
LF48:
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 1F50 - 1F57
LF50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1F58 - 1F5F
LF58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1F60 - 1F67
LF60:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1F68 - 1F6F
LF68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1F70 - 1F77
LF70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1F78
LF78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1F79
LF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1F7A
LF7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 1F7B
LF7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1F7C
LF7C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 1F80 - 1F87
LF80:
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1F88 - 1F8F
LF88:
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 1F90 - 1F97
LF90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1F98 - 1F9F
LF98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 1FA0 - 1FA7
LFA0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 1FA8 - 1FAF
LFA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 1FB0 - 1FB7
LFB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1FB8
LFB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1FB9
LFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 1FBA
LFBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 1FBB
LFBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 1FBC
LFBC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2000 - 2007
M000:
add r13,r2
mov.l @r2,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2008 - 200F
M008:
add r14,r2
mov.l @r2,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2010 - 2017
M010:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2018 - 201F
M018:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2020 - 2027
M020:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2028 - 202F
M028:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2030 - 2037
M030:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2038
M038:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2039
M039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 203A
M03A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 203B
M03B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 203C
M03C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2040 - 2047
M040:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2048 - 204F
M048:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2050 - 2057
M050:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2058 - 205F
M058:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2060 - 2067
M060:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2068 - 206F
M068:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2070 - 2077
M070:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2078
M078:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2079
M079:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 207A
M07A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 207B
M07B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 207C
M07C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2080 - 2087
M080:
add r13,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2088 - 208F
M088:
add r14,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2090 - 2097
M090:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2098 - 209F
M098:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 20A0 - 20A7
M0A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 20A8 - 20AF
M0A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 20B0 - 20B7
M0B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 20B8
M0B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 20B9
M0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 20BA
M0BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 20BB
M0BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 20BC
M0BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 20C0 - 20C7
M0C0:
add r13,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 20C8 - 20CF
M0C8:
add r14,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 20D0 - 20D7
M0D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 20D8 - 20DF
M0D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 20E0 - 20E7
M0E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 20E8 - 20EF
M0E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 20F0 - 20F7
M0F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 20F8
M0F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 20F9
M0F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 20FA
M0FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 20FB
M0FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 20FC
M0FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2100 - 2107
M100:
add r13,r2
mov.l @r2,r3
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2108 - 210F
M108:
add r14,r2
mov.l @r2,r3
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2110 - 2117
M110:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2118 - 211F
M118:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2120 - 2127
M120:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2128 - 212F
M128:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2130 - 2137
M130:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2138
M138:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2139
M139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 213A
M13A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 213B
M13B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 213C
M13C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2140 - 2147
M140:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2148 - 214F
M148:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2150 - 2157
M150:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2158 - 215F
M158:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2160 - 2167
M160:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2168 - 216F
M168:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2170 - 2177
M170:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2178
M178:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2179
M179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 217A
M17A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 217B
M17B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 217C
M17C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2180 - 2187
M180:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2188 - 218F
M188:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2190 - 2197
M190:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2198 - 219F
M198:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 21A0 - 21A7
M1A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 21A8 - 21AF
M1A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 21B0 - 21B7
M1B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 21B8
M1B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 21B9
M1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 21BA
M1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 21BB
M1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 21BC
M1BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 21C0 - 21C7
M1C0:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 21C8 - 21CF
M1C8:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 21D0 - 21D7
M1D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 21D8 - 21DF
M1D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 21E0 - 21E7
M1E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 21E8 - 21EF
M1E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 21F0 - 21F7
M1F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 21F8
M1F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 21F9
M1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 21FA
M1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 21FB
M1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 21FC
M1FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2200 - 2207
M200:
add r13,r2
mov.l @r2,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2208 - 220F
M208:
add r14,r2
mov.l @r2,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2210 - 2217
M210:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2218 - 221F
M218:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2220 - 2227
M220:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2228 - 222F
M228:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2230 - 2237
M230:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2238
M238:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2239
M239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 223A
M23A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 223B
M23B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 223C
M23C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2240 - 2247
M240:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2248 - 224F
M248:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2250 - 2257
M250:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2258 - 225F
M258:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2260 - 2267
M260:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2268 - 226F
M268:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2270 - 2277
M270:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2278
M278:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2279
M279:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 227A
M27A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 227B
M27B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 227C
M27C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2280 - 2287
M280:
add r13,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2288 - 228F
M288:
add r14,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2290 - 2297
M290:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2298 - 229F
M298:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 22A0 - 22A7
M2A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 22A8 - 22AF
M2A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 22B0 - 22B7
M2B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 22B8
M2B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 22B9
M2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 22BA
M2BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 22BB
M2BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 22BC
M2BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 22C0 - 22C7
M2C0:
add r13,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 22C8 - 22CF
M2C8:
add r14,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 22D0 - 22D7
M2D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 22D8 - 22DF
M2D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 22E0 - 22E7
M2E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 22E8 - 22EF
M2E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 22F0 - 22F7
M2F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 22F8
M2F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 22F9
M2F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 22FA
M2FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 22FB
M2FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 22FC
M2FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2300 - 2307
M300:
add r13,r2
mov.l @r2,r3
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2308 - 230F
M308:
add r14,r2
mov.l @r2,r3
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2310 - 2317
M310:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2318 - 231F
M318:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2320 - 2327
M320:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2328 - 232F
M328:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2330 - 2337
M330:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2338
M338:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2339
M339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 233A
M33A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 233B
M33B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 233C
M33C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2340 - 2347
M340:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2348 - 234F
M348:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2350 - 2357
M350:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2358 - 235F
M358:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2360 - 2367
M360:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2368 - 236F
M368:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2370 - 2377
M370:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2378
M378:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2379
M379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 237A
M37A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 237B
M37B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 237C
M37C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2380 - 2387
M380:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2388 - 238F
M388:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2390 - 2397
M390:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2398 - 239F
M398:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 23A0 - 23A7
M3A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 23A8 - 23AF
M3A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 23B0 - 23B7
M3B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 23B8
M3B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 23B9
M3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 23BA
M3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 23BB
M3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 23BC
M3BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 23C0 - 23C7
M3C0:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 23C8 - 23CF
M3C8:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 23D0 - 23D7
M3D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 23D8 - 23DF
M3D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 23E0 - 23E7
M3E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 23E8 - 23EF
M3E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcodes 23F0 - 23F7
M3F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 23F8
M3F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 23F9
M3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-36,r7
! Opcode 23FA
M3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 23FB
M3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 23FC
M3FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2400 - 2407
M400:
add r13,r2
mov.l @r2,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2408 - 240F
M408:
add r14,r2
mov.l @r2,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2410 - 2417
M410:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2418 - 241F
M418:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2420 - 2427
M420:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2428 - 242F
M428:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2430 - 2437
M430:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2438
M438:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2439
M439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 243A
M43A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 243B
M43B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 243C
M43C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2440 - 2447
M440:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2448 - 244F
M448:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2450 - 2457
M450:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2458 - 245F
M458:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2460 - 2467
M460:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2468 - 246F
M468:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2470 - 2477
M470:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2478
M478:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2479
M479:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 247A
M47A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 247B
M47B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 247C
M47C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2480 - 2487
M480:
add r13,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2488 - 248F
M488:
add r14,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2490 - 2497
M490:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2498 - 249F
M498:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 24A0 - 24A7
M4A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 24A8 - 24AF
M4A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 24B0 - 24B7
M4B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 24B8
M4B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 24B9
M4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 24BA
M4BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 24BB
M4BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 24BC
M4BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 24C0 - 24C7
M4C0:
add r13,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 24C8 - 24CF
M4C8:
add r14,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 24D0 - 24D7
M4D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 24D8 - 24DF
M4D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 24E0 - 24E7
M4E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 24E8 - 24EF
M4E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 24F0 - 24F7
M4F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 24F8
M4F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 24F9
M4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 24FA
M4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 24FB
M4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 24FC
M4FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2500 - 2507
M500:
add r13,r2
mov.l @r2,r3
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2508 - 250F
M508:
add r14,r2
mov.l @r2,r3
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2510 - 2517
M510:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2518 - 251F
M518:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2520 - 2527
M520:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2528 - 252F
M528:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2530 - 2537
M530:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2538
M538:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2539
M539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 253A
M53A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 253B
M53B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 253C
M53C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2540 - 2547
M540:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2548 - 254F
M548:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2550 - 2557
M550:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2558 - 255F
M558:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2560 - 2567
M560:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2568 - 256F
M568:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2570 - 2577
M570:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2578
M578:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2579
M579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 257A
M57A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 257B
M57B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 257C
M57C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2580 - 2587
M580:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2588 - 258F
M588:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2590 - 2597
M590:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2598 - 259F
M598:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 25A0 - 25A7
M5A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 25A8 - 25AF
M5A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 25B0 - 25B7
M5B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 25B8
M5B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 25B9
M5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 25BA
M5BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 25BB
M5BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 25BC
M5BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2600 - 2607
M600:
add r13,r2
mov.l @r2,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2608 - 260F
M608:
add r14,r2
mov.l @r2,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2610 - 2617
M610:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2618 - 261F
M618:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2620 - 2627
M620:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2628 - 262F
M628:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2630 - 2637
M630:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2638
M638:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2639
M639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 263A
M63A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 263B
M63B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 263C
M63C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2640 - 2647
M640:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2648 - 264F
M648:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2650 - 2657
M650:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2658 - 265F
M658:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2660 - 2667
M660:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2668 - 266F
M668:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2670 - 2677
M670:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2678
M678:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2679
M679:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 267A
M67A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 267B
M67B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 267C
M67C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2680 - 2687
M680:
add r13,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2688 - 268F
M688:
add r14,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2690 - 2697
M690:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2698 - 269F
M698:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 26A0 - 26A7
M6A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 26A8 - 26AF
M6A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 26B0 - 26B7
M6B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 26B8
M6B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 26B9
M6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 26BA
M6BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 26BB
M6BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 26BC
M6BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 26C0 - 26C7
M6C0:
add r13,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 26C8 - 26CF
M6C8:
add r14,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 26D0 - 26D7
M6D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 26D8 - 26DF
M6D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 26E0 - 26E7
M6E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 26E8 - 26EF
M6E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 26F0 - 26F7
M6F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 26F8
M6F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 26F9
M6F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 26FA
M6FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 26FB
M6FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 26FC
M6FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2700 - 2707
M700:
add r13,r2
mov.l @r2,r3
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2708 - 270F
M708:
add r14,r2
mov.l @r2,r3
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2710 - 2717
M710:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2718 - 271F
M718:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2720 - 2727
M720:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2728 - 272F
M728:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2730 - 2737
M730:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2738
M738:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2739
M739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 273A
M73A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 273B
M73B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 273C
M73C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2740 - 2747
M740:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2748 - 274F
M748:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2750 - 2757
M750:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2758 - 275F
M758:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2760 - 2767
M760:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2768 - 276F
M768:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2770 - 2777
M770:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2778
M778:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2779
M779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 277A
M77A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 277B
M77B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 277C
M77C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2780 - 2787
M780:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2788 - 278F
M788:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2790 - 2797
M790:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2798 - 279F
M798:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 27A0 - 27A7
M7A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 27A8 - 27AF
M7A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 27B0 - 27B7
M7B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 27B8
M7B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 27B9
M7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 27BA
M7BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 27BB
M7BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 27BC
M7BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2800 - 2807
M800:
add r13,r2
mov.l @r2,r3
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2808 - 280F
M808:
add r14,r2
mov.l @r2,r3
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2810 - 2817
M810:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2818 - 281F
M818:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2820 - 2827
M820:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2828 - 282F
M828:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2830 - 2837
M830:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2838
M838:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2839
M839:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 283A
M83A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 283B
M83B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 283C
M83C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2840 - 2847
M840:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2848 - 284F
M848:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2850 - 2857
M850:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2858 - 285F
M858:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2860 - 2867
M860:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2868 - 286F
M868:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2870 - 2877
M870:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2878
M878:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2879
M879:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 287A
M87A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 287B
M87B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 287C
M87C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2880 - 2887
M880:
add r13,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2888 - 288F
M888:
add r14,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2890 - 2897
M890:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2898 - 289F
M898:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 28A0 - 28A7
M8A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 28A8 - 28AF
M8A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 28B0 - 28B7
M8B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 28B8
M8B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 28B9
M8B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 28BA
M8BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 28BB
M8BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 28BC
M8BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 28C0 - 28C7
M8C0:
add r13,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 28C8 - 28CF
M8C8:
add r14,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 28D0 - 28D7
M8D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 28D8 - 28DF
M8D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 28E0 - 28E7
M8E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 28E8 - 28EF
M8E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 28F0 - 28F7
M8F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 28F8
M8F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 28F9
M8F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 28FA
M8FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 28FB
M8FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 28FC
M8FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2900 - 2907
M900:
add r13,r2
mov.l @r2,r3
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2908 - 290F
M908:
add r14,r2
mov.l @r2,r3
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2910 - 2917
M910:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2918 - 291F
M918:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2920 - 2927
M920:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2928 - 292F
M928:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2930 - 2937
M930:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2938
M938:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2939
M939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 293A
M93A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 293B
M93B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 293C
M93C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2940 - 2947
M940:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2948 - 294F
M948:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2950 - 2957
M950:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2958 - 295F
M958:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2960 - 2967
M960:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2968 - 296F
M968:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2970 - 2977
M970:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2978
M978:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2979
M979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 297A
M97A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 297B
M97B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 297C
M97C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2980 - 2987
M980:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2988 - 298F
M988:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2990 - 2997
M990:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2998 - 299F
M998:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 29A0 - 29A7
M9A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 29A8 - 29AF
M9A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 29B0 - 29B7
M9B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 29B8
M9B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 29B9
M9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 29BA
M9BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 29BB
M9BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 29BC
M9BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2A00 - 2A07
MA00:
add r13,r2
mov.l @r2,r3
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2A08 - 2A0F
MA08:
add r14,r2
mov.l @r2,r3
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2A10 - 2A17
MA10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2A18 - 2A1F
MA18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2A20 - 2A27
MA20:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2A28 - 2A2F
MA28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2A30 - 2A37
MA30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2A38
MA38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2A39
MA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 2A3A
MA3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2A3B
MA3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2A3C
MA3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2A40 - 2A47
MA40:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2A48 - 2A4F
MA48:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2A50 - 2A57
MA50:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2A58 - 2A5F
MA58:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2A60 - 2A67
MA60:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2A68 - 2A6F
MA68:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2A70 - 2A77
MA70:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2A78
MA78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2A79
MA79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 2A7A
MA7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2A7B
MA7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2A7C
MA7C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2A80 - 2A87
MA80:
add r13,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2A88 - 2A8F
MA88:
add r14,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2A90 - 2A97
MA90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2A98 - 2A9F
MA98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2AA0 - 2AA7
MAA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2AA8 - 2AAF
MAA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2AB0 - 2AB7
MAB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2AB8
MAB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2AB9
MAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2ABA
MABA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2ABB
MABB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2ABC
MABC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2AC0 - 2AC7
MAC0:
add r13,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2AC8 - 2ACF
MAC8:
add r14,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2AD0 - 2AD7
MAD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2AD8 - 2ADF
MAD8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2AE0 - 2AE7
MAE0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2AE8 - 2AEF
MAE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2AF0 - 2AF7
MAF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2AF8
MAF8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2AF9
MAF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2AFA
MAFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2AFB
MAFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2AFC
MAFC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2B00 - 2B07
MB00:
add r13,r2
mov.l @r2,r3
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2B08 - 2B0F
MB08:
add r14,r2
mov.l @r2,r3
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2B10 - 2B17
MB10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2B18 - 2B1F
MB18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2B20 - 2B27
MB20:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2B28 - 2B2F
MB28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2B30 - 2B37
MB30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2B38
MB38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2B39
MB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2B3A
MB3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2B3B
MB3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2B3C
MB3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2B40 - 2B47
MB40:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2B48 - 2B4F
MB48:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2B50 - 2B57
MB50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2B58 - 2B5F
MB58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2B60 - 2B67
MB60:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2B68 - 2B6F
MB68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2B70 - 2B77
MB70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2B78
MB78:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2B79
MB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2B7A
MB7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2B7B
MB7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2B7C
MB7C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2B80 - 2B87
MB80:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2B88 - 2B8F
MB88:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2B90 - 2B97
MB90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2B98 - 2B9F
MB98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2BA0 - 2BA7
MBA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2BA8 - 2BAF
MBA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 2BB0 - 2BB7
MBB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2BB8
MBB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2BB9
MBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 2BBA
MBBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2BBB
MBBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2BBC
MBBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2C00 - 2C07
MC00:
add r13,r2
mov.l @r2,r3
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2C08 - 2C0F
MC08:
add r14,r2
mov.l @r2,r3
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2C10 - 2C17
MC10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2C18 - 2C1F
MC18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2C20 - 2C27
MC20:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2C28 - 2C2F
MC28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2C30 - 2C37
MC30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2C38
MC38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2C39
MC39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 2C3A
MC3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2C3B
MC3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2C3C
MC3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2C40 - 2C47
MC40:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2C48 - 2C4F
MC48:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2C50 - 2C57
MC50:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2C58 - 2C5F
MC58:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2C60 - 2C67
MC60:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2C68 - 2C6F
MC68:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2C70 - 2C77
MC70:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2C78
MC78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2C79
MC79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 2C7A
MC7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2C7B
MC7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2C7C
MC7C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2C80 - 2C87
MC80:
add r13,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2C88 - 2C8F
MC88:
add r14,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2C90 - 2C97
MC90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2C98 - 2C9F
MC98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2CA0 - 2CA7
MCA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2CA8 - 2CAF
MCA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2CB0 - 2CB7
MCB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2CB8
MCB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2CB9
MCB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2CBA
MCBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2CBB
MCBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2CBC
MCBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2CC0 - 2CC7
MCC0:
add r13,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2CC8 - 2CCF
MCC8:
add r14,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2CD0 - 2CD7
MCD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2CD8 - 2CDF
MCD8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2CE0 - 2CE7
MCE0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2CE8 - 2CEF
MCE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2CF0 - 2CF7
MCF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2CF8
MCF8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2CF9
MCF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2CFA
MCFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2CFB
MCFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2CFC
MCFC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2D00 - 2D07
MD00:
add r13,r2
mov.l @r2,r3
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2D08 - 2D0F
MD08:
add r14,r2
mov.l @r2,r3
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2D10 - 2D17
MD10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2D18 - 2D1F
MD18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2D20 - 2D27
MD20:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2D28 - 2D2F
MD28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2D30 - 2D37
MD30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2D38
MD38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2D39
MD39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2D3A
MD3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2D3B
MD3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2D3C
MD3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2D40 - 2D47
MD40:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2D48 - 2D4F
MD48:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2D50 - 2D57
MD50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2D58 - 2D5F
MD58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2D60 - 2D67
MD60:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2D68 - 2D6F
MD68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2D70 - 2D77
MD70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2D78
MD78:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2D79
MD79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2D7A
MD7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2D7B
MD7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2D7C
MD7C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2D80 - 2D87
MD80:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2D88 - 2D8F
MD88:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2D90 - 2D97
MD90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2D98 - 2D9F
MD98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2DA0 - 2DA7
MDA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2DA8 - 2DAF
MDA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 2DB0 - 2DB7
MDB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2DB8
MDB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2DB9
MDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 2DBA
MDBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2DBB
MDBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2DBC
MDBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2E00 - 2E07
ME00:
add r13,r2
mov.l @r2,r3
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2E08 - 2E0F
ME08:
add r14,r2
mov.l @r2,r3
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 2E10 - 2E17
ME10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2E18 - 2E1F
ME18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2E20 - 2E27
ME20:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 2E28 - 2E2F
ME28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2E30 - 2E37
ME30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2E38
ME38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2E39
ME39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 2E3A
ME3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 2E3B
ME3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 2E3C
ME3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2E40 - 2E47
ME40:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2E48 - 2E4F
ME48:
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 2E50 - 2E57
ME50:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2E58 - 2E5F
ME58:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2E60 - 2E67
ME60:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 2E68 - 2E6F
ME68:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 2E70 - 2E77
ME70:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2E78
ME78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2E79
ME79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 2E7A
ME7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 2E7B
ME7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 2E7C
ME7C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 2E80 - 2E87
ME80:
add r13,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2E88 - 2E8F
ME88:
add r14,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2E90 - 2E97
ME90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2E98 - 2E9F
ME98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2EA0 - 2EA7
MEA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2EA8 - 2EAF
MEA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2EB0 - 2EB7
MEB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2EB8
MEB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2EB9
MEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2EBA
MEBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2EBB
MEBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2EBC
MEBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2EC0 - 2EC7
MEC0:
add r13,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2EC8 - 2ECF
MEC8:
add r14,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2ED0 - 2ED7
MED0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2ED8 - 2EDF
MED8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2EE0 - 2EE7
MEE0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2EE8 - 2EEF
MEE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2EF0 - 2EF7
MEF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2EF8
MEF8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2EF9
MEF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2EFA
MEFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2EFB
MEFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2EFC
MEFC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2F00 - 2F07
MF00:
add r13,r2
mov.l @r2,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2F08 - 2F0F
MF08:
add r14,r2
mov.l @r2,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 2F10 - 2F17
MF10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2F18 - 2F1F
MF18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2F20 - 2F27
MF20:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 2F28 - 2F2F
MF28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2F30 - 2F37
MF30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2F38
MF38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2F39
MF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2F3A
MF3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 2F3B
MF3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 2F3C
MF3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 2F40 - 2F47
MF40:
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2F48 - 2F4F
MF48:
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 2F50 - 2F57
MF50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2F58 - 2F5F
MF58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2F60 - 2F67
MF60:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2F68 - 2F6F
MF68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2F70 - 2F77
MF70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2F78
MF78:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2F79
MF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2F7A
MF7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 2F7B
MF7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2F7C
MF7C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 2F80 - 2F87
MF80:
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2F88 - 2F8F
MF88:
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 2F90 - 2F97
MF90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2F98 - 2F9F
MF98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 2FA0 - 2FA7
MFA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 2FA8 - 2FAF
MFA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcodes 2FB0 - 2FB7
MFB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2FB8
MFB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2FB9
MFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-34,r7
! Opcode 2FBA
MFBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-30,r7
! Opcode 2FBB
MFBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-32,r7
! Opcode 2FBC
MFBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcodes 3000 - 3007
N000:
add r13,r2
mov.w @r2,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3008 - 300F
N008:
add r14,r2
mov.w @r2,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3010 - 3017
N010:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3018 - 301F
N018:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3020 - 3027
N020:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3028 - 302F
N028:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3030 - 3037
N030:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3038
N038:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3039
N039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 303A
N03A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 303B
N03B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 303C
N03C:
mov.w @r6+,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3040 - 3047
N040:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3048 - 304F
N048:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3050 - 3057
N050:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3058 - 305F
N058:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3060 - 3067
N060:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3068 - 306F
N068:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3070 - 3077
N070:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3078
N078:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3079
N079:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 307A
N07A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 307B
N07B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 307C
N07C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3080 - 3087
N080:
add r13,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3088 - 308F
N088:
add r14,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3090 - 3097
N090:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3098 - 309F
N098:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 30A0 - 30A7
N0A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 30A8 - 30AF
N0A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 30B0 - 30B7
N0B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 30B8
N0B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 30B9
N0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 30BA
N0BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 30BB
N0BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 30BC
N0BC:
mov.w @r6+,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 30C0 - 30C7
N0C0:
add r13,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 30C8 - 30CF
N0C8:
add r14,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 30D0 - 30D7
N0D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 30D8 - 30DF
N0D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 30E0 - 30E7
N0E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 30E8 - 30EF
N0E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 30F0 - 30F7
N0F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 30F8
N0F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 30F9
N0F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 30FA
N0FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 30FB
N0FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 30FC
N0FC:
mov.w @r6+,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3100 - 3107
N100:
add r13,r2
mov.w @r2,r3
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3108 - 310F
N108:
add r14,r2
mov.w @r2,r3
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3110 - 3117
N110:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3118 - 311F
N118:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3120 - 3127
N120:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3128 - 312F
N128:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3130 - 3137
N130:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3138
N138:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3139
N139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 313A
N13A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 313B
N13B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 313C
N13C:
mov.w @r6+,r3
mov.l @(32,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3140 - 3147
N140:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3148 - 314F
N148:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3150 - 3157
N150:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3158 - 315F
N158:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3160 - 3167
N160:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3168 - 316F
N168:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3170 - 3177
N170:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3178
N178:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3179
N179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 317A
N17A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 317B
N17B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 317C
N17C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3180 - 3187
N180:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3188 - 318F
N188:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3190 - 3197
N190:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3198 - 319F
N198:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 31A0 - 31A7
N1A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 31A8 - 31AF
N1A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 31B0 - 31B7
N1B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 31B8
N1B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 31B9
N1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 31BA
N1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 31BB
N1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 31BC
N1BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 31C0 - 31C7
N1C0:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 31C8 - 31CF
N1C8:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 31D0 - 31D7
N1D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 31D8 - 31DF
N1D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 31E0 - 31E7
N1E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 31E8 - 31EF
N1E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 31F0 - 31F7
N1F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 31F8
N1F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 31F9
N1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 31FA
N1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 31FB
N1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 31FC
N1FC:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3200 - 3207
N200:
add r13,r2
mov.w @r2,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3208 - 320F
N208:
add r14,r2
mov.w @r2,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3210 - 3217
N210:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3218 - 321F
N218:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3220 - 3227
N220:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3228 - 322F
N228:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3230 - 3237
N230:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3238
N238:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3239
N239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 323A
N23A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 323B
N23B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 323C
N23C:
mov.w @r6+,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3240 - 3247
N240:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3248 - 324F
N248:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3250 - 3257
N250:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3258 - 325F
N258:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3260 - 3267
N260:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3268 - 326F
N268:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3270 - 3277
N270:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3278
N278:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3279
N279:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 327A
N27A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 327B
N27B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 327C
N27C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3280 - 3287
N280:
add r13,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3288 - 328F
N288:
add r14,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3290 - 3297
N290:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3298 - 329F
N298:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 32A0 - 32A7
N2A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 32A8 - 32AF
N2A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 32B0 - 32B7
N2B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 32B8
N2B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 32B9
N2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 32BA
N2BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 32BB
N2BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 32BC
N2BC:
mov.w @r6+,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 32C0 - 32C7
N2C0:
add r13,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 32C8 - 32CF
N2C8:
add r14,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 32D0 - 32D7
N2D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 32D8 - 32DF
N2D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 32E0 - 32E7
N2E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 32E8 - 32EF
N2E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 32F0 - 32F7
N2F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 32F8
N2F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 32F9
N2F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 32FA
N2FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 32FB
N2FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 32FC
N2FC:
mov.w @r6+,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3300 - 3307
N300:
add r13,r2
mov.w @r2,r3
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3308 - 330F
N308:
add r14,r2
mov.w @r2,r3
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3310 - 3317
N310:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3318 - 331F
N318:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3320 - 3327
N320:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3328 - 332F
N328:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3330 - 3337
N330:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3338
N338:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3339
N339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 333A
N33A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 333B
N33B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 333C
N33C:
mov.w @r6+,r3
mov.l @(36,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3340 - 3347
N340:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3348 - 334F
N348:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3350 - 3357
N350:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3358 - 335F
N358:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3360 - 3367
N360:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3368 - 336F
N368:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3370 - 3377
N370:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3378
N378:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3379
N379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 337A
N37A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 337B
N37B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 337C
N37C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3380 - 3387
N380:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3388 - 338F
N388:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3390 - 3397
N390:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3398 - 339F
N398:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 33A0 - 33A7
N3A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 33A8 - 33AF
N3A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 33B0 - 33B7
N3B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 33B8
N3B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 33B9
N3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 33BA
N3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 33BB
N3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 33BC
N3BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 33C0 - 33C7
N3C0:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 33C8 - 33CF
N3C8:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 33D0 - 33D7
N3D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 33D8 - 33DF
N3D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 33E0 - 33E7
N3E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 33E8 - 33EF
N3E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 33F0 - 33F7
N3F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 33F8
N3F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 33F9
N3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcode 33FA
N3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 33FB
N3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 33FC
N3FC:
mov.w @r6+,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3400 - 3407
N400:
add r13,r2
mov.w @r2,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3408 - 340F
N408:
add r14,r2
mov.w @r2,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3410 - 3417
N410:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3418 - 341F
N418:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3420 - 3427
N420:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3428 - 342F
N428:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3430 - 3437
N430:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3438
N438:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3439
N439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 343A
N43A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 343B
N43B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 343C
N43C:
mov.w @r6+,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3440 - 3447
N440:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3448 - 344F
N448:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3450 - 3457
N450:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3458 - 345F
N458:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3460 - 3467
N460:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3468 - 346F
N468:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3470 - 3477
N470:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3478
N478:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3479
N479:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 347A
N47A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 347B
N47B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 347C
N47C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3480 - 3487
N480:
add r13,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3488 - 348F
N488:
add r14,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3490 - 3497
N490:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3498 - 349F
N498:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 34A0 - 34A7
N4A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 34A8 - 34AF
N4A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 34B0 - 34B7
N4B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 34B8
N4B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 34B9
N4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 34BA
N4BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 34BB
N4BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 34BC
N4BC:
mov.w @r6+,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 34C0 - 34C7
N4C0:
add r13,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 34C8 - 34CF
N4C8:
add r14,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 34D0 - 34D7
N4D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 34D8 - 34DF
N4D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 34E0 - 34E7
N4E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 34E8 - 34EF
N4E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 34F0 - 34F7
N4F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 34F8
N4F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 34F9
N4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 34FA
N4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 34FB
N4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 34FC
N4FC:
mov.w @r6+,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3500 - 3507
N500:
add r13,r2
mov.w @r2,r3
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3508 - 350F
N508:
add r14,r2
mov.w @r2,r3
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3510 - 3517
N510:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3518 - 351F
N518:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3520 - 3527
N520:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3528 - 352F
N528:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3530 - 3537
N530:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3538
N538:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3539
N539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 353A
N53A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 353B
N53B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 353C
N53C:
mov.w @r6+,r3
mov.l @(40,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3540 - 3547
N540:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3548 - 354F
N548:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3550 - 3557
N550:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3558 - 355F
N558:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3560 - 3567
N560:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3568 - 356F
N568:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3570 - 3577
N570:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3578
N578:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3579
N579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 357A
N57A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 357B
N57B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 357C
N57C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3580 - 3587
N580:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3588 - 358F
N588:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3590 - 3597
N590:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3598 - 359F
N598:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 35A0 - 35A7
N5A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 35A8 - 35AF
N5A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 35B0 - 35B7
N5B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 35B8
N5B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 35B9
N5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 35BA
N5BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 35BB
N5BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 35BC
N5BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3600 - 3607
N600:
add r13,r2
mov.w @r2,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3608 - 360F
N608:
add r14,r2
mov.w @r2,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3610 - 3617
N610:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3618 - 361F
N618:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3620 - 3627
N620:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3628 - 362F
N628:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3630 - 3637
N630:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3638
N638:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3639
N639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 363A
N63A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 363B
N63B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 363C
N63C:
mov.w @r6+,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3640 - 3647
N640:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3648 - 364F
N648:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3650 - 3657
N650:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3658 - 365F
N658:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3660 - 3667
N660:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3668 - 366F
N668:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3670 - 3677
N670:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3678
N678:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3679
N679:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 367A
N67A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 367B
N67B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 367C
N67C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3680 - 3687
N680:
add r13,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3688 - 368F
N688:
add r14,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3690 - 3697
N690:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3698 - 369F
N698:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 36A0 - 36A7
N6A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 36A8 - 36AF
N6A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 36B0 - 36B7
N6B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 36B8
N6B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 36B9
N6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 36BA
N6BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 36BB
N6BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 36BC
N6BC:
mov.w @r6+,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 36C0 - 36C7
N6C0:
add r13,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 36C8 - 36CF
N6C8:
add r14,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 36D0 - 36D7
N6D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 36D8 - 36DF
N6D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 36E0 - 36E7
N6E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 36E8 - 36EF
N6E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 36F0 - 36F7
N6F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 36F8
N6F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 36F9
N6F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 36FA
N6FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 36FB
N6FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 36FC
N6FC:
mov.w @r6+,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3700 - 3707
N700:
add r13,r2
mov.w @r2,r3
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3708 - 370F
N708:
add r14,r2
mov.w @r2,r3
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3710 - 3717
N710:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3718 - 371F
N718:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3720 - 3727
N720:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3728 - 372F
N728:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3730 - 3737
N730:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3738
N738:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3739
N739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 373A
N73A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 373B
N73B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 373C
N73C:
mov.w @r6+,r3
mov.l @(44,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3740 - 3747
N740:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3748 - 374F
N748:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3750 - 3757
N750:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3758 - 375F
N758:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3760 - 3767
N760:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3768 - 376F
N768:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3770 - 3777
N770:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3778
N778:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3779
N779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 377A
N77A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 377B
N77B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 377C
N77C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3780 - 3787
N780:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3788 - 378F
N788:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3790 - 3797
N790:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3798 - 379F
N798:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 37A0 - 37A7
N7A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 37A8 - 37AF
N7A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 37B0 - 37B7
N7B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 37B8
N7B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 37B9
N7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 37BA
N7BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 37BB
N7BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 37BC
N7BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3800 - 3807
N800:
add r13,r2
mov.w @r2,r3
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3808 - 380F
N808:
add r14,r2
mov.w @r2,r3
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3810 - 3817
N810:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3818 - 381F
N818:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3820 - 3827
N820:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3828 - 382F
N828:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3830 - 3837
N830:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3838
N838:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3839
N839:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 383A
N83A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 383B
N83B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 383C
N83C:
mov.w @r6+,r3
mov #16,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3840 - 3847
N840:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3848 - 384F
N848:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3850 - 3857
N850:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3858 - 385F
N858:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3860 - 3867
N860:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3868 - 386F
N868:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3870 - 3877
N870:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3878
N878:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3879
N879:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 387A
N87A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 387B
N87B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 387C
N87C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3880 - 3887
N880:
add r13,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3888 - 388F
N888:
add r14,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3890 - 3897
N890:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3898 - 389F
N898:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 38A0 - 38A7
N8A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 38A8 - 38AF
N8A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 38B0 - 38B7
N8B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 38B8
N8B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 38B9
N8B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 38BA
N8BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 38BB
N8BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 38BC
N8BC:
mov.w @r6+,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 38C0 - 38C7
N8C0:
add r13,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 38C8 - 38CF
N8C8:
add r14,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 38D0 - 38D7
N8D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 38D8 - 38DF
N8D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 38E0 - 38E7
N8E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 38E8 - 38EF
N8E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 38F0 - 38F7
N8F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 38F8
N8F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 38F9
N8F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 38FA
N8FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 38FB
N8FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 38FC
N8FC:
mov.w @r6+,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3900 - 3907
N900:
add r13,r2
mov.w @r2,r3
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3908 - 390F
N908:
add r14,r2
mov.w @r2,r3
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3910 - 3917
N910:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3918 - 391F
N918:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3920 - 3927
N920:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3928 - 392F
N928:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3930 - 3937
N930:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3938
N938:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3939
N939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 393A
N93A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 393B
N93B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 393C
N93C:
mov.w @r6+,r3
mov.l @(48,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3940 - 3947
N940:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3948 - 394F
N948:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3950 - 3957
N950:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3958 - 395F
N958:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3960 - 3967
N960:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3968 - 396F
N968:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3970 - 3977
N970:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3978
N978:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3979
N979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 397A
N97A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 397B
N97B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 397C
N97C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3980 - 3987
N980:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3988 - 398F
N988:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3990 - 3997
N990:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3998 - 399F
N998:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 39A0 - 39A7
N9A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 39A8 - 39AF
N9A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 39B0 - 39B7
N9B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 39B8
N9B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 39B9
N9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 39BA
N9BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 39BB
N9BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 39BC
N9BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3A00 - 3A07
NA00:
add r13,r2
mov.w @r2,r3
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3A08 - 3A0F
NA08:
add r14,r2
mov.w @r2,r3
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3A10 - 3A17
NA10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3A18 - 3A1F
NA18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3A20 - 3A27
NA20:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3A28 - 3A2F
NA28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3A30 - 3A37
NA30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3A38
NA38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3A39
NA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3A3A
NA3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3A3B
NA3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3A3C
NA3C:
mov.w @r6+,r3
mov #20,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3A40 - 3A47
NA40:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3A48 - 3A4F
NA48:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3A50 - 3A57
NA50:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3A58 - 3A5F
NA58:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3A60 - 3A67
NA60:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3A68 - 3A6F
NA68:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3A70 - 3A77
NA70:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3A78
NA78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3A79
NA79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 3A7A
NA7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3A7B
NA7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3A7C
NA7C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3A80 - 3A87
NA80:
add r13,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3A88 - 3A8F
NA88:
add r14,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3A90 - 3A97
NA90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3A98 - 3A9F
NA98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3AA0 - 3AA7
NAA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3AA8 - 3AAF
NAA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3AB0 - 3AB7
NAB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3AB8
NAB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3AB9
NAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3ABA
NABA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3ABB
NABB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3ABC
NABC:
mov.w @r6+,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3AC0 - 3AC7
NAC0:
add r13,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3AC8 - 3ACF
NAC8:
add r14,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3AD0 - 3AD7
NAD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3AD8 - 3ADF
NAD8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3AE0 - 3AE7
NAE0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3AE8 - 3AEF
NAE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3AF0 - 3AF7
NAF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3AF8
NAF8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3AF9
NAF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3AFA
NAFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3AFB
NAFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3AFC
NAFC:
mov.w @r6+,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3B00 - 3B07
NB00:
add r13,r2
mov.w @r2,r3
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3B08 - 3B0F
NB08:
add r14,r2
mov.w @r2,r3
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3B10 - 3B17
NB10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3B18 - 3B1F
NB18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3B20 - 3B27
NB20:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3B28 - 3B2F
NB28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3B30 - 3B37
NB30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3B38
NB38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3B39
NB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3B3A
NB3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3B3B
NB3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3B3C
NB3C:
mov.w @r6+,r3
mov.l @(52,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3B40 - 3B47
NB40:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3B48 - 3B4F
NB48:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3B50 - 3B57
NB50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3B58 - 3B5F
NB58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3B60 - 3B67
NB60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3B68 - 3B6F
NB68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3B70 - 3B77
NB70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3B78
NB78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3B79
NB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3B7A
NB7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3B7B
NB7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3B7C
NB7C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3B80 - 3B87
NB80:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3B88 - 3B8F
NB88:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3B90 - 3B97
NB90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3B98 - 3B9F
NB98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3BA0 - 3BA7
NBA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3BA8 - 3BAF
NBA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 3BB0 - 3BB7
NBB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3BB8
NBB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3BB9
NBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 3BBA
NBBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3BBB
NBBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3BBC
NBBC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3C00 - 3C07
NC00:
add r13,r2
mov.w @r2,r3
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3C08 - 3C0F
NC08:
add r14,r2
mov.w @r2,r3
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3C10 - 3C17
NC10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3C18 - 3C1F
NC18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3C20 - 3C27
NC20:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3C28 - 3C2F
NC28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3C30 - 3C37
NC30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3C38
NC38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3C39
NC39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3C3A
NC3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3C3B
NC3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3C3C
NC3C:
mov.w @r6+,r3
mov #24,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3C40 - 3C47
NC40:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3C48 - 3C4F
NC48:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3C50 - 3C57
NC50:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3C58 - 3C5F
NC58:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3C60 - 3C67
NC60:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3C68 - 3C6F
NC68:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3C70 - 3C77
NC70:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3C78
NC78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3C79
NC79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 3C7A
NC7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3C7B
NC7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3C7C
NC7C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3C80 - 3C87
NC80:
add r13,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3C88 - 3C8F
NC88:
add r14,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3C90 - 3C97
NC90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3C98 - 3C9F
NC98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3CA0 - 3CA7
NCA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3CA8 - 3CAF
NCA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3CB0 - 3CB7
NCB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3CB8
NCB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3CB9
NCB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3CBA
NCBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3CBB
NCBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3CBC
NCBC:
mov.w @r6+,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3CC0 - 3CC7
NCC0:
add r13,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3CC8 - 3CCF
NCC8:
add r14,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3CD0 - 3CD7
NCD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3CD8 - 3CDF
NCD8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3CE0 - 3CE7
NCE0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3CE8 - 3CEF
NCE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3CF0 - 3CF7
NCF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3CF8
NCF8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3CF9
NCF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3CFA
NCFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3CFB
NCFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3CFC
NCFC:
mov.w @r6+,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3D00 - 3D07
ND00:
add r13,r2
mov.w @r2,r3
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3D08 - 3D0F
ND08:
add r14,r2
mov.w @r2,r3
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3D10 - 3D17
ND10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3D18 - 3D1F
ND18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3D20 - 3D27
ND20:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3D28 - 3D2F
ND28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3D30 - 3D37
ND30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3D38
ND38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3D39
ND39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3D3A
ND3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3D3B
ND3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3D3C
ND3C:
mov.w @r6+,r3
mov.l @(56,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3D40 - 3D47
ND40:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3D48 - 3D4F
ND48:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3D50 - 3D57
ND50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3D58 - 3D5F
ND58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3D60 - 3D67
ND60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3D68 - 3D6F
ND68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3D70 - 3D77
ND70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3D78
ND78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3D79
ND79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3D7A
ND7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3D7B
ND7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3D7C
ND7C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3D80 - 3D87
ND80:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3D88 - 3D8F
ND88:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3D90 - 3D97
ND90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3D98 - 3D9F
ND98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3DA0 - 3DA7
NDA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3DA8 - 3DAF
NDA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 3DB0 - 3DB7
NDB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3DB8
NDB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3DB9
NDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 3DBA
NDBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3DBB
NDBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3DBC
NDBC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3E00 - 3E07
NE00:
add r13,r2
mov.w @r2,r3
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3E08 - 3E0F
NE08:
add r14,r2
mov.w @r2,r3
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 3E10 - 3E17
NE10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3E18 - 3E1F
NE18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3E20 - 3E27
NE20:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 3E28 - 3E2F
NE28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3E30 - 3E37
NE30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3E38
NE38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3E39
NE39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3E3A
NE3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 3E3B
NE3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 3E3C
NE3C:
mov.w @r6+,r3
mov #28,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3E40 - 3E47
NE40:
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3E48 - 3E4F
NE48:
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 3E50 - 3E57
NE50:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3E58 - 3E5F
NE58:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3E60 - 3E67
NE60:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-10,r7
! Opcodes 3E68 - 3E6F
NE68:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 3E70 - 3E77
NE70:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3E78
NE78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3E79
NE79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 3E7A
NE7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 3E7B
NE7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 3E7C
NE7C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 3E80 - 3E87
NE80:
add r13,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3E88 - 3E8F
NE88:
add r14,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3E90 - 3E97
NE90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3E98 - 3E9F
NE98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3EA0 - 3EA7
NEA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3EA8 - 3EAF
NEA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3EB0 - 3EB7
NEB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3EB8
NEB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3EB9
NEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3EBA
NEBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3EBB
NEBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3EBC
NEBC:
mov.w @r6+,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3EC0 - 3EC7
NEC0:
add r13,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3EC8 - 3ECF
NEC8:
add r14,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3ED0 - 3ED7
NED0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3ED8 - 3EDF
NED8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3EE0 - 3EE7
NEE0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3EE8 - 3EEF
NEE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3EF0 - 3EF7
NEF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3EF8
NEF8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3EF9
NEF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3EFA
NEFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3EFB
NEFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3EFC
NEFC:
mov.w @r6+,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3F00 - 3F07
NF00:
add r13,r2
mov.w @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3F08 - 3F0F
NF08:
add r14,r2
mov.w @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 3F10 - 3F17
NF10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3F18 - 3F1F
NF18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3F20 - 3F27
NF20:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3F28 - 3F2F
NF28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3F30 - 3F37
NF30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3F38
NF38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3F39
NF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3F3A
NF3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 3F3B
NF3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 3F3C
NF3C:
mov.w @r6+,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3F40 - 3F47
NF40:
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3F48 - 3F4F
NF48:
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 3F50 - 3F57
NF50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3F58 - 3F5F
NF58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3F60 - 3F67
NF60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3F68 - 3F6F
NF68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3F70 - 3F77
NF70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3F78
NF78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3F79
NF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3F7A
NF7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 3F7B
NF7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3F7C
NF7C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 3F80 - 3F87
NF80:
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3F88 - 3F8F
NF88:
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 3F90 - 3F97
NF90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3F98 - 3F9F
NF98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 3FA0 - 3FA7
NFA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 3FA8 - 3FAF
NFA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 3FB0 - 3FB7
NFB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3FB8
NFB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3FB9
NFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 3FBA
NFBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 3FBB
NFBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 3FBC
NFBC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 4000 - 4007
O000:
mov r3,r4
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.b r3,@r2
tst r4,r4
movt r4
dt r4
shlr r4
or r4,r3
jmp @r10
add #-4,r7
! Opcodes 4010 - 4017
O010:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-12,r7
! Opcodes 4018 - 401F
O018:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-12,r7
! Opcodes 4020 - 4027
O020:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-14,r7
! Opcodes 4028 - 402F
O028:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-16,r7
! Opcodes 4030 - 4037
O030:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-18,r7
! Opcode 4038
O038:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-16,r7
! Opcode 4039
O039:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-20,r7
! Opcodes 4040 - 4047
O040:
mov r3,r4
add r13,r2
mov.w @r2,r3
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.w r3,@r2
tst r4,r4
movt r4
dt r4
shlr r4
or r4,r3
jmp @r10
add #-4,r7
! Opcodes 4050 - 4057
O050:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-12,r7
! Opcodes 4058 - 405F
O058:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-12,r7
! Opcodes 4060 - 4067
O060:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-14,r7
! Opcodes 4068 - 406F
O068:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-16,r7
! Opcodes 4070 - 4077
O070:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-18,r7
! Opcode 4078
O078:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-16,r7
! Opcode 4079
O079:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-20,r7
! Opcodes 4080 - 4087
O080:
mov r3,r4
add r13,r2
mov.l @r2,r3
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l r3,@r2
tst r4,r4
movt r4
dt r4
shlr r4
or r4,r3
jmp @r10
add #-6,r7
! Opcodes 4090 - 4097
O090:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-20,r7
! Opcodes 4098 - 409F
O098:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-20,r7
! Opcodes 40A0 - 40A7
O0A0:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-22,r7
! Opcodes 40A8 - 40AF
O0A8:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-24,r7
! Opcodes 40B0 - 40B7
O0B0:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-26,r7
! Opcode 40B8
O0B8:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-24,r7
! Opcode 40B9
O0B9:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
cmp/pl r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
tst r2,r2
movt r2
dt r2
shlr r2
or r2,r3
jmp @r10
add #-28,r7
! Opcodes 40C0 - 40C7
O0C0:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov r2,r0
mov.w r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-6,r7
! Opcodes 40D0 - 40D7
O0D0:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 40D8 - 40DF
O0D8:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 40E0 - 40E7
O0E0:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 40E8 - 40EF
O0E8:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 40F0 - 40F7
O0F0:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 40F8
O0F8:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 40F9
O0F9:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
rotl r3
addc r1,r1
shlr2 r0
and #1,r0
xor r0,r1
mov r8,r0
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
shll8 r0
or r0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 4180 - 4187
O180:
mov r2,r0
mov.w @(r0,r13),r3
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn52
mov #0,r8
cmp/hi r3,r1
bt ln52
jmp @r10
add #-10,r7
setn52:
mov #1,r8
ln52:
mov.l r1,@-r15
mov.l g2_except_ptr52,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr52,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr52: .long group_2_exception
bf_addr52: .long basefunction
! Opcodes 4190 - 4197
O190:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn53
mov #0,r8
cmp/hi r3,r1
bt ln53
jmp @r10
add #-14,r7
setn53:
mov #1,r8
ln53:
mov.l r1,@-r15
mov.l g2_except_ptr53,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr53,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr53: .long group_2_exception
bf_addr53: .long basefunction
! Opcodes 4198 - 419F
O198:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn54
mov #0,r8
cmp/hi r3,r1
bt ln54
jmp @r10
add #-14,r7
setn54:
mov #1,r8
ln54:
mov.l r1,@-r15
mov.l g2_except_ptr54,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr54,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr54: .long group_2_exception
bf_addr54: .long basefunction
! Opcodes 41A0 - 41A7
O1A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn55
mov #0,r8
cmp/hi r3,r1
bt ln55
jmp @r10
add #-16,r7
setn55:
mov #1,r8
ln55:
mov.l r1,@-r15
mov.l g2_except_ptr55,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr55,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr55: .long group_2_exception
bf_addr55: .long basefunction
! Opcodes 41A8 - 41AF
O1A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn56
mov #0,r8
cmp/hi r3,r1
bt ln56
jmp @r10
add #-18,r7
setn56:
mov #1,r8
ln56:
mov.l r1,@-r15
mov.l g2_except_ptr56,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr56,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr56: .long group_2_exception
bf_addr56: .long basefunction
! Opcodes 41B0 - 41B7
O1B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn57
mov #0,r8
cmp/hi r3,r1
bt ln57
jmp @r10
add #-20,r7
setn57:
mov #1,r8
ln57:
mov.l r1,@-r15
mov.l g2_except_ptr57,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr57,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr57: .long group_2_exception
bf_addr57: .long basefunction
! Opcode 41B8
O1B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn58
mov #0,r8
cmp/hi r3,r1
bt ln58
jmp @r10
add #-18,r7
setn58:
mov #1,r8
ln58:
mov.l r1,@-r15
mov.l g2_except_ptr58,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr58,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr58: .long group_2_exception
bf_addr58: .long basefunction
! Opcode 41B9
O1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn59
mov #0,r8
cmp/hi r3,r1
bt ln59
jmp @r10
add #-22,r7
setn59:
mov #1,r8
ln59:
mov.l r1,@-r15
mov.l g2_except_ptr59,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr59,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr59: .long group_2_exception
bf_addr59: .long basefunction
! Opcode 41BA
O1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn60
mov #0,r8
cmp/hi r3,r1
bt ln60
jmp @r10
add #-18,r7
setn60:
mov #1,r8
ln60:
mov.l r1,@-r15
mov.l g2_except_ptr60,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr60,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr60: .long group_2_exception
bf_addr60: .long basefunction
! Opcode 41BB
O1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn61
mov #0,r8
cmp/hi r3,r1
bt ln61
jmp @r10
add #-20,r7
setn61:
mov #1,r8
ln61:
mov.l r1,@-r15
mov.l g2_except_ptr61,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr61,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr61: .long group_2_exception
bf_addr61: .long basefunction
! Opcode 41BC
O1BC:
mov.w @r6+,r3
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn62
mov #0,r8
cmp/hi r3,r1
bt ln62
jmp @r10
add #-14,r7
setn62:
mov #1,r8
ln62:
mov.l r1,@-r15
mov.l g2_except_ptr62,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr62,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr62: .long group_2_exception
bf_addr62: .long basefunction
! Opcodes 41D0 - 41D7
O1D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(32,r13)
jmp @r10
add #-4,r7
! Opcodes 41E8 - 41EF
O1E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(32,r13)
jmp @r10
add #-8,r7
! Opcodes 41F0 - 41F7
O1F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(32,r13)
jmp @r10
add #-12,r7
! Opcode 41F8
O1F8:
mov.w @r6+,r4
mov.l r4,@(32,r13)
jmp @r10
add #-8,r7
! Opcode 41F9
O1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(32,r13)
jmp @r10
add #-12,r7
! Opcode 41FA
O1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(32,r13)
jmp @r10
add #-8,r7
! Opcode 41FB
O1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(32,r13)
jmp @r10
add #-12,r7
! Opcodes 4200 - 4207
O200:
mov #0,r3
mov r2,r0
mov.b r3,@(r0,r13)
mov r3,r8
jmp @r10
add #-4,r7
! Opcodes 4210 - 4217
O210:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 4218 - 421F
O218:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 4220 - 4227
O220:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
jmp @r10
add #-14,r7
! Opcodes 4228 - 422F
O228:
mov #0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-16,r7
! Opcodes 4230 - 4237
O230:
mov #0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-18,r7
! Opcode 4238
O238:
mov #0,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-16,r7
! Opcode 4239
O239:
mov #0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-20,r7
! Opcodes 4240 - 4247
O240:
mov #0,r3
mov r2,r0
mov.w r3,@(r0,r13)
mov r3,r8
jmp @r10
add #-4,r7
! Opcodes 4250 - 4257
O250:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 4258 - 425F
O258:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 4260 - 4267
O260:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
jmp @r10
add #-14,r7
! Opcodes 4268 - 426F
O268:
mov #0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-16,r7
! Opcodes 4270 - 4277
O270:
mov #0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-18,r7
! Opcode 4278
O278:
mov #0,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-16,r7
! Opcode 4279
O279:
mov #0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-20,r7
! Opcodes 4280 - 4287
O280:
mov #0,r3
mov r2,r0
mov.l r3,@(r0,r13)
mov r3,r8
jmp @r10
add #-6,r7
! Opcodes 4290 - 4297
O290:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 4298 - 429F
O298:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 42A0 - 42A7
O2A0:
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 42A8 - 42AF
O2A8:
mov #0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 42B0 - 42B7
O2B0:
mov #0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-12,r7
! Opcode 42B8
O2B8:
mov #0,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-12,r7
! Opcode 42B9
O2B9:
mov #0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
jmp @r10
add #-12,r7
! Opcodes 4380 - 4387
O380:
mov r2,r0
mov.w @(r0,r13),r3
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn63
mov #0,r8
cmp/hi r3,r1
bt ln63
jmp @r10
add #-10,r7
setn63:
mov #1,r8
ln63:
mov.l r1,@-r15
mov.l g2_except_ptr63,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr63,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr63: .long group_2_exception
bf_addr63: .long basefunction
! Opcodes 4390 - 4397
O390:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn64
mov #0,r8
cmp/hi r3,r1
bt ln64
jmp @r10
add #-14,r7
setn64:
mov #1,r8
ln64:
mov.l r1,@-r15
mov.l g2_except_ptr64,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr64,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr64: .long group_2_exception
bf_addr64: .long basefunction
! Opcodes 4398 - 439F
O398:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn65
mov #0,r8
cmp/hi r3,r1
bt ln65
jmp @r10
add #-14,r7
setn65:
mov #1,r8
ln65:
mov.l r1,@-r15
mov.l g2_except_ptr65,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr65,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr65: .long group_2_exception
bf_addr65: .long basefunction
! Opcodes 43A0 - 43A7
O3A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn66
mov #0,r8
cmp/hi r3,r1
bt ln66
jmp @r10
add #-16,r7
setn66:
mov #1,r8
ln66:
mov.l r1,@-r15
mov.l g2_except_ptr66,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr66,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr66: .long group_2_exception
bf_addr66: .long basefunction
! Opcodes 43A8 - 43AF
O3A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn67
mov #0,r8
cmp/hi r3,r1
bt ln67
jmp @r10
add #-18,r7
setn67:
mov #1,r8
ln67:
mov.l r1,@-r15
mov.l g2_except_ptr67,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr67,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr67: .long group_2_exception
bf_addr67: .long basefunction
! Opcodes 43B0 - 43B7
O3B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn68
mov #0,r8
cmp/hi r3,r1
bt ln68
jmp @r10
add #-20,r7
setn68:
mov #1,r8
ln68:
mov.l r1,@-r15
mov.l g2_except_ptr68,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr68,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr68: .long group_2_exception
bf_addr68: .long basefunction
! Opcode 43B8
O3B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn69
mov #0,r8
cmp/hi r3,r1
bt ln69
jmp @r10
add #-18,r7
setn69:
mov #1,r8
ln69:
mov.l r1,@-r15
mov.l g2_except_ptr69,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr69,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr69: .long group_2_exception
bf_addr69: .long basefunction
! Opcode 43B9
O3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn70
mov #0,r8
cmp/hi r3,r1
bt ln70
jmp @r10
add #-22,r7
setn70:
mov #1,r8
ln70:
mov.l r1,@-r15
mov.l g2_except_ptr70,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr70,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr70: .long group_2_exception
bf_addr70: .long basefunction
! Opcode 43BA
O3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn71
mov #0,r8
cmp/hi r3,r1
bt ln71
jmp @r10
add #-18,r7
setn71:
mov #1,r8
ln71:
mov.l r1,@-r15
mov.l g2_except_ptr71,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr71,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr71: .long group_2_exception
bf_addr71: .long basefunction
! Opcode 43BB
O3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn72
mov #0,r8
cmp/hi r3,r1
bt ln72
jmp @r10
add #-20,r7
setn72:
mov #1,r8
ln72:
mov.l r1,@-r15
mov.l g2_except_ptr72,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr72,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr72: .long group_2_exception
bf_addr72: .long basefunction
! Opcode 43BC
O3BC:
mov.w @r6+,r3
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn73
mov #0,r8
cmp/hi r3,r1
bt ln73
jmp @r10
add #-14,r7
setn73:
mov #1,r8
ln73:
mov.l r1,@-r15
mov.l g2_except_ptr73,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr73,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr73: .long group_2_exception
bf_addr73: .long basefunction
! Opcodes 43D0 - 43D7
O3D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(36,r13)
jmp @r10
add #-4,r7
! Opcodes 43E8 - 43EF
O3E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(36,r13)
jmp @r10
add #-8,r7
! Opcodes 43F0 - 43F7
O3F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(36,r13)
jmp @r10
add #-12,r7
! Opcode 43F8
O3F8:
mov.w @r6+,r4
mov.l r4,@(36,r13)
jmp @r10
add #-8,r7
! Opcode 43F9
O3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(36,r13)
jmp @r10
add #-12,r7
! Opcode 43FA
O3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(36,r13)
jmp @r10
add #-8,r7
! Opcode 43FB
O3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(36,r13)
jmp @r10
add #-12,r7
! Opcodes 4400 - 4407
O400:
add r13,r2
mov.b @r2,r3
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 4410 - 4417
O410:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 4418 - 441F
O418:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 4420 - 4427
O420:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 4428 - 442F
O428:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 4430 - 4437
O430:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 4438
O438:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 4439
O439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
shll8 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 4440 - 4447
O440:
add r13,r2
mov.w @r2,r3
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 4450 - 4457
O450:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 4458 - 445F
O458:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 4460 - 4467
O460:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 4468 - 446F
O468:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 4470 - 4477
O470:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 4478
O478:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 4479
O479:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 4480 - 4487
O480:
add r13,r2
mov.l @r2,r3
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l r3,@r2
jmp @r10
add #-6,r7
! Opcodes 4490 - 4497
O490:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 4498 - 449F
O498:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 44A0 - 44A7
O4A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 44A8 - 44AF
O4A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 44B0 - 44B7
O4B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 44B8
O4B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 44B9
O4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r0
subv r3,r0
movt r8
mov #0,r0
clrt
subc r3,r0
movt r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 44C0 - 44C7
O4C0:
mov r2,r0
mov.w @(r0,r13),r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-12,r7
! Opcodes 44D0 - 44D7
O4D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-16,r7
! Opcodes 44D8 - 44DF
O4D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-16,r7
! Opcodes 44E0 - 44E7
O4E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-18,r7
! Opcodes 44E8 - 44EF
O4E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-20,r7
! Opcodes 44F0 - 44F7
O4F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-22,r7
! Opcode 44F8
O4F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-20,r7
! Opcode 44F9
O4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-24,r7
! Opcode 44FA
O4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-20,r7
! Opcode 44FB
O4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-22,r7
! Opcode 44FC
O4FC:
mov.w @r6+,r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
jmp @r10
add #-16,r7
! Opcodes 4580 - 4587
O580:
mov r2,r0
mov.w @(r0,r13),r3
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn74
mov #0,r8
cmp/hi r3,r1
bt ln74
jmp @r10
add #-10,r7
setn74:
mov #1,r8
ln74:
mov.l r1,@-r15
mov.l g2_except_ptr74,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr74,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr74: .long group_2_exception
bf_addr74: .long basefunction
! Opcodes 4590 - 4597
O590:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn75
mov #0,r8
cmp/hi r3,r1
bt ln75
jmp @r10
add #-14,r7
setn75:
mov #1,r8
ln75:
mov.l r1,@-r15
mov.l g2_except_ptr75,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr75,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr75: .long group_2_exception
bf_addr75: .long basefunction
! Opcodes 4598 - 459F
O598:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn76
mov #0,r8
cmp/hi r3,r1
bt ln76
jmp @r10
add #-14,r7
setn76:
mov #1,r8
ln76:
mov.l r1,@-r15
mov.l g2_except_ptr76,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr76,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr76: .long group_2_exception
bf_addr76: .long basefunction
! Opcodes 45A0 - 45A7
O5A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn77
mov #0,r8
cmp/hi r3,r1
bt ln77
jmp @r10
add #-16,r7
setn77:
mov #1,r8
ln77:
mov.l r1,@-r15
mov.l g2_except_ptr77,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr77,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr77: .long group_2_exception
bf_addr77: .long basefunction
! Opcodes 45A8 - 45AF
O5A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn78
mov #0,r8
cmp/hi r3,r1
bt ln78
jmp @r10
add #-18,r7
setn78:
mov #1,r8
ln78:
mov.l r1,@-r15
mov.l g2_except_ptr78,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr78,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr78: .long group_2_exception
bf_addr78: .long basefunction
! Opcodes 45B0 - 45B7
O5B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn79
mov #0,r8
cmp/hi r3,r1
bt ln79
jmp @r10
add #-20,r7
setn79:
mov #1,r8
ln79:
mov.l r1,@-r15
mov.l g2_except_ptr79,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr79,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr79: .long group_2_exception
bf_addr79: .long basefunction
! Opcode 45B8
O5B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn80
mov #0,r8
cmp/hi r3,r1
bt ln80
jmp @r10
add #-18,r7
setn80:
mov #1,r8
ln80:
mov.l r1,@-r15
mov.l g2_except_ptr80,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr80,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr80: .long group_2_exception
bf_addr80: .long basefunction
! Opcode 45B9
O5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn81
mov #0,r8
cmp/hi r3,r1
bt ln81
jmp @r10
add #-22,r7
setn81:
mov #1,r8
ln81:
mov.l r1,@-r15
mov.l g2_except_ptr81,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr81,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr81: .long group_2_exception
bf_addr81: .long basefunction
! Opcode 45BA
O5BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn82
mov #0,r8
cmp/hi r3,r1
bt ln82
jmp @r10
add #-18,r7
setn82:
mov #1,r8
ln82:
mov.l r1,@-r15
mov.l g2_except_ptr82,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr82,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr82: .long group_2_exception
bf_addr82: .long basefunction
! Opcode 45BB
O5BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn83
mov #0,r8
cmp/hi r3,r1
bt ln83
jmp @r10
add #-20,r7
setn83:
mov #1,r8
ln83:
mov.l r1,@-r15
mov.l g2_except_ptr83,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr83,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr83: .long group_2_exception
bf_addr83: .long basefunction
! Opcode 45BC
O5BC:
mov.w @r6+,r3
mov #8,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn84
mov #0,r8
cmp/hi r3,r1
bt ln84
jmp @r10
add #-14,r7
setn84:
mov #1,r8
ln84:
mov.l r1,@-r15
mov.l g2_except_ptr84,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr84,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr84: .long group_2_exception
bf_addr84: .long basefunction
! Opcodes 45D0 - 45D7
O5D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(40,r13)
jmp @r10
add #-4,r7
! Opcodes 45E8 - 45EF
O5E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(40,r13)
jmp @r10
add #-8,r7
! Opcodes 45F0 - 45F7
O5F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(40,r13)
jmp @r10
add #-12,r7
! Opcode 45F8
O5F8:
mov.w @r6+,r4
mov.l r4,@(40,r13)
jmp @r10
add #-8,r7
! Opcode 45F9
O5F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(40,r13)
jmp @r10
add #-12,r7
! Opcode 45FA
O5FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(40,r13)
jmp @r10
add #-8,r7
! Opcode 45FB
O5FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(40,r13)
jmp @r10
add #-12,r7
! Opcodes 4600 - 4607
O600:
add r13,r2
mov.b @r2,r3
not r3,r3
mov.b r3,@r2
exts.b r3,r3
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 4610 - 4617
O610:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.b r3,r3
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4618 - 461F
O618:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
exts.b r3,r3
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4620 - 4627
O620:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
exts.b r3,r3
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 4628 - 462F
O628:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.b r3,r3
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 4630 - 4637
O630:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.b r3,r3
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 4638
O638:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.b r3,r3
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 4639
O639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.b r3,r3
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 4640 - 4647
O640:
add r13,r2
mov.w @r2,r3
not r3,r3
mov.w r3,@r2
exts.w r3,r3
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 4650 - 4657
O650:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.w r3,r3
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4658 - 465F
O658:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4660 - 4667
O660:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 4668 - 466F
O668:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.w r3,r3
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 4670 - 4677
O670:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.w r3,r3
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 4678
O678:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.w r3,r3
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 4679
O679:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
exts.w r3,r3
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 4680 - 4687
O680:
add r13,r2
mov.l @r2,r3
not r3,r3
mov.l r3,@r2
mov #0,r8
jmp @r10
add #-6,r7
! Opcodes 4690 - 4697
O690:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 4698 - 469F
O698:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 46A0 - 46A7
O6A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 46A8 - 46AF
O6A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 46B0 - 46B7
O6B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 46B8
O6B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 46B9
O6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
not r3,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 46C0 - 46C7
O6C0:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok85
mov.l priviolation_addr85,r0
jmp @r0
nop
.align 2
priviolation_addr85: .long privilege_violation
pcheck_ok85:
mov r2,r0
mov.w @(r0,r13),r3
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln86
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln86:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr88,r4
jmp @r4
add #-12,r7
.align 2
fdl_cp_addr88: .long fdl_cp
! Opcodes 46D0 - 46D7
O6D0:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok89
mov.l priviolation_addr89,r0
jmp @r0
nop
.align 2
priviolation_addr89: .long privilege_violation
pcheck_ok89:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln90
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln90:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr92,r4
jmp @r4
add #-16,r7
.align 2
fdl_cp_addr92: .long fdl_cp
! Opcodes 46D8 - 46DF
O6D8:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok93
mov.l priviolation_addr93,r0
jmp @r0
nop
.align 2
priviolation_addr93: .long privilege_violation
pcheck_ok93:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln94
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln94:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr96,r4
jmp @r4
add #-16,r7
.align 2
fdl_cp_addr96: .long fdl_cp
! Opcodes 46E0 - 46E7
O6E0:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok97
mov.l priviolation_addr97,r0
jmp @r0
nop
.align 2
priviolation_addr97: .long privilege_violation
pcheck_ok97:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln98
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln98:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr100,r4
jmp @r4
add #-18,r7
.align 2
fdl_cp_addr100: .long fdl_cp
! Opcodes 46E8 - 46EF
O6E8:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok101
mov.l priviolation_addr101,r0
jmp @r0
nop
.align 2
priviolation_addr101: .long privilege_violation
pcheck_ok101:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln102
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln102:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr104,r4
jmp @r4
add #-20,r7
.align 2
fdl_cp_addr104: .long fdl_cp
! Opcodes 46F0 - 46F7
O6F0:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok105
mov.l priviolation_addr105,r0
jmp @r0
nop
.align 2
priviolation_addr105: .long privilege_violation
pcheck_ok105:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln106
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln106:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr108,r4
jmp @r4
add #-22,r7
.align 2
fdl_cp_addr108: .long fdl_cp
! Opcode 46F8
O6F8:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok109
mov.l priviolation_addr109,r0
jmp @r0
nop
.align 2
priviolation_addr109: .long privilege_violation
pcheck_ok109:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln110
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln110:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr112,r4
jmp @r4
add #-20,r7
.align 2
fdl_cp_addr112: .long fdl_cp
! Opcode 46F9
O6F9:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok113
mov.l priviolation_addr113,r0
jmp @r0
nop
.align 2
priviolation_addr113: .long privilege_violation
pcheck_ok113:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln114
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln114:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr116,r4
jmp @r4
add #-24,r7
.align 2
fdl_cp_addr116: .long fdl_cp
! Opcode 46FA
O6FA:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok117
mov.l priviolation_addr117,r0
jmp @r0
nop
.align 2
priviolation_addr117: .long privilege_violation
pcheck_ok117:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln118
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln118:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr120,r4
jmp @r4
add #-20,r7
.align 2
fdl_cp_addr120: .long fdl_cp
! Opcode 46FB
O6FB:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok121
mov.l priviolation_addr121,r0
jmp @r0
nop
.align 2
priviolation_addr121: .long privilege_violation
pcheck_ok121:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln122
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln122:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr124,r4
jmp @r4
add #-22,r7
.align 2
fdl_cp_addr124: .long fdl_cp
! Opcode 46FC
O6FC:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok125
mov.l priviolation_addr125,r0
jmp @r0
nop
.align 2
priviolation_addr125: .long privilege_violation
pcheck_ok125:
mov.w @r6+,r3
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln126
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln126:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l fdl_cp_addr128,r4
jmp @r4
add #-16,r7
.align 2
fdl_cp_addr128: .long fdl_cp
! Opcodes 4780 - 4787
O780:
mov r2,r0
mov.w @(r0,r13),r3
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn129
mov #0,r8
cmp/hi r3,r1
bt ln129
jmp @r10
add #-10,r7
setn129:
mov #1,r8
ln129:
mov.l r1,@-r15
mov.l g2_except_ptr129,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr129,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr129: .long group_2_exception
bf_addr129: .long basefunction
! Opcodes 4790 - 4797
O790:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn130
mov #0,r8
cmp/hi r3,r1
bt ln130
jmp @r10
add #-14,r7
setn130:
mov #1,r8
ln130:
mov.l r1,@-r15
mov.l g2_except_ptr130,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr130,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr130: .long group_2_exception
bf_addr130: .long basefunction
! Opcodes 4798 - 479F
O798:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn131
mov #0,r8
cmp/hi r3,r1
bt ln131
jmp @r10
add #-14,r7
setn131:
mov #1,r8
ln131:
mov.l r1,@-r15
mov.l g2_except_ptr131,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr131,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr131: .long group_2_exception
bf_addr131: .long basefunction
! Opcodes 47A0 - 47A7
O7A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn132
mov #0,r8
cmp/hi r3,r1
bt ln132
jmp @r10
add #-16,r7
setn132:
mov #1,r8
ln132:
mov.l r1,@-r15
mov.l g2_except_ptr132,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr132,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr132: .long group_2_exception
bf_addr132: .long basefunction
! Opcodes 47A8 - 47AF
O7A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn133
mov #0,r8
cmp/hi r3,r1
bt ln133
jmp @r10
add #-18,r7
setn133:
mov #1,r8
ln133:
mov.l r1,@-r15
mov.l g2_except_ptr133,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr133,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr133: .long group_2_exception
bf_addr133: .long basefunction
! Opcodes 47B0 - 47B7
O7B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn134
mov #0,r8
cmp/hi r3,r1
bt ln134
jmp @r10
add #-20,r7
setn134:
mov #1,r8
ln134:
mov.l r1,@-r15
mov.l g2_except_ptr134,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr134,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr134: .long group_2_exception
bf_addr134: .long basefunction
! Opcode 47B8
O7B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn135
mov #0,r8
cmp/hi r3,r1
bt ln135
jmp @r10
add #-18,r7
setn135:
mov #1,r8
ln135:
mov.l r1,@-r15
mov.l g2_except_ptr135,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr135,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr135: .long group_2_exception
bf_addr135: .long basefunction
! Opcode 47B9
O7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn136
mov #0,r8
cmp/hi r3,r1
bt ln136
jmp @r10
add #-22,r7
setn136:
mov #1,r8
ln136:
mov.l r1,@-r15
mov.l g2_except_ptr136,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr136,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr136: .long group_2_exception
bf_addr136: .long basefunction
! Opcode 47BA
O7BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn137
mov #0,r8
cmp/hi r3,r1
bt ln137
jmp @r10
add #-18,r7
setn137:
mov #1,r8
ln137:
mov.l r1,@-r15
mov.l g2_except_ptr137,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr137,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr137: .long group_2_exception
bf_addr137: .long basefunction
! Opcode 47BB
O7BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn138
mov #0,r8
cmp/hi r3,r1
bt ln138
jmp @r10
add #-20,r7
setn138:
mov #1,r8
ln138:
mov.l r1,@-r15
mov.l g2_except_ptr138,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr138,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr138: .long group_2_exception
bf_addr138: .long basefunction
! Opcode 47BC
O7BC:
mov.w @r6+,r3
mov #12,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn139
mov #0,r8
cmp/hi r3,r1
bt ln139
jmp @r10
add #-14,r7
setn139:
mov #1,r8
ln139:
mov.l r1,@-r15
mov.l g2_except_ptr139,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr139,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr139: .long group_2_exception
bf_addr139: .long basefunction
! Opcodes 47D0 - 47D7
O7D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(44,r13)
jmp @r10
add #-4,r7
! Opcodes 47E8 - 47EF
O7E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(44,r13)
jmp @r10
add #-8,r7
! Opcodes 47F0 - 47F7
O7F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(44,r13)
jmp @r10
add #-12,r7
! Opcode 47F8
O7F8:
mov.w @r6+,r4
mov.l r4,@(44,r13)
jmp @r10
add #-8,r7
! Opcode 47F9
O7F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(44,r13)
jmp @r10
add #-12,r7
! Opcode 47FA
O7FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(44,r13)
jmp @r10
add #-8,r7
! Opcode 47FB
O7FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(44,r13)
jmp @r10
add #-12,r7
! Opcodes 4800 - 4807
O800:
mov.l r3,@-r15
add r13,r2
mov.b @r2,r3
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd141
add #-6,r8
.nonibadd141:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop141
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop141:
exts.b r3,r3
mov r9,r8
mov.b r3,@r2
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-6,r7
! Opcodes 4810 - 4817
O810:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd143
add #-6,r8
.nonibadd143:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop143
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop143:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-12,r7
! Opcodes 4818 - 481F
O818:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd145
add #-6,r8
.nonibadd145:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop145
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop145:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-12,r7
! Opcodes 4820 - 4827
O820:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd147
add #-6,r8
.nonibadd147:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop147
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop147:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-14,r7
! Opcodes 4828 - 482F
O828:
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd149
add #-6,r8
.nonibadd149:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop149
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop149:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-16,r7
! Opcodes 4830 - 4837
O830:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd151
add #-6,r8
.nonibadd151:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop151
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop151:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-18,r7
! Opcode 4838
O838:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd153
add #-6,r8
.nonibadd153:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop153
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop153:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-16,r7
! Opcode 4839
O839:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov #0,r3
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd155
add #-6,r8
.nonibadd155:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop155
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop155:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-20,r7
! Opcodes 4840 - 4847
O840:
add r13,r2
mov.l @r2,r3
swap.w r3,r3
mov.l r3,@r2
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 4850 - 4857
O850:
mov r2,r0
mov.l @(r0,r14),r4
mov r3,r2
mov r4,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-12,r7
! Opcodes 4868 - 486F
O868:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov r3,r2
mov r4,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-16,r7
! Opcodes 4870 - 4877
O870:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov r3,r2
mov r4,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-20,r7
! Opcode 4878
O878:
mov.w @r6+,r4
mov r3,r2
mov r4,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-16,r7
! Opcode 4879
O879:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov r3,r2
mov r4,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-20,r7
! Opcode 487A
O87A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov r3,r2
mov r4,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-16,r7
! Opcode 487B
O87B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov r3,r2
mov r4,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-20,r7
! Opcodes 4880 - 4887
O880:
add r13,r2
mov.b @r2,r3
mov.w r3,@r2
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 4890 - 4897
O890:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov #0,r2
ln156:
shlr r10
bf ln157
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
add #2,r4
ln157:
add #4,r2
mov #64,r0
tst r0,r2
bt ln156
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 48A0 - 48A7
O8A0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov.l r2,@-r15
mov #60,r2
ln158:
shlr r10
bf ln159
mov r13,r0
add #-2,r4
mov.l @(r0,r2),r3
mov.l @(wdecw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
ln159:
add #-4,r2
cmp/pz r2
bt ln158
mov.l @r15+,r2
mov.l @r15+,r10
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 48A8 - 48AF
O8A8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov #0,r2
ln160:
shlr r10
bf ln161
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
add #2,r4
ln161:
add #4,r2
mov #64,r0
tst r0,r2
bt ln160
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 48B0 - 48B7
O8B0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov #0,r2
ln162:
shlr r10
bf ln163
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
add #2,r4
ln163:
add #4,r2
mov #64,r0
tst r0,r2
bt ln162
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 48B8
O8B8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov #0,r2
ln164:
shlr r10
bf ln165
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
add #2,r4
ln165:
add #4,r2
mov #64,r0
tst r0,r2
bt ln164
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 48B9
O8B9:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov #0,r2
ln166:
shlr r10
bf ln167
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
add #2,r4
ln167:
add #4,r2
mov #64,r0
tst r0,r2
bt ln166
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 48C0 - 48C7
O8C0:
add r13,r2
mov.w @r2,r3
mov.l r3,@r2
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 48D0 - 48D7
O8D0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov #0,r2
ln168:
shlr r10
bf ln169
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
add #4,r4
ln169:
add #4,r2
mov #64,r0
tst r0,r2
bt ln168
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 48E0 - 48E7
O8E0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov.l r2,@-r15
mov #60,r2
ln170:
shlr r10
bf ln171
mov r13,r0
add #-4,r4
mov.l @(r0,r2),r3
mov.l @(wdecl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
ln171:
add #-4,r2
cmp/pz r2
bt ln170
mov.l @r15+,r2
mov.l @r15+,r10
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-8,r7
! Opcodes 48E8 - 48EF
O8E8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov #0,r2
ln172:
shlr r10
bf ln173
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
add #4,r4
ln173:
add #4,r2
mov #64,r0
tst r0,r2
bt ln172
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 48F0 - 48F7
O8F0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov #0,r2
ln174:
shlr r10
bf ln175
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
add #4,r4
ln175:
add #4,r2
mov #64,r0
tst r0,r2
bt ln174
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcode 48F8
O8F8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov #0,r2
ln176:
shlr r10
bf ln177
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
add #4,r4
ln177:
add #4,r2
mov #64,r0
tst r0,r2
bt ln176
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcode 48F9
O8F9:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov #0,r2
ln178:
shlr r10
bf ln179
mov r13,r0
mov.l @(r0,r2),r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
add #4,r4
ln179:
add #4,r2
mov #64,r0
tst r0,r2
bt ln178
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 4980 - 4987
O980:
mov r2,r0
mov.w @(r0,r13),r3
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn180
mov #0,r8
cmp/hi r3,r1
bt ln180
jmp @r10
add #-10,r7
setn180:
mov #1,r8
ln180:
mov.l r1,@-r15
mov.l g2_except_ptr180,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr180,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr180: .long group_2_exception
bf_addr180: .long basefunction
! Opcodes 4990 - 4997
O990:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn181
mov #0,r8
cmp/hi r3,r1
bt ln181
jmp @r10
add #-14,r7
setn181:
mov #1,r8
ln181:
mov.l r1,@-r15
mov.l g2_except_ptr181,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr181,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr181: .long group_2_exception
bf_addr181: .long basefunction
! Opcodes 4998 - 499F
O998:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn182
mov #0,r8
cmp/hi r3,r1
bt ln182
jmp @r10
add #-14,r7
setn182:
mov #1,r8
ln182:
mov.l r1,@-r15
mov.l g2_except_ptr182,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr182,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr182: .long group_2_exception
bf_addr182: .long basefunction
! Opcodes 49A0 - 49A7
O9A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn183
mov #0,r8
cmp/hi r3,r1
bt ln183
jmp @r10
add #-16,r7
setn183:
mov #1,r8
ln183:
mov.l r1,@-r15
mov.l g2_except_ptr183,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr183,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr183: .long group_2_exception
bf_addr183: .long basefunction
! Opcodes 49A8 - 49AF
O9A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn184
mov #0,r8
cmp/hi r3,r1
bt ln184
jmp @r10
add #-18,r7
setn184:
mov #1,r8
ln184:
mov.l r1,@-r15
mov.l g2_except_ptr184,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr184,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr184: .long group_2_exception
bf_addr184: .long basefunction
! Opcodes 49B0 - 49B7
O9B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn185
mov #0,r8
cmp/hi r3,r1
bt ln185
jmp @r10
add #-20,r7
setn185:
mov #1,r8
ln185:
mov.l r1,@-r15
mov.l g2_except_ptr185,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr185,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr185: .long group_2_exception
bf_addr185: .long basefunction
! Opcode 49B8
O9B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn186
mov #0,r8
cmp/hi r3,r1
bt ln186
jmp @r10
add #-18,r7
setn186:
mov #1,r8
ln186:
mov.l r1,@-r15
mov.l g2_except_ptr186,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr186,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr186: .long group_2_exception
bf_addr186: .long basefunction
! Opcode 49B9
O9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn187
mov #0,r8
cmp/hi r3,r1
bt ln187
jmp @r10
add #-22,r7
setn187:
mov #1,r8
ln187:
mov.l r1,@-r15
mov.l g2_except_ptr187,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr187,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr187: .long group_2_exception
bf_addr187: .long basefunction
! Opcode 49BA
O9BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn188
mov #0,r8
cmp/hi r3,r1
bt ln188
jmp @r10
add #-18,r7
setn188:
mov #1,r8
ln188:
mov.l r1,@-r15
mov.l g2_except_ptr188,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr188,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr188: .long group_2_exception
bf_addr188: .long basefunction
! Opcode 49BB
O9BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn189
mov #0,r8
cmp/hi r3,r1
bt ln189
jmp @r10
add #-20,r7
setn189:
mov #1,r8
ln189:
mov.l r1,@-r15
mov.l g2_except_ptr189,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr189,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr189: .long group_2_exception
bf_addr189: .long basefunction
! Opcode 49BC
O9BC:
mov.w @r6+,r3
mov #16,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn190
mov #0,r8
cmp/hi r3,r1
bt ln190
jmp @r10
add #-14,r7
setn190:
mov #1,r8
ln190:
mov.l r1,@-r15
mov.l g2_except_ptr190,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr190,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr190: .long group_2_exception
bf_addr190: .long basefunction
! Opcodes 49D0 - 49D7
O9D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(48,r13)
jmp @r10
add #-4,r7
! Opcodes 49E8 - 49EF
O9E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(48,r13)
jmp @r10
add #-8,r7
! Opcodes 49F0 - 49F7
O9F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(48,r13)
jmp @r10
add #-12,r7
! Opcode 49F8
O9F8:
mov.w @r6+,r4
mov.l r4,@(48,r13)
jmp @r10
add #-8,r7
! Opcode 49F9
O9F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(48,r13)
jmp @r10
add #-12,r7
! Opcode 49FA
O9FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(48,r13)
jmp @r10
add #-8,r7
! Opcode 49FB
O9FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(48,r13)
jmp @r10
add #-12,r7
! Opcodes 4A00 - 4A07
OA00:
mov r2,r0
mov.b @(r0,r13),r3
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 4A10 - 4A17
OA10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 4A18 - 4A1F
OA18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 4A20 - 4A27
OA20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 4A28 - 4A2F
OA28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4A30 - 4A37
OA30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 4A38
OA38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 4A39
OA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 4A40 - 4A47
OA40:
mov r2,r0
mov.w @(r0,r13),r3
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 4A50 - 4A57
OA50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 4A58 - 4A5F
OA58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 4A60 - 4A67
OA60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 4A68 - 4A6F
OA68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4A70 - 4A77
OA70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 4A78
OA78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 4A79
OA79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 4A80 - 4A87
OA80:
mov r2,r0
mov.l @(r0,r13),r3
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 4A90 - 4A97
OA90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4A98 - 4A9F
OA98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 4AA0 - 4AA7
OAA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 4AA8 - 4AAF
OAA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 4AB0 - 4AB7
OAB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 4AB8
OAB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 4AB9
OAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 4AC0 - 4AC7
OAC0:
mov r2,r0
mov.b @(r0,r13),r3
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 4AD0 - 4AD7
OAD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcodes 4AD8 - 4ADF
OAD8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcodes 4AE0 - 4AE7
OAE0:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 4AE8 - 4AEF
OAE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-22,r7
! Opcodes 4AF0 - 4AF7
OAF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-24,r7
! Opcode 4AF8
OAF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-22,r7
! Opcode 4AF9
OAF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
mov.l r3,@-r15
mov #0,r8
mov r1,r0
or #0x80,r0
mov r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-26,r7
! Opcode 4AFA
OAFA:
r_illegal:
mov.l r3,@-r15
mov.l g1_except_addr191,r0
add #-2,r6
jsr @r0
mov #0x10,r4
mov.l bf_addr191,r0
jsr @r0
nop
add r5,r6
mov.l @r15+,r3
jmp @r10
add #-34,r7
.align 2
g1_except_addr191: .long group_1_exception
bf_addr191: .long basefunction
! Opcode 4AFB
OAFB:
mov.l r3,@-r15
mov.l g1_except_addr192,r0
add #-2,r6
jsr @r0
mov #0x10,r4
mov.l bf_addr192,r0
jsr @r0
nop
add r5,r6
mov.l @r15+,r3
jmp @r10
add #-34,r7
.align 2
g1_except_addr192: .long group_1_exception
bf_addr192: .long basefunction
! Opcode 4AFC
OAFC:
mov.l r3,@-r15
mov.l g1_except_addr193,r0
add #-2,r6
jsr @r0
mov #0x10,r4
mov.l bf_addr193,r0
jsr @r0
nop
add r5,r6
mov.l @r15+,r3
jmp @r10
add #-34,r7
.align 2
g1_except_addr193: .long group_1_exception
bf_addr193: .long basefunction
! Opcodes 4B80 - 4B87
OB80:
mov r2,r0
mov.w @(r0,r13),r3
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn194
mov #0,r8
cmp/hi r3,r1
bt ln194
jmp @r10
add #-10,r7
setn194:
mov #1,r8
ln194:
mov.l r1,@-r15
mov.l g2_except_ptr194,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr194,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr194: .long group_2_exception
bf_addr194: .long basefunction
! Opcodes 4B90 - 4B97
OB90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn195
mov #0,r8
cmp/hi r3,r1
bt ln195
jmp @r10
add #-14,r7
setn195:
mov #1,r8
ln195:
mov.l r1,@-r15
mov.l g2_except_ptr195,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr195,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr195: .long group_2_exception
bf_addr195: .long basefunction
! Opcodes 4B98 - 4B9F
OB98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn196
mov #0,r8
cmp/hi r3,r1
bt ln196
jmp @r10
add #-14,r7
setn196:
mov #1,r8
ln196:
mov.l r1,@-r15
mov.l g2_except_ptr196,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr196,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr196: .long group_2_exception
bf_addr196: .long basefunction
! Opcodes 4BA0 - 4BA7
OBA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn197
mov #0,r8
cmp/hi r3,r1
bt ln197
jmp @r10
add #-16,r7
setn197:
mov #1,r8
ln197:
mov.l r1,@-r15
mov.l g2_except_ptr197,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr197,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr197: .long group_2_exception
bf_addr197: .long basefunction
! Opcodes 4BA8 - 4BAF
OBA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn198
mov #0,r8
cmp/hi r3,r1
bt ln198
jmp @r10
add #-18,r7
setn198:
mov #1,r8
ln198:
mov.l r1,@-r15
mov.l g2_except_ptr198,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr198,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr198: .long group_2_exception
bf_addr198: .long basefunction
! Opcodes 4BB0 - 4BB7
OBB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn199
mov #0,r8
cmp/hi r3,r1
bt ln199
jmp @r10
add #-20,r7
setn199:
mov #1,r8
ln199:
mov.l r1,@-r15
mov.l g2_except_ptr199,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr199,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr199: .long group_2_exception
bf_addr199: .long basefunction
! Opcode 4BB8
OBB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn200
mov #0,r8
cmp/hi r3,r1
bt ln200
jmp @r10
add #-18,r7
setn200:
mov #1,r8
ln200:
mov.l r1,@-r15
mov.l g2_except_ptr200,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr200,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr200: .long group_2_exception
bf_addr200: .long basefunction
! Opcode 4BB9
OBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn201
mov #0,r8
cmp/hi r3,r1
bt ln201
jmp @r10
add #-22,r7
setn201:
mov #1,r8
ln201:
mov.l r1,@-r15
mov.l g2_except_ptr201,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr201,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr201: .long group_2_exception
bf_addr201: .long basefunction
! Opcode 4BBA
OBBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn202
mov #0,r8
cmp/hi r3,r1
bt ln202
jmp @r10
add #-18,r7
setn202:
mov #1,r8
ln202:
mov.l r1,@-r15
mov.l g2_except_ptr202,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr202,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr202: .long group_2_exception
bf_addr202: .long basefunction
! Opcode 4BBB
OBBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn203
mov #0,r8
cmp/hi r3,r1
bt ln203
jmp @r10
add #-20,r7
setn203:
mov #1,r8
ln203:
mov.l r1,@-r15
mov.l g2_except_ptr203,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr203,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr203: .long group_2_exception
bf_addr203: .long basefunction
! Opcode 4BBC
OBBC:
mov.w @r6+,r3
mov #20,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn204
mov #0,r8
cmp/hi r3,r1
bt ln204
jmp @r10
add #-14,r7
setn204:
mov #1,r8
ln204:
mov.l r1,@-r15
mov.l g2_except_ptr204,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr204,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr204: .long group_2_exception
bf_addr204: .long basefunction
! Opcodes 4BD0 - 4BD7
OBD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(52,r13)
jmp @r10
add #-4,r7
! Opcodes 4BE8 - 4BEF
OBE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(52,r13)
jmp @r10
add #-8,r7
! Opcodes 4BF0 - 4BF7
OBF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(52,r13)
jmp @r10
add #-12,r7
! Opcode 4BF8
OBF8:
mov.w @r6+,r4
mov.l r4,@(52,r13)
jmp @r10
add #-8,r7
! Opcode 4BF9
OBF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(52,r13)
jmp @r10
add #-12,r7
! Opcode 4BFA
OBFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(52,r13)
jmp @r10
add #-8,r7
! Opcode 4BFB
OBFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(52,r13)
jmp @r10
add #-12,r7
! Opcodes 4C90 - 4C97
OC90:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov #0,r2
ln205:
shlr r10
bf ln206
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #2,r4
ln206:
add #4,r2
mov #64,r0
tst r0,r2
bt ln205
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 4C98 - 4C9F
OC98:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov.l r2,@-r15
mov #0,r2
ln207:
shlr r10
bf ln208
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
add #2,r4
mov.l r3,@(r0,r2)
ln208:
add #4,r2
mov #64,r0
tst r0,r2
bt ln207
mov.l @r15+,r2
mov.l @r15+,r10
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 4CA8 - 4CAF
OCA8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov #0,r2
ln209:
shlr r10
bf ln210
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #2,r4
ln210:
add #4,r2
mov #64,r0
tst r0,r2
bt ln209
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 4CB0 - 4CB7
OCB0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov #0,r2
ln211:
shlr r10
bf ln212
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #2,r4
ln212:
add #4,r2
mov #64,r0
tst r0,r2
bt ln211
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 4CB8
OCB8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov #0,r2
ln213:
shlr r10
bf ln214
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #2,r4
ln214:
add #4,r2
mov #64,r0
tst r0,r2
bt ln213
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 4CB9
OCB9:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov #0,r2
ln215:
shlr r10
bf ln216
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #2,r4
ln216:
add #4,r2
mov #64,r0
tst r0,r2
bt ln215
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 4CBA
OCBA:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov #0,r2
ln217:
shlr r10
bf ln218
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #2,r4
ln218:
add #4,r2
mov #64,r0
tst r0,r2
bt ln217
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 4CBB
OCBB:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov #0,r2
ln219:
shlr r10
bf ln220
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
add #-4,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #2,r4
ln220:
add #4,r2
mov #64,r0
tst r0,r2
bt ln219
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcodes 4CD0 - 4CD7
OCD0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov #0,r2
ln221:
shlr r10
bf ln222
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #4,r4
ln222:
add #4,r2
mov #64,r0
tst r0,r2
bt ln221
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 4CD8 - 4CDF
OCD8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r2,r0
mov.l @(r0,r14),r4
mov.l r2,@-r15
mov #0,r2
ln223:
shlr r10
bf ln224
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
add #4,r4
mov.l r3,@(r0,r2)
ln224:
add #4,r2
mov #64,r0
tst r0,r2
bt ln223
mov.l @r15+,r2
mov.l @r15+,r10
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 4CE8 - 4CEF
OCE8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov #0,r2
ln225:
shlr r10
bf ln226
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #4,r4
ln226:
add #4,r2
mov #64,r0
tst r0,r2
bt ln225
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 4CF0 - 4CF7
OCF0:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov #0,r2
ln227:
shlr r10
bf ln228
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #4,r4
ln228:
add #4,r2
mov #64,r0
tst r0,r2
bt ln227
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 4CF8
OCF8:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r4
mov #0,r2
ln229:
shlr r10
bf ln230
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #4,r4
ln230:
add #4,r2
mov #64,r0
tst r0,r2
bt ln229
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 4CF9
OCF9:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov #0,r2
ln231:
shlr r10
bf ln232
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #4,r4
ln232:
add #4,r2
mov #64,r0
tst r0,r2
bt ln231
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 4CFA
OCFA:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov #0,r2
ln233:
shlr r10
bf ln234
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #4,r4
ln234:
add #4,r2
mov #64,r0
tst r0,r2
bt ln233
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 4CFB
OCFB:
mov.l r3,@-r15
mov.l r10,@-r15
mov.w @r6+,r10
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov #0,r2
ln235:
shlr r10
bf ln236
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #-8,r7
mov r13,r0
mov.l r3,@(r0,r2)
add #4,r4
ln236:
add #4,r2
mov #64,r0
tst r0,r2
bt ln235
mov.l @r15+,r10
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcodes 4D80 - 4D87
OD80:
mov r2,r0
mov.w @(r0,r13),r3
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn237
mov #0,r8
cmp/hi r3,r1
bt ln237
jmp @r10
add #-10,r7
setn237:
mov #1,r8
ln237:
mov.l r1,@-r15
mov.l g2_except_ptr237,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr237,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr237: .long group_2_exception
bf_addr237: .long basefunction
! Opcodes 4D90 - 4D97
OD90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn238
mov #0,r8
cmp/hi r3,r1
bt ln238
jmp @r10
add #-14,r7
setn238:
mov #1,r8
ln238:
mov.l r1,@-r15
mov.l g2_except_ptr238,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr238,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr238: .long group_2_exception
bf_addr238: .long basefunction
! Opcodes 4D98 - 4D9F
OD98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn239
mov #0,r8
cmp/hi r3,r1
bt ln239
jmp @r10
add #-14,r7
setn239:
mov #1,r8
ln239:
mov.l r1,@-r15
mov.l g2_except_ptr239,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr239,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr239: .long group_2_exception
bf_addr239: .long basefunction
! Opcodes 4DA0 - 4DA7
ODA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn240
mov #0,r8
cmp/hi r3,r1
bt ln240
jmp @r10
add #-16,r7
setn240:
mov #1,r8
ln240:
mov.l r1,@-r15
mov.l g2_except_ptr240,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr240,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr240: .long group_2_exception
bf_addr240: .long basefunction
! Opcodes 4DA8 - 4DAF
ODA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn241
mov #0,r8
cmp/hi r3,r1
bt ln241
jmp @r10
add #-18,r7
setn241:
mov #1,r8
ln241:
mov.l r1,@-r15
mov.l g2_except_ptr241,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr241,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr241: .long group_2_exception
bf_addr241: .long basefunction
! Opcodes 4DB0 - 4DB7
ODB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn242
mov #0,r8
cmp/hi r3,r1
bt ln242
jmp @r10
add #-20,r7
setn242:
mov #1,r8
ln242:
mov.l r1,@-r15
mov.l g2_except_ptr242,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr242,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr242: .long group_2_exception
bf_addr242: .long basefunction
! Opcode 4DB8
ODB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn243
mov #0,r8
cmp/hi r3,r1
bt ln243
jmp @r10
add #-18,r7
setn243:
mov #1,r8
ln243:
mov.l r1,@-r15
mov.l g2_except_ptr243,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr243,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr243: .long group_2_exception
bf_addr243: .long basefunction
! Opcode 4DB9
ODB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn244
mov #0,r8
cmp/hi r3,r1
bt ln244
jmp @r10
add #-22,r7
setn244:
mov #1,r8
ln244:
mov.l r1,@-r15
mov.l g2_except_ptr244,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr244,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr244: .long group_2_exception
bf_addr244: .long basefunction
! Opcode 4DBA
ODBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn245
mov #0,r8
cmp/hi r3,r1
bt ln245
jmp @r10
add #-18,r7
setn245:
mov #1,r8
ln245:
mov.l r1,@-r15
mov.l g2_except_ptr245,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr245,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr245: .long group_2_exception
bf_addr245: .long basefunction
! Opcode 4DBB
ODBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn246
mov #0,r8
cmp/hi r3,r1
bt ln246
jmp @r10
add #-20,r7
setn246:
mov #1,r8
ln246:
mov.l r1,@-r15
mov.l g2_except_ptr246,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr246,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr246: .long group_2_exception
bf_addr246: .long basefunction
! Opcode 4DBC
ODBC:
mov.w @r6+,r3
mov #24,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn247
mov #0,r8
cmp/hi r3,r1
bt ln247
jmp @r10
add #-14,r7
setn247:
mov #1,r8
ln247:
mov.l r1,@-r15
mov.l g2_except_ptr247,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr247,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr247: .long group_2_exception
bf_addr247: .long basefunction
! Opcodes 4DD0 - 4DD7
ODD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(56,r13)
jmp @r10
add #-4,r7
! Opcodes 4DE8 - 4DEF
ODE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(56,r13)
jmp @r10
add #-8,r7
! Opcodes 4DF0 - 4DF7
ODF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(56,r13)
jmp @r10
add #-12,r7
! Opcode 4DF8
ODF8:
mov.w @r6+,r4
mov.l r4,@(56,r13)
jmp @r10
add #-8,r7
! Opcode 4DF9
ODF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(56,r13)
jmp @r10
add #-12,r7
! Opcode 4DFA
ODFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(56,r13)
jmp @r10
add #-8,r7
! Opcode 4DFB
ODFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(56,r13)
jmp @r10
add #-12,r7
! Opcodes 4E40 - 4E4F
OE40:
mov #0x80,r4
and #0x3C,r0
mov.l g2_exception_addr,r1
extu.b r4,r4
jsr @r1
add r0,r4
mov.l bf_addr248,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_exception_addr: .long group_2_exception
bf_addr248: .long basefunction
! Opcodes 4E50 - 4E57
OE50:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov.l @(60,r13),r3
mov r2,r0
mov.l r3,@(r0,r14)
mov.w @r6+,r4
add r4,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 4E58 - 4E5F
OE58:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r3
mov.l r3,@(60,r13)
mov.l @(60,r13),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov r2,r0
mov.l r3,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 4E60 - 4E67
OE60:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok249
mov.l priviolation_addr249,r0
jmp @r0
nop
.align 2
priviolation_addr249: .long privilege_violation
pcheck_ok249:
mov r2,r0
mov.l @(r0,r14),r1
mov.l r1,@(32,r14)
jmp @r10
add #-4,r7
! Opcodes 4E68 - 4E6F
OE68:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok250
mov.l priviolation_addr250,r0
jmp @r0
nop
.align 2
priviolation_addr250: .long privilege_violation
pcheck_ok250:
mov.l @(32,r14),r1
mov r2,r0
mov.l r1,@(r0,r14)
jmp @r10
add #-4,r7
! Opcode 4E70
OE70:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok252
mov.l priviolation_addr252,r0
jmp @r0
nop
.align 2
priviolation_addr252: .long privilege_violation
pcheck_ok252:
mov.l resethandler_addr251,r0
mov.l @r0,r1
tst r1,r1
bt r_done
mov.l r3,@-r15
mov.l __io_cycle_counter_addr251,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-__io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-__io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
lds.l	@r15+,pr
mov.l __io_cycle_counter_addr251,r0
mov.l @r0,r7
mov.l @(io_fetchbase-__io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-__io_cycle_counter,r0),r6
mov.l @r15+,r3
r_done:
add #-128,r7
jmp @r10
add #-4,r7
.align 2
__io_cycle_counter_addr251: .long __io_cycle_counter
resethandler_addr251: .long resethandler
! Opcode 4E71
OE71:
jmp @r10
add #-4,r7
! Opcode 4E72
OE72:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok253
mov.l priviolation_addr253,r0
jmp @r0
nop
.align 2
priviolation_addr253: .long privilege_violation
pcheck_ok253:
mov.w @r6+,r3
mov.l execinfo_addr253,r2
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln254
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln254:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.w @r2,r0
mov #0x80,r1
extu.b r1,r1
or r1,r0
mov.w r0,@r2
mov.l @(execexit_addr-areg,r14),r0
add #2,r6
jmp @r0
add #-4,r7
.align 2
execinfo_addr253: .long execinfo
! Opcode 4E73
OE73:
mov.l @(sreg-areg,r14),r0
shlr8 r0
tst #0x20,r0
bf pcheck_ok257
mov.l priviolation_addr257,r0
jmp @r0
nop
.align 2
priviolation_addr257: .long privilege_violation
pcheck_ok257:
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
mov.l @(60,r13),r4
add #2,r4
mov.l @(sreg - areg,r14),r0
mov #0x20,r1
shll8 r1
xor r3,r0
tst r1,r0
bt ln258
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln258:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov #(sreg-areg),r1
add r14,r1
add #1,r1
mov.b r0,@r1
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov.l @(sreg-areg,r14),r0
shlr8 r0
extu.b r0,r0
tst #0x20,r0
movt r2
mov.l r3,@-r15
shll2 r2
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
add #28,r2
add r14,r2
mov.l @r2,r4
add #6,r4
mov.l r4,@r2
mov.l execinfo_addr256,r1
mov.w @r1,r0
and #0xE7,r0
mov.w r0,@r1
mov r3,r6
mov.l bf_addr256,r0
jsr @r0
nop
add r5,r6
mov.l @r15+,r3
mov.l fdl_cp_addr260,r4
jmp @r4
add #-20,r7
.align 2
fdl_cp_addr260: .long fdl_cp
.align 2
bf_addr256: .long basefunction
execinfo_addr256: .long execinfo
! Opcode 4E75
OE75:
mov r3,r2
mov.l @(60,r13),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov r3,r6
mov.l bf_addr261,r0
jsr @r0
nop
add r5,r6
mov r2,r3
jmp @r10
add #-16,r7
.align 2
bf_addr261: .long basefunction
! Opcode 4E76
OE76:
mov r8,r0
tst #0x2,r0
bf ln262
jmp @r10
add #-4,r7
ln262:
mov.l g2_exception_ptr,r0
jsr @r0
mov #0x1C,r4
mov.l bf_addr262,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_exception_ptr: .long group_2_exception
bf_addr262: .long basefunction
! Opcode 4E77
OE77:
mov.l @(60,r13),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
and r0,r9
and r0,r3
movt r0
shll2 r0
or r0,r8
mov r3,r2
mov.l @(60,r13),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
mov r3,r6
mov.l bf_addr263,r0
jsr @r0
nop
add r5,r6
mov r2,r3
jmp @r10
add #-20,r7
.align 2
bf_addr263: .long basefunction
! Opcodes 4E90 - 4E97
OE90:
mov r2,r0
mov.l @(r0,r14),r4
mov r3,r2
mov r6,r3
sub r5,r3
mov r4,r6
mov.l bf_addr264,r0
jsr @r0
nop
add r5,r6
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-16,r7
.align 2
bf_addr264: .long basefunction
! Opcodes 4EA8 - 4EAF
OEA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov r3,r2
mov r6,r3
sub r5,r3
mov r4,r6
mov.l bf_addr265,r0
jsr @r0
nop
add r5,r6
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-18,r7
.align 2
bf_addr265: .long basefunction
! Opcodes 4EB0 - 4EB7
OEB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov r3,r2
mov r6,r3
sub r5,r3
mov r4,r6
mov.l bf_addr266,r0
jsr @r0
nop
add r5,r6
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-22,r7
.align 2
bf_addr266: .long basefunction
! Opcode 4EB8
OEB8:
mov.w @r6+,r4
mov r3,r2
mov r6,r3
sub r5,r3
mov r4,r6
mov.l bf_addr267,r0
jsr @r0
nop
add r5,r6
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-18,r7
.align 2
bf_addr267: .long basefunction
! Opcode 4EB9
OEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov r3,r2
mov r6,r3
sub r5,r3
mov r4,r6
mov.l bf_addr268,r0
jsr @r0
nop
add r5,r6
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-20,r7
.align 2
bf_addr268: .long basefunction
! Opcode 4EBA
OEBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov r3,r2
mov r6,r3
sub r5,r3
mov r4,r6
mov.l bf_addr269,r0
jsr @r0
nop
add r5,r6
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-18,r7
.align 2
bf_addr269: .long basefunction
! Opcode 4EBB
OEBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov r3,r2
mov r6,r3
sub r5,r3
mov r4,r6
mov.l bf_addr270,r0
jsr @r0
nop
add r5,r6
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-22,r7
.align 2
bf_addr270: .long basefunction
! Opcodes 4ED0 - 4ED7
OED0:
mov r2,r0
mov.l @(r0,r14),r4
mov r4,r6
mov.l bf_addr271,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-8,r7
.align 2
bf_addr271: .long basefunction
! Opcodes 4EE8 - 4EEF
OEE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov r4,r6
mov.l bf_addr272,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-10,r7
.align 2
bf_addr272: .long basefunction
! Opcodes 4EF0 - 4EF7
OEF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov r4,r6
mov.l bf_addr273,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-14,r7
.align 2
bf_addr273: .long basefunction
! Opcode 4EF8
OEF8:
mov.w @r6+,r4
mov r4,r6
mov.l bf_addr274,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-10,r7
.align 2
bf_addr274: .long basefunction
! Opcode 4EF9
OEF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov r4,r6
mov.l bf_addr275,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-12,r7
.align 2
bf_addr275: .long basefunction
! Opcode 4EFA
OEFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov r4,r6
mov.l bf_addr276,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-10,r7
.align 2
bf_addr276: .long basefunction
! Opcode 4EFB
OEFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov r4,r6
mov.l bf_addr277,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-14,r7
.align 2
bf_addr277: .long basefunction
! Opcodes 4F80 - 4F87
OF80:
mov r2,r0
mov.w @(r0,r13),r3
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn278
mov #0,r8
cmp/hi r3,r1
bt ln278
jmp @r10
add #-10,r7
setn278:
mov #1,r8
ln278:
mov.l r1,@-r15
mov.l g2_except_ptr278,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr278,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_ptr278: .long group_2_exception
bf_addr278: .long basefunction
! Opcodes 4F90 - 4F97
OF90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn279
mov #0,r8
cmp/hi r3,r1
bt ln279
jmp @r10
add #-14,r7
setn279:
mov #1,r8
ln279:
mov.l r1,@-r15
mov.l g2_except_ptr279,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr279,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr279: .long group_2_exception
bf_addr279: .long basefunction
! Opcodes 4F98 - 4F9F
OF98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn280
mov #0,r8
cmp/hi r3,r1
bt ln280
jmp @r10
add #-14,r7
setn280:
mov #1,r8
ln280:
mov.l r1,@-r15
mov.l g2_except_ptr280,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr280,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr280: .long group_2_exception
bf_addr280: .long basefunction
! Opcodes 4FA0 - 4FA7
OFA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn281
mov #0,r8
cmp/hi r3,r1
bt ln281
jmp @r10
add #-16,r7
setn281:
mov #1,r8
ln281:
mov.l r1,@-r15
mov.l g2_except_ptr281,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr281,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-56,r7
.align 2
g2_except_ptr281: .long group_2_exception
bf_addr281: .long basefunction
! Opcodes 4FA8 - 4FAF
OFA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn282
mov #0,r8
cmp/hi r3,r1
bt ln282
jmp @r10
add #-18,r7
setn282:
mov #1,r8
ln282:
mov.l r1,@-r15
mov.l g2_except_ptr282,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr282,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr282: .long group_2_exception
bf_addr282: .long basefunction
! Opcodes 4FB0 - 4FB7
OFB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn283
mov #0,r8
cmp/hi r3,r1
bt ln283
jmp @r10
add #-20,r7
setn283:
mov #1,r8
ln283:
mov.l r1,@-r15
mov.l g2_except_ptr283,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr283,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr283: .long group_2_exception
bf_addr283: .long basefunction
! Opcode 4FB8
OFB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn284
mov #0,r8
cmp/hi r3,r1
bt ln284
jmp @r10
add #-18,r7
setn284:
mov #1,r8
ln284:
mov.l r1,@-r15
mov.l g2_except_ptr284,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr284,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr284: .long group_2_exception
bf_addr284: .long basefunction
! Opcode 4FB9
OFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn285
mov #0,r8
cmp/hi r3,r1
bt ln285
jmp @r10
add #-22,r7
setn285:
mov #1,r8
ln285:
mov.l r1,@-r15
mov.l g2_except_ptr285,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr285,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-62,r7
.align 2
g2_except_ptr285: .long group_2_exception
bf_addr285: .long basefunction
! Opcode 4FBA
OFBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn286
mov #0,r8
cmp/hi r3,r1
bt ln286
jmp @r10
add #-18,r7
setn286:
mov #1,r8
ln286:
mov.l r1,@-r15
mov.l g2_except_ptr286,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr286,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-58,r7
.align 2
g2_except_ptr286: .long group_2_exception
bf_addr286: .long basefunction
! Opcode 4FBB
OFBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn287
mov #0,r8
cmp/hi r3,r1
bt ln287
jmp @r10
add #-20,r7
setn287:
mov #1,r8
ln287:
mov.l r1,@-r15
mov.l g2_except_ptr287,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr287,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-60,r7
.align 2
g2_except_ptr287: .long group_2_exception
bf_addr287: .long basefunction
! Opcode 4FBC
OFBC:
mov.w @r6+,r3
mov #28,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn288
mov #0,r8
cmp/hi r3,r1
bt ln288
jmp @r10
add #-14,r7
setn288:
mov #1,r8
ln288:
mov.l r1,@-r15
mov.l g2_except_ptr288,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr288,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-54,r7
.align 2
g2_except_ptr288: .long group_2_exception
bf_addr288: .long basefunction
! Opcodes 4FD0 - 4FD7
OFD0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(60,r13)
jmp @r10
add #-4,r7
! Opcodes 4FE8 - 4FEF
OFE8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(60,r13)
jmp @r10
add #-8,r7
! Opcodes 4FF0 - 4FF7
OFF0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l r4,@(60,r13)
jmp @r10
add #-12,r7
! Opcode 4FF8
OFF8:
mov.w @r6+,r4
mov.l r4,@(60,r13)
jmp @r10
add #-8,r7
! Opcode 4FF9
OFF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(60,r13)
jmp @r10
add #-12,r7
! Opcode 4FFA
OFFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(60,r13)
jmp @r10
add #-8,r7
! Opcode 4FFB
OFFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l r4,@(60,r13)
jmp @r10
add #-12,r7
! Opcodes 5000 - 5007
P000:
add r13,r2
mov.b @r2,r3
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5008 - 500F
P008:
add r13,r2
mov.b @r2,r3
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5010 - 5017
P010:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5018 - 501F
P018:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5020 - 5027
P020:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5028 - 502F
P028:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5030 - 5037
P030:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5038
P038:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5039
P039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5040 - 5047
P040:
add r13,r2
mov.w @r2,r3
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5048 - 504F
P048:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 8,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5050 - 5057
P050:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5058 - 505F
P058:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5060 - 5067
P060:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5068 - 506F
P068:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5070 - 5077
P070:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5078
P078:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5079
P079:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5080 - 5087
P080:
add r13,r2
mov.l @r2,r3
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5088 - 508F
P088:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 8,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5090 - 5097
P090:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5098 - 509F
P098:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 50A0 - 50A7
P0A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 50A8 - 50AF
P0A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 50B0 - 50B7
P0B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 50B8
P0B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 50B9
P0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 50C0 - 50C7
P0C0:
mov.l r3,@-r15
mov #255,r3
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-6,r7
! Opcodes 50C8 - 50CF
P0C8:
add #2,r6
jmp @r10
add #-12,r7
! Opcodes 50D0 - 50D7
P0D0:
mov.l r3,@-r15
mov #255,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 50D8 - 50DF
P0D8:
mov.l r3,@-r15
mov #255,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 50E0 - 50E7
P0E0:
mov.l r3,@-r15
mov #255,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 50E8 - 50EF
P0E8:
mov.l r3,@-r15
mov #255,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 50F0 - 50F7
P0F0:
mov.l r3,@-r15
mov #255,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 50F8
P0F8:
mov.l r3,@-r15
mov #255,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 50F9
P0F9:
mov.l r3,@-r15
mov #255,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5100 - 5107
P100:
add r13,r2
mov.b @r2,r3
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5108 - 510F
P108:
add r13,r2
mov.b @r2,r3
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5110 - 5117
P110:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5118 - 511F
P118:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5120 - 5127
P120:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5128 - 512F
P128:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5130 - 5137
P130:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5138
P138:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5139
P139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5140 - 5147
P140:
add r13,r2
mov.w @r2,r3
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5148 - 514F
P148:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-8,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5150 - 5157
P150:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5158 - 515F
P158:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5160 - 5167
P160:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5168 - 516F
P168:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5170 - 5177
P170:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5178
P178:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5179
P179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5180 - 5187
P180:
add r13,r2
mov.l @r2,r3
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5188 - 518F
P188:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-8,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5190 - 5197
P190:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5198 - 519F
P198:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 51A0 - 51A7
P1A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 51A8 - 51AF
P1A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 51B0 - 51B7
P1B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 51B8
P1B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 51B9
P1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 51C0 - 51C7
P1C0:
mov.l r3,@-r15
mov #0,r3
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 51C8 - 51CF
P1C8:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w289
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w289:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 51D0 - 51D7
P1D0:
mov.l r3,@-r15
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 51D8 - 51DF
P1D8:
mov.l r3,@-r15
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 51E0 - 51E7
P1E0:
mov.l r3,@-r15
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 51E8 - 51EF
P1E8:
mov.l r3,@-r15
mov #0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 51F0 - 51F7
P1F0:
mov.l r3,@-r15
mov #0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 51F8
P1F8:
mov.l r3,@-r15
mov #0,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 51F9
P1F9:
mov.l r3,@-r15
mov #0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5200 - 5207
P200:
add r13,r2
mov.b @r2,r3
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5208 - 520F
P208:
add r13,r2
mov.b @r2,r3
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5210 - 5217
P210:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5218 - 521F
P218:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5220 - 5227
P220:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5228 - 522F
P228:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5230 - 5237
P230:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5238
P238:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5239
P239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5240 - 5247
P240:
add r13,r2
mov.w @r2,r3
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5248 - 524F
P248:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 1,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5250 - 5257
P250:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5258 - 525F
P258:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5260 - 5267
P260:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5268 - 526F
P268:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5270 - 5277
P270:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5278
P278:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5279
P279:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5280 - 5287
P280:
add r13,r2
mov.l @r2,r3
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5288 - 528F
P288:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 1,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5290 - 5297
P290:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5298 - 529F
P298:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 52A0 - 52A7
P2A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 52A8 - 52AF
P2A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 52B0 - 52B7
P2B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 52B8
P2B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 52B9
P2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 52C0 - 52C7
P2C0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 52C8 - 52CF
P2C8:
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
bf dbcc290
add #2,r6
jmp @r10
add #-12,r7
dbcc290:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w290
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w290:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 52D0 - 52D7
P2D0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 52D8 - 52DF
P2D8:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 52E0 - 52E7
P2E0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 52E8 - 52EF
P2E8:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 52F0 - 52F7
P2F0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 52F8
P2F8:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 52F9
P2F9:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
neg r3,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5300 - 5307
P300:
add r13,r2
mov.b @r2,r3
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5308 - 530F
P308:
add r13,r2
mov.b @r2,r3
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5310 - 5317
P310:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5318 - 531F
P318:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5320 - 5327
P320:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5328 - 532F
P328:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5330 - 5337
P330:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5338
P338:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5339
P339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5340 - 5347
P340:
add r13,r2
mov.w @r2,r3
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5348 - 534F
P348:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-1,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5350 - 5357
P350:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5358 - 535F
P358:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5360 - 5367
P360:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5368 - 536F
P368:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5370 - 5377
P370:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5378
P378:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5379
P379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5380 - 5387
P380:
add r13,r2
mov.l @r2,r3
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5388 - 538F
P388:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-1,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5390 - 5397
P390:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5398 - 539F
P398:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 53A0 - 53A7
P3A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 53A8 - 53AF
P3A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 53B0 - 53B7
P3B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 53B8
P3B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 53B9
P3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #1,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 53C0 - 53C7
P3C0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 53C8 - 53CF
P3C8:
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
bt dbcc291
add #2,r6
jmp @r10
add #-12,r7
dbcc291:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w291
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w291:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 53D0 - 53D7
P3D0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 53D8 - 53DF
P3D8:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 53E0 - 53E7
P3E0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 53E8 - 53EF
P3E8:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 53F0 - 53F7
P3F0:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 53F8
P3F8:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 53F9
P3F9:
mov.l r3,@-r15
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
movt r3
add #-1,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5400 - 5407
P400:
add r13,r2
mov.b @r2,r3
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5408 - 540F
P408:
add r13,r2
mov.b @r2,r3
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5410 - 5417
P410:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5418 - 541F
P418:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5420 - 5427
P420:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5428 - 542F
P428:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5430 - 5437
P430:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5438
P438:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5439
P439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5440 - 5447
P440:
add r13,r2
mov.w @r2,r3
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5448 - 544F
P448:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 2,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5450 - 5457
P450:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5458 - 545F
P458:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5460 - 5467
P460:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5468 - 546F
P468:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5470 - 5477
P470:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5478
P478:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5479
P479:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5480 - 5487
P480:
add r13,r2
mov.l @r2,r3
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5488 - 548F
P488:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 2,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5490 - 5497
P490:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5498 - 549F
P498:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 54A0 - 54A7
P4A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 54A8 - 54AF
P4A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 54B0 - 54B7
P4B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 54B8
P4B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 54B9
P4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 54C0 - 54C7
P4C0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 54C8 - 54CF
P4C8:
mov r8,r0
tst #1,r0
bf dbcc292
add #2,r6
jmp @r10
add #-12,r7
dbcc292:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w292
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w292:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 54D0 - 54D7
P4D0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 54D8 - 54DF
P4D8:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 54E0 - 54E7
P4E0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 54E8 - 54EF
P4E8:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 54F0 - 54F7
P4F0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 54F8
P4F8:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 54F9
P4F9:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
neg r3,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5500 - 5507
P500:
add r13,r2
mov.b @r2,r3
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5508 - 550F
P508:
add r13,r2
mov.b @r2,r3
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5510 - 5517
P510:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5518 - 551F
P518:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5520 - 5527
P520:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5528 - 552F
P528:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5530 - 5537
P530:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5538
P538:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5539
P539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5540 - 5547
P540:
add r13,r2
mov.w @r2,r3
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5548 - 554F
P548:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-2,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5550 - 5557
P550:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5558 - 555F
P558:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5560 - 5567
P560:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5568 - 556F
P568:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5570 - 5577
P570:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5578
P578:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5579
P579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5580 - 5587
P580:
add r13,r2
mov.l @r2,r3
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5588 - 558F
P588:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-2,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5590 - 5597
P590:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5598 - 559F
P598:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 55A0 - 55A7
P5A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 55A8 - 55AF
P5A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 55B0 - 55B7
P5B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 55B8
P5B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 55B9
P5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #2,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 55C0 - 55C7
P5C0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 55C8 - 55CF
P5C8:
mov r8,r0
tst #1,r0
bt dbcc293
add #2,r6
jmp @r10
add #-12,r7
dbcc293:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w293
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w293:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 55D0 - 55D7
P5D0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 55D8 - 55DF
P5D8:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 55E0 - 55E7
P5E0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 55E8 - 55EF
P5E8:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 55F0 - 55F7
P5F0:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 55F8
P5F8:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 55F9
P5F9:
mov.l r3,@-r15
mov r8,r0
tst #1,r0
movt r3
add #-1,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5600 - 5607
P600:
add r13,r2
mov.b @r2,r3
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5608 - 560F
P608:
add r13,r2
mov.b @r2,r3
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5610 - 5617
P610:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5618 - 561F
P618:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5620 - 5627
P620:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5628 - 562F
P628:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5630 - 5637
P630:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5638
P638:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5639
P639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5640 - 5647
P640:
add r13,r2
mov.w @r2,r3
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5648 - 564F
P648:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 3,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5650 - 5657
P650:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5658 - 565F
P658:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5660 - 5667
P660:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5668 - 566F
P668:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5670 - 5677
P670:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5678
P678:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5679
P679:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5680 - 5687
P680:
add r13,r2
mov.l @r2,r3
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5688 - 568F
P688:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 3,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5690 - 5697
P690:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5698 - 569F
P698:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 56A0 - 56A7
P6A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 56A8 - 56AF
P6A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 56B0 - 56B7
P6B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 56B8
P6B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 56B9
P6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 56C0 - 56C7
P6C0:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 56C8 - 56CF
P6C8:
tst r3,r3
bt dbcc294
add #2,r6
jmp @r10
add #-12,r7
dbcc294:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w294
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w294:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 56D0 - 56D7
P6D0:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 56D8 - 56DF
P6D8:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 56E0 - 56E7
P6E0:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 56E8 - 56EF
P6E8:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 56F0 - 56F7
P6F0:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 56F8
P6F8:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 56F9
P6F9:
mov.l r3,@-r15
tst r3,r3
movt r3
add #-1,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5700 - 5707
P700:
add r13,r2
mov.b @r2,r3
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5708 - 570F
P708:
add r13,r2
mov.b @r2,r3
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5710 - 5717
P710:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5718 - 571F
P718:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5720 - 5727
P720:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5728 - 572F
P728:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5730 - 5737
P730:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5738
P738:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5739
P739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5740 - 5747
P740:
add r13,r2
mov.w @r2,r3
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5748 - 574F
P748:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-3,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5750 - 5757
P750:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5758 - 575F
P758:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5760 - 5767
P760:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5768 - 576F
P768:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5770 - 5777
P770:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5778
P778:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5779
P779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5780 - 5787
P780:
add r13,r2
mov.l @r2,r3
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5788 - 578F
P788:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-3,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5790 - 5797
P790:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5798 - 579F
P798:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 57A0 - 57A7
P7A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 57A8 - 57AF
P7A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 57B0 - 57B7
P7B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 57B8
P7B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 57B9
P7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #3,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 57C0 - 57C7
P7C0:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 57C8 - 57CF
P7C8:
tst r3,r3
bf dbcc295
add #2,r6
jmp @r10
add #-12,r7
dbcc295:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w295
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w295:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 57D0 - 57D7
P7D0:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 57D8 - 57DF
P7D8:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 57E0 - 57E7
P7E0:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 57E8 - 57EF
P7E8:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 57F0 - 57F7
P7F0:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 57F8
P7F8:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 57F9
P7F9:
mov.l r3,@-r15
tst r3,r3
movt r3
neg r3,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5800 - 5807
P800:
add r13,r2
mov.b @r2,r3
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5808 - 580F
P808:
add r13,r2
mov.b @r2,r3
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5810 - 5817
P810:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5818 - 581F
P818:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5820 - 5827
P820:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5828 - 582F
P828:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5830 - 5837
P830:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5838
P838:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5839
P839:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5840 - 5847
P840:
add r13,r2
mov.w @r2,r3
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5848 - 584F
P848:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 4,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5850 - 5857
P850:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5858 - 585F
P858:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5860 - 5867
P860:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5868 - 586F
P868:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5870 - 5877
P870:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5878
P878:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5879
P879:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5880 - 5887
P880:
add r13,r2
mov.l @r2,r3
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5888 - 588F
P888:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 4,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5890 - 5897
P890:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5898 - 589F
P898:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 58A0 - 58A7
P8A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 58A8 - 58AF
P8A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 58B0 - 58B7
P8B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 58B8
P8B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 58B9
P8B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 58C0 - 58C7
P8C0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 58C8 - 58CF
P8C8:
mov r8,r0
tst #2,r0
bf dbcc296
add #2,r6
jmp @r10
add #-12,r7
dbcc296:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w296
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w296:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 58D0 - 58D7
P8D0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 58D8 - 58DF
P8D8:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 58E0 - 58E7
P8E0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 58E8 - 58EF
P8E8:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 58F0 - 58F7
P8F0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 58F8
P8F8:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 58F9
P8F9:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
neg r3,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5900 - 5907
P900:
add r13,r2
mov.b @r2,r3
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5908 - 590F
P908:
add r13,r2
mov.b @r2,r3
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5910 - 5917
P910:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5918 - 591F
P918:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5920 - 5927
P920:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5928 - 592F
P928:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5930 - 5937
P930:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5938
P938:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5939
P939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5940 - 5947
P940:
add r13,r2
mov.w @r2,r3
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5948 - 594F
P948:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-4,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5950 - 5957
P950:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5958 - 595F
P958:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5960 - 5967
P960:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5968 - 596F
P968:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5970 - 5977
P970:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5978
P978:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5979
P979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5980 - 5987
P980:
add r13,r2
mov.l @r2,r3
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5988 - 598F
P988:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-4,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5990 - 5997
P990:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5998 - 599F
P998:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 59A0 - 59A7
P9A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 59A8 - 59AF
P9A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 59B0 - 59B7
P9B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 59B8
P9B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 59B9
P9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 59C0 - 59C7
P9C0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 59C8 - 59CF
P9C8:
mov r8,r0
tst #2,r0
bt dbcc297
add #2,r6
jmp @r10
add #-12,r7
dbcc297:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w297
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w297:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 59D0 - 59D7
P9D0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 59D8 - 59DF
P9D8:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 59E0 - 59E7
P9E0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 59E8 - 59EF
P9E8:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 59F0 - 59F7
P9F0:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 59F8
P9F8:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 59F9
P9F9:
mov.l r3,@-r15
mov r8,r0
tst #2,r0
movt r3
add #-1,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5A00 - 5A07
PA00:
add r13,r2
mov.b @r2,r3
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5A08 - 5A0F
PA08:
add r13,r2
mov.b @r2,r3
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5A10 - 5A17
PA10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5A18 - 5A1F
PA18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5A20 - 5A27
PA20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5A28 - 5A2F
PA28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5A30 - 5A37
PA30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5A38
PA38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5A39
PA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5A40 - 5A47
PA40:
add r13,r2
mov.w @r2,r3
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5A48 - 5A4F
PA48:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 5,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5A50 - 5A57
PA50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5A58 - 5A5F
PA58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5A60 - 5A67
PA60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5A68 - 5A6F
PA68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5A70 - 5A77
PA70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5A78
PA78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5A79
PA79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5A80 - 5A87
PA80:
add r13,r2
mov.l @r2,r3
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5A88 - 5A8F
PA88:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 5,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5A90 - 5A97
PA90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5A98 - 5A9F
PA98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 5AA0 - 5AA7
PAA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 5AA8 - 5AAF
PAA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 5AB0 - 5AB7
PAB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 5AB8
PAB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 5AB9
PAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 5AC0 - 5AC7
PAC0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 5AC8 - 5ACF
PAC8:
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
bt dbcc298
add #2,r6
jmp @r10
add #-12,r7
dbcc298:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w298
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w298:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 5AD0 - 5AD7
PAD0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5AD8 - 5ADF
PAD8:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5AE0 - 5AE7
PAE0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 5AE8 - 5AEF
PAE8:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 5AF0 - 5AF7
PAF0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 5AF8
PAF8:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 5AF9
PAF9:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
add #-1,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5B00 - 5B07
PB00:
add r13,r2
mov.b @r2,r3
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5B08 - 5B0F
PB08:
add r13,r2
mov.b @r2,r3
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5B10 - 5B17
PB10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5B18 - 5B1F
PB18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5B20 - 5B27
PB20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5B28 - 5B2F
PB28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5B30 - 5B37
PB30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5B38
PB38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5B39
PB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5B40 - 5B47
PB40:
add r13,r2
mov.w @r2,r3
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5B48 - 5B4F
PB48:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-5,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5B50 - 5B57
PB50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5B58 - 5B5F
PB58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5B60 - 5B67
PB60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5B68 - 5B6F
PB68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5B70 - 5B77
PB70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5B78
PB78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5B79
PB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5B80 - 5B87
PB80:
add r13,r2
mov.l @r2,r3
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5B88 - 5B8F
PB88:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-5,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5B90 - 5B97
PB90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5B98 - 5B9F
PB98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 5BA0 - 5BA7
PBA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 5BA8 - 5BAF
PBA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 5BB0 - 5BB7
PBB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 5BB8
PBB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 5BB9
PBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #5,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 5BC0 - 5BC7
PBC0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 5BC8 - 5BCF
PBC8:
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
bf dbcc299
add #2,r6
jmp @r10
add #-12,r7
dbcc299:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w299
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w299:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 5BD0 - 5BD7
PBD0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5BD8 - 5BDF
PBD8:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5BE0 - 5BE7
PBE0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 5BE8 - 5BEF
PBE8:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 5BF0 - 5BF7
PBF0:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 5BF8
PBF8:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 5BF9
PBF9:
mov.l r3,@-r15
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
movt r3
neg r3,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5C00 - 5C07
PC00:
add r13,r2
mov.b @r2,r3
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5C08 - 5C0F
PC08:
add r13,r2
mov.b @r2,r3
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5C10 - 5C17
PC10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5C18 - 5C1F
PC18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5C20 - 5C27
PC20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5C28 - 5C2F
PC28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5C30 - 5C37
PC30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5C38
PC38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5C39
PC39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5C40 - 5C47
PC40:
add r13,r2
mov.w @r2,r3
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5C48 - 5C4F
PC48:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 6,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5C50 - 5C57
PC50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5C58 - 5C5F
PC58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5C60 - 5C67
PC60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5C68 - 5C6F
PC68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5C70 - 5C77
PC70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5C78
PC78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5C79
PC79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5C80 - 5C87
PC80:
add r13,r2
mov.l @r2,r3
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5C88 - 5C8F
PC88:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 6,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5C90 - 5C97
PC90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5C98 - 5C9F
PC98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 5CA0 - 5CA7
PCA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 5CA8 - 5CAF
PCA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 5CB0 - 5CB7
PCB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 5CB8
PCB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 5CB9
PCB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 5CC0 - 5CC7
PCC0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 5CC8 - 5CCF
PCC8:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
bt dbcc300
add #2,r6
jmp @r10
add #-12,r7
dbcc300:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w300
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w300:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 5CD0 - 5CD7
PCD0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5CD8 - 5CDF
PCD8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5CE0 - 5CE7
PCE0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 5CE8 - 5CEF
PCE8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 5CF0 - 5CF7
PCF0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 5CF8
PCF8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 5CF9
PCF9:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
add #-1,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5D00 - 5D07
PD00:
add r13,r2
mov.b @r2,r3
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5D08 - 5D0F
PD08:
add r13,r2
mov.b @r2,r3
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5D10 - 5D17
PD10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5D18 - 5D1F
PD18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5D20 - 5D27
PD20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5D28 - 5D2F
PD28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5D30 - 5D37
PD30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5D38
PD38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5D39
PD39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5D40 - 5D47
PD40:
add r13,r2
mov.w @r2,r3
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5D48 - 5D4F
PD48:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-6,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5D50 - 5D57
PD50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5D58 - 5D5F
PD58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5D60 - 5D67
PD60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5D68 - 5D6F
PD68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5D70 - 5D77
PD70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5D78
PD78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5D79
PD79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5D80 - 5D87
PD80:
add r13,r2
mov.l @r2,r3
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5D88 - 5D8F
PD88:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-6,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5D90 - 5D97
PD90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5D98 - 5D9F
PD98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 5DA0 - 5DA7
PDA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 5DA8 - 5DAF
PDA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 5DB0 - 5DB7
PDB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 5DB8
PDB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 5DB9
PDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #6,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 5DC0 - 5DC7
PDC0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 5DC8 - 5DCF
PDC8:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
bf dbcc301
add #2,r6
jmp @r10
add #-12,r7
dbcc301:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w301
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w301:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 5DD0 - 5DD7
PDD0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5DD8 - 5DDF
PDD8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5DE0 - 5DE7
PDE0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 5DE8 - 5DEF
PDE8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 5DF0 - 5DF7
PDF0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 5DF8
PDF8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 5DF9
PDF9:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
movt r3
neg r3,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5E00 - 5E07
PE00:
add r13,r2
mov.b @r2,r3
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5E08 - 5E0F
PE08:
add r13,r2
mov.b @r2,r3
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5E10 - 5E17
PE10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5E18 - 5E1F
PE18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5E20 - 5E27
PE20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5E28 - 5E2F
PE28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5E30 - 5E37
PE30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5E38
PE38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5E39
PE39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5E40 - 5E47
PE40:
add r13,r2
mov.w @r2,r3
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5E48 - 5E4F
PE48:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 7,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-4,r7
! Opcodes 5E50 - 5E57
PE50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5E58 - 5E5F
PE58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5E60 - 5E67
PE60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5E68 - 5E6F
PE68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5E70 - 5E77
PE70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5E78
PE78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5E79
PE79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5E80 - 5E87
PE80:
add r13,r2
mov.l @r2,r3
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5E88 - 5E8F
PE88:
mov r3,r4
add r14,r2
mov.l @r2,r3
add # 7,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5E90 - 5E97
PE90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5E98 - 5E9F
PE98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 5EA0 - 5EA7
PEA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 5EA8 - 5EAF
PEA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 5EB0 - 5EB7
PEB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 5EB8
PEB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 5EB9
PEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
addv r1,r3
movt r8
addc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 5EC0 - 5EC7
PEC0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 5EC8 - 5ECF
PEC8:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
bf dbcc302
add #2,r6
jmp @r10
add #-12,r7
dbcc302:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w302
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w302:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 5ED0 - 5ED7
PED0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5ED8 - 5EDF
PED8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5EE0 - 5EE7
PEE0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 5EE8 - 5EEF
PEE8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 5EF0 - 5EF7
PEF0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 5EF8
PEF8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 5EF9
PEF9:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
neg r3,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcodes 5F00 - 5F07
PF00:
add r13,r2
mov.b @r2,r3
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5F08 - 5F0F
PF08:
add r13,r2
mov.b @r2,r3
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5F10 - 5F17
PF10:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5F18 - 5F1F
PF18:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5F20 - 5F27
PF20:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5F28 - 5F2F
PF28:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5F30 - 5F37
PF30:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5F38
PF38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5F39
PF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5F40 - 5F47
PF40:
add r13,r2
mov.w @r2,r3
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
jmp @r10
add #-4,r7
! Opcodes 5F48 - 5F4F
PF48:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-7,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5F50 - 5F57
PF50:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-12,r7
! Opcodes 5F58 - 5F5F
PF58:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-12,r7
! Opcodes 5F60 - 5F67
PF60:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-14,r7
! Opcodes 5F68 - 5F6F
PF68:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcodes 5F70 - 5F77
PF70:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-18,r7
! Opcode 5F78
PF78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-16,r7
! Opcode 5F79
PF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5F80 - 5F87
PF80:
add r13,r2
mov.l @r2,r3
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l r3,@r2
jmp @r10
add #-8,r7
! Opcodes 5F88 - 5F8F
PF88:
mov r3,r4
add r14,r2
mov.l @r2,r3
add #-7,r3
mov.l r3,@r2
mov r4,r3
jmp @r10
add #-8,r7
! Opcodes 5F90 - 5F97
PF90:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-20,r7
! Opcodes 5F98 - 5F9F
PF98:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-20,r7
! Opcodes 5FA0 - 5FA7
PFA0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
jmp @r10
add #-22,r7
! Opcodes 5FA8 - 5FAF
PFA8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcodes 5FB0 - 5FB7
PFB0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-26,r7
! Opcode 5FB8
PFB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-24,r7
! Opcode 5FB9
PFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #7,r1
mov r3,r0
subv r1,r3
movt r8
subc r1,r0
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
jmp @r10
add #-28,r7
! Opcodes 5FC0 - 5FC7
PFC0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
add r3,r7
add r3,r7
mov r2,r0
mov.b r3,@(r0,r13)
mov.l @r15+,r3
jmp @r10
add #-4,r7
! Opcodes 5FC8 - 5FCF
PFC8:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
bt dbcc303
add #2,r6
jmp @r10
add #-12,r7
dbcc303:
mov r2,r0
mov.w @(r0,r13),r1
tst r1,r1
add #-1,r1
bf/s bcc_w303
mov.w r1,@(r0,r13)
add #2,r6
jmp @r10
add #-14,r7
bcc_w303:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 5FD0 - 5FD7
PFD0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5FD8 - 5FDF
PFD8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-12,r7
! Opcodes 5FE0 - 5FE7
PFE0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
jmp @r10
add #-14,r7
! Opcodes 5FE8 - 5FEF
PFE8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcodes 5FF0 - 5FF7
PFF0:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-18,r7
! Opcode 5FF8
PFF8:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-16,r7
! Opcode 5FF9
PFF9:
mov.l r3,@-r15
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
movt r3
add #-1,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
jmp @r10
add #-20,r7
! Opcode 6000
Q000:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6001 - 60FF
Q001:
shlr2 r0
exts.b r0,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6100
Q100:
mov.w @r6,r1
mov r3,r2
mov r6,r3
add #2,r3
add r1,r6
sub r5,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-18,r7
! Opcodes 6101 - 61FF
Q101:
shlr2 r0
mov r3,r2
exts.b r0,r1
mov r6,r3
add r1,r6
sub r5,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
mov r2,r3
jmp @r10
add #-18,r7
! Opcode 6200
Q200:
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
bt bcc_w305
add #2,r6
jmp @r10
add #-12,r7
bcc_w305:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6201 - 62FF
Q201:
mov r0,r2
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
bt bcc_b306
jmp @r10
add #-8,r7
bcc_b306:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6300
Q300:
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
bf bcc_w307
add #2,r6
jmp @r10
add #-12,r7
bcc_w307:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6301 - 63FF
Q301:
mov r0,r2
tst r3,r3
mov r8,r0
addc r0,r0
tst #3,r0
bf bcc_b308
jmp @r10
add #-8,r7
bcc_b308:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6400
Q400:
mov r8,r0
tst #1,r0
bt bcc_w309
add #2,r6
jmp @r10
add #-12,r7
bcc_w309:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6401 - 64FF
Q401:
mov r0,r2
mov r8,r0
tst #1,r0
bt bcc_b310
jmp @r10
add #-8,r7
bcc_b310:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6500
Q500:
mov r8,r0
tst #1,r0
bf bcc_w311
add #2,r6
jmp @r10
add #-12,r7
bcc_w311:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6501 - 65FF
Q501:
mov r0,r2
mov r8,r0
tst #1,r0
bf bcc_b312
jmp @r10
add #-8,r7
bcc_b312:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6600
Q600:
tst r3,r3
bf bcc_w313
add #2,r6
jmp @r10
add #-12,r7
bcc_w313:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6601 - 66FF
Q601:
mov r0,r2
tst r3,r3
bf bcc_b314
jmp @r10
add #-8,r7
bcc_b314:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6700
Q700:
tst r3,r3
bt bcc_w315
add #2,r6
jmp @r10
add #-12,r7
bcc_w315:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6701 - 67FF
Q701:
mov r0,r2
tst r3,r3
bt bcc_b316
jmp @r10
add #-8,r7
bcc_b316:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6800
Q800:
mov r8,r0
tst #2,r0
bt bcc_w317
add #2,r6
jmp @r10
add #-12,r7
bcc_w317:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6801 - 68FF
Q801:
mov r0,r2
mov r8,r0
tst #2,r0
bt bcc_b318
jmp @r10
add #-8,r7
bcc_b318:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6900
Q900:
mov r8,r0
tst #2,r0
bf bcc_w319
add #2,r6
jmp @r10
add #-12,r7
bcc_w319:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6901 - 69FF
Q901:
mov r0,r2
mov r8,r0
tst #2,r0
bf bcc_b320
jmp @r10
add #-8,r7
bcc_b320:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6A00
QA00:
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
bf bcc_w321
add #2,r6
jmp @r10
add #-12,r7
bcc_w321:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6A01 - 6AFF
QA01:
mov r0,r2
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
bf bcc_b322
jmp @r10
add #-8,r7
bcc_b322:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6B00
QB00:
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
bt bcc_w323
add #2,r6
jmp @r10
add #-12,r7
bcc_w323:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6B01 - 6BFF
QB01:
mov r0,r2
mov r8,r0
rotl r3
movt r1
shlr2 r0
xor r1,r0
rotr r3
shlr r0
bt bcc_b324
jmp @r10
add #-8,r7
bcc_b324:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6C00
QC00:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
bf bcc_w325
add #2,r6
jmp @r10
add #-12,r7
bcc_w325:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6C01 - 6CFF
QC01:
mov r0,r2
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
bf bcc_b326
jmp @r10
add #-8,r7
bcc_b326:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6D00
QD00:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
bt bcc_w327
add #2,r6
jmp @r10
add #-12,r7
bcc_w327:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6D01 - 6DFF
QD01:
mov r0,r2
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
xor r8,r0
shlr r0
shlr r0
mov r8,r0
rotl r3
movt r1
shlr2 r0
rotr r3
xor r0,r1
mov r8,r0
shlr r0
xor r1,r0
shlr r0
bt bcc_b328
jmp @r10
add #-8,r7
bcc_b328:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6E00
QE00:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
bt bcc_w329
add #2,r6
jmp @r10
add #-12,r7
bcc_w329:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6E01 - 6EFF
QE01:
mov r0,r2
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
bt bcc_b330
jmp @r10
add #-8,r7
bcc_b330:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcode 6F00
QF00:
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
bf bcc_w331
add #2,r6
jmp @r10
add #-12,r7
bcc_w331:
mov.w @r6,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 6F01 - 6FFF
QF01:
mov r0,r2
mov r3,r1
mov r8,r0
rotl r1
shlr r0
shll r1
xor r1,r0
tst r3,r3
xor r8,r0
addc r0,r0
tst #5,r0
bf bcc_b332
jmp @r10
add #-8,r7
bcc_b332:
shlr2 r2
exts.b r2,r0
add r0,r6
jmp @r10
add #-10,r7
! Opcodes 7000 - 70FF
R000:
shlr2 r0
exts.b r0,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 7200 - 72FF
R200:
shlr2 r0
exts.b r0,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 7400 - 74FF
R400:
shlr2 r0
exts.b r0,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 7600 - 76FF
R600:
shlr2 r0
exts.b r0,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 7800 - 78FF
R800:
shlr2 r0
exts.b r0,r3
mov.l r3,@(16,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 7A00 - 7AFF
RA00:
shlr2 r0
exts.b r0,r3
mov.l r3,@(20,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 7C00 - 7CFF
RC00:
shlr2 r0
exts.b r0,r3
mov.l r3,@(24,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 7E00 - 7EFF
RE00:
shlr2 r0
exts.b r0,r3
mov.l r3,@(28,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8000 - 8007
S000:
add r13,r2
mov.b @r2,r3
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8010 - 8017
S010:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8018 - 801F
S018:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8020 - 8027
S020:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8028 - 802F
S028:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8030 - 8037
S030:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8038
S038:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8039
S039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 803A
S03A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 803B
S03B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 803C
S03C:
mov.b @r6,r3
add #2,r6
mov.b @r13,r1
or r1,r3
mov.b r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8040 - 8047
S040:
add r13,r2
mov.w @r2,r3
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8050 - 8057
S050:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8058 - 805F
S058:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8060 - 8067
S060:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8068 - 806F
S068:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8070 - 8077
S070:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8078
S078:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8079
S079:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 807A
S07A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 807B
S07B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 807C
S07C:
mov.w @r6+,r3
mov.w @r13,r1
or r1,r3
mov.w r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8080 - 8087
S080:
add r13,r2
mov.l @r2,r3
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8090 - 8097
S090:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8098 - 809F
S098:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 80A0 - 80A7
S0A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 80A8 - 80AF
S0A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 80B0 - 80B7
S0B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 80B8
S0B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 80B9
S0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 80BA
S0BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 80BB
S0BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 80BC
S0BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @r13,r1
or r1,r3
mov.l r3,@r13
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 80C0 - 80C7
S0C0:
add r13,r2
mov.w @r2,r3
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln333
shll16 r3
cmp/hs r3,r1
bt ov334
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-106,r7
ov334:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-10,r7
ln333:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr333,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr333,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_except_addr333: .long group_2_exception
bf_addr333: .long basefunction
! Opcodes 80D0 - 80D7
S0D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln335
shll16 r3
cmp/hs r3,r1
bt ov336
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov336:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln335:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr335,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr335,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr335: .long group_2_exception
bf_addr335: .long basefunction
! Opcodes 80D8 - 80DF
S0D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln337
shll16 r3
cmp/hs r3,r1
bt ov338
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov338:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln337:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr337,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr337,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr337: .long group_2_exception
bf_addr337: .long basefunction
! Opcodes 80E0 - 80E7
S0E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln339
shll16 r3
cmp/hs r3,r1
bt ov340
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-112,r7
ov340:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-16,r7
ln339:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr339,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr339,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-44,r7
.align 2
g2_except_addr339: .long group_2_exception
bf_addr339: .long basefunction
! Opcodes 80E8 - 80EF
S0E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln341
shll16 r3
cmp/hs r3,r1
bt ov342
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov342:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln341:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr341,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr341,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr341: .long group_2_exception
bf_addr341: .long basefunction
! Opcodes 80F0 - 80F7
S0F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln343
shll16 r3
cmp/hs r3,r1
bt ov344
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-116,r7
ov344:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln343:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr343,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr343,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr343: .long group_2_exception
bf_addr343: .long basefunction
! Opcode 80F8
S0F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln345
shll16 r3
cmp/hs r3,r1
bt ov346
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov346:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln345:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr345,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr345,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr345: .long group_2_exception
bf_addr345: .long basefunction
! Opcode 80F9
S0F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln347
shll16 r3
cmp/hs r3,r1
bt ov348
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-118,r7
ov348:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-22,r7
ln347:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr347,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr347,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_addr347: .long group_2_exception
bf_addr347: .long basefunction
! Opcode 80FA
S0FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln349
shll16 r3
cmp/hs r3,r1
bt ov350
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov350:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln349:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr349,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr349,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr349: .long group_2_exception
bf_addr349: .long basefunction
! Opcode 80FB
S0FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln351
shll16 r3
cmp/hs r3,r1
bt ov352
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-116,r7
ov352:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln351:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr351,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr351,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr351: .long group_2_exception
bf_addr351: .long basefunction
! Opcode 80FC
S0FC:
mov.w @r6+,r3
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln353
shll16 r3
cmp/hs r3,r1
bt ov354
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov354:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln353:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr353,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr353,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr353: .long group_2_exception
bf_addr353: .long basefunction
! Opcodes 8100 - 8107
S100:
mov r3,r4
mov.b @r13,r3
mov r2,r0
mov.b @(r0,r13),r1
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd355
add #-6,r8
.nonibadd355:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop355
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop355:
exts.b r3,r3
mov r9,r8
mov.b r3,@r13
or r4,r3
jmp @r10
add #-6,r7
! Opcodes 8108 - 810F
S108:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r2
mov.l @(32,r13),r4
add #-1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r1
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd356
add #-6,r8
.nonibadd356:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop356
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop356:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-18,r7
! Opcodes 8110 - 8117
S110:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8118 - 811F
S118:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8120 - 8127
S120:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8128 - 812F
S128:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 8130 - 8137
S130:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 8138
S138:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 8139
S139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8150 - 8157
S150:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8158 - 815F
S158:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8160 - 8167
S160:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8168 - 816F
S168:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 8170 - 8177
S170:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 8178
S178:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 8179
S179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8190 - 8197
S190:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8198 - 819F
S198:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 81A0 - 81A7
S1A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 81A8 - 81AF
S1A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 81B0 - 81B7
S1B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 81B8
S1B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 81B9
S1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 81C0 - 81C7
S1C0:
add r13,r2
mov.w @r2,r3
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln357
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck357
add #1,r1
tst r1,r1
bf ov358
ovcheck357:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-11,r7
ov358:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-16,r7
ln357:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr357,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr357,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_except_addr357: .long group_2_exception
bf_addr357: .long basefunction
! Opcodes 81D0 - 81D7
S1D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln359
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck359
add #1,r1
tst r1,r1
bf ov360
ovcheck359:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov360:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln359:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr359,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr359,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr359: .long group_2_exception
bf_addr359: .long basefunction
! Opcodes 81D8 - 81DF
S1D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln361
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck361
add #1,r1
tst r1,r1
bf ov362
ovcheck361:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov362:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln361:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr361,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr361,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr361: .long group_2_exception
bf_addr361: .long basefunction
! Opcodes 81E0 - 81E7
S1E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln363
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck363
add #1,r1
tst r1,r1
bf ov364
ovcheck363:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-17,r7
ov364:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-22,r7
ln363:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr363,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr363,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-44,r7
.align 2
g2_except_addr363: .long group_2_exception
bf_addr363: .long basefunction
! Opcodes 81E8 - 81EF
S1E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln365
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck365
add #1,r1
tst r1,r1
bf ov366
ovcheck365:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov366:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln365:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr365,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr365,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr365: .long group_2_exception
bf_addr365: .long basefunction
! Opcodes 81F0 - 81F7
S1F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln367
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck367
add #1,r1
tst r1,r1
bf ov368
ovcheck367:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-21,r7
ov368:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-26,r7
ln367:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr367,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr367,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr367: .long group_2_exception
bf_addr367: .long basefunction
! Opcode 81F8
S1F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln369
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck369
add #1,r1
tst r1,r1
bf ov370
ovcheck369:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov370:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln369:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr369,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr369,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr369: .long group_2_exception
bf_addr369: .long basefunction
! Opcode 81F9
S1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln371
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck371
add #1,r1
tst r1,r1
bf ov372
ovcheck371:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-23,r7
ov372:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-28,r7
ln371:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr371,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr371,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_addr371: .long group_2_exception
bf_addr371: .long basefunction
! Opcode 81FA
S1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln373
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck373
add #1,r1
tst r1,r1
bf ov374
ovcheck373:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov374:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln373:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr373,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr373,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr373: .long group_2_exception
bf_addr373: .long basefunction
! Opcode 81FB
S1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln375
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck375
add #1,r1
tst r1,r1
bf ov376
ovcheck375:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-21,r7
ov376:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-26,r7
ln375:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr375,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr375,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr375: .long group_2_exception
bf_addr375: .long basefunction
! Opcode 81FC
S1FC:
mov.w @r6+,r3
mov.l @r13,r1
mov r3,r8
tst r8,r8
bt/s ln377
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck377
add #1,r1
tst r1,r1
bf ov378
ovcheck377:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@r13
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov378:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln377:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr377,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr377,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr377: .long group_2_exception
bf_addr377: .long basefunction
! Opcodes 8200 - 8207
S200:
add r13,r2
mov.b @r2,r3
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8210 - 8217
S210:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8218 - 821F
S218:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8220 - 8227
S220:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8228 - 822F
S228:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8230 - 8237
S230:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8238
S238:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8239
S239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 823A
S23A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 823B
S23B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 823C
S23C:
mov.b @r6,r3
add #2,r6
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov #4,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8240 - 8247
S240:
add r13,r2
mov.w @r2,r3
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8250 - 8257
S250:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8258 - 825F
S258:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8260 - 8267
S260:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8268 - 826F
S268:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8270 - 8277
S270:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8278
S278:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8279
S279:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 827A
S27A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 827B
S27B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 827C
S27C:
mov.w @r6+,r3
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov #4,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8280 - 8287
S280:
add r13,r2
mov.l @r2,r3
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8290 - 8297
S290:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8298 - 829F
S298:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 82A0 - 82A7
S2A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 82A8 - 82AF
S2A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 82B0 - 82B7
S2B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 82B8
S2B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 82B9
S2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 82BA
S2BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 82BB
S2BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 82BC
S2BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(4,r13),r1
or r1,r3
mov.l r3,@(4,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 82C0 - 82C7
S2C0:
add r13,r2
mov.w @r2,r3
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln379
shll16 r3
cmp/hs r3,r1
bt ov380
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-106,r7
ov380:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-10,r7
ln379:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr379,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr379,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_except_addr379: .long group_2_exception
bf_addr379: .long basefunction
! Opcodes 82D0 - 82D7
S2D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln381
shll16 r3
cmp/hs r3,r1
bt ov382
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov382:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln381:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr381,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr381,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr381: .long group_2_exception
bf_addr381: .long basefunction
! Opcodes 82D8 - 82DF
S2D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln383
shll16 r3
cmp/hs r3,r1
bt ov384
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov384:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln383:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr383,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr383,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr383: .long group_2_exception
bf_addr383: .long basefunction
! Opcodes 82E0 - 82E7
S2E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln385
shll16 r3
cmp/hs r3,r1
bt ov386
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-112,r7
ov386:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-16,r7
ln385:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr385,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr385,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-44,r7
.align 2
g2_except_addr385: .long group_2_exception
bf_addr385: .long basefunction
! Opcodes 82E8 - 82EF
S2E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln387
shll16 r3
cmp/hs r3,r1
bt ov388
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov388:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln387:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr387,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr387,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr387: .long group_2_exception
bf_addr387: .long basefunction
! Opcodes 82F0 - 82F7
S2F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln389
shll16 r3
cmp/hs r3,r1
bt ov390
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-116,r7
ov390:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln389:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr389,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr389,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr389: .long group_2_exception
bf_addr389: .long basefunction
! Opcode 82F8
S2F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln391
shll16 r3
cmp/hs r3,r1
bt ov392
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov392:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln391:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr391,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr391,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr391: .long group_2_exception
bf_addr391: .long basefunction
! Opcode 82F9
S2F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln393
shll16 r3
cmp/hs r3,r1
bt ov394
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-118,r7
ov394:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-22,r7
ln393:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr393,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr393,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_addr393: .long group_2_exception
bf_addr393: .long basefunction
! Opcode 82FA
S2FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln395
shll16 r3
cmp/hs r3,r1
bt ov396
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov396:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln395:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr395,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr395,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr395: .long group_2_exception
bf_addr395: .long basefunction
! Opcode 82FB
S2FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln397
shll16 r3
cmp/hs r3,r1
bt ov398
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-116,r7
ov398:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln397:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr397,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr397,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr397: .long group_2_exception
bf_addr397: .long basefunction
! Opcode 82FC
S2FC:
mov.w @r6+,r3
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln399
shll16 r3
cmp/hs r3,r1
bt ov400
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov400:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln399:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr399,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr399,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr399: .long group_2_exception
bf_addr399: .long basefunction
! Opcodes 8300 - 8307
S300:
mov r3,r4
mov #4,r0
mov.b @(r0,r13),r3
mov r2,r0
mov.b @(r0,r13),r1
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd401
add #-6,r8
.nonibadd401:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop401
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop401:
exts.b r3,r3
mov r9,r8
mov #4,r0
mov.b r3,@(r0,r13)
or r4,r3
jmp @r10
add #-6,r7
! Opcodes 8308 - 830F
S308:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r2
mov.l @(36,r13),r4
add #-1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r1
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd402
add #-6,r8
.nonibadd402:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop402
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop402:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-18,r7
! Opcodes 8310 - 8317
S310:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8318 - 831F
S318:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8320 - 8327
S320:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8328 - 832F
S328:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 8330 - 8337
S330:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 8338
S338:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 8339
S339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8350 - 8357
S350:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8358 - 835F
S358:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8360 - 8367
S360:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8368 - 836F
S368:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 8370 - 8377
S370:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 8378
S378:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 8379
S379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8390 - 8397
S390:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8398 - 839F
S398:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 83A0 - 83A7
S3A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 83A8 - 83AF
S3A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 83B0 - 83B7
S3B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 83B8
S3B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 83B9
S3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 83C0 - 83C7
S3C0:
add r13,r2
mov.w @r2,r3
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln403
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck403
add #1,r1
tst r1,r1
bf ov404
ovcheck403:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-11,r7
ov404:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-16,r7
ln403:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr403,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr403,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_except_addr403: .long group_2_exception
bf_addr403: .long basefunction
! Opcodes 83D0 - 83D7
S3D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln405
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck405
add #1,r1
tst r1,r1
bf ov406
ovcheck405:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov406:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln405:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr405,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr405,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr405: .long group_2_exception
bf_addr405: .long basefunction
! Opcodes 83D8 - 83DF
S3D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln407
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck407
add #1,r1
tst r1,r1
bf ov408
ovcheck407:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov408:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln407:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr407,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr407,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr407: .long group_2_exception
bf_addr407: .long basefunction
! Opcodes 83E0 - 83E7
S3E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln409
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck409
add #1,r1
tst r1,r1
bf ov410
ovcheck409:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-17,r7
ov410:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-22,r7
ln409:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr409,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr409,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-44,r7
.align 2
g2_except_addr409: .long group_2_exception
bf_addr409: .long basefunction
! Opcodes 83E8 - 83EF
S3E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln411
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck411
add #1,r1
tst r1,r1
bf ov412
ovcheck411:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov412:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln411:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr411,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr411,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr411: .long group_2_exception
bf_addr411: .long basefunction
! Opcodes 83F0 - 83F7
S3F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln413
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck413
add #1,r1
tst r1,r1
bf ov414
ovcheck413:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-21,r7
ov414:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-26,r7
ln413:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr413,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr413,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr413: .long group_2_exception
bf_addr413: .long basefunction
! Opcode 83F8
S3F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln415
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck415
add #1,r1
tst r1,r1
bf ov416
ovcheck415:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov416:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln415:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr415,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr415,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr415: .long group_2_exception
bf_addr415: .long basefunction
! Opcode 83F9
S3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln417
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck417
add #1,r1
tst r1,r1
bf ov418
ovcheck417:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-23,r7
ov418:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-28,r7
ln417:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr417,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr417,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_addr417: .long group_2_exception
bf_addr417: .long basefunction
! Opcode 83FA
S3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln419
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck419
add #1,r1
tst r1,r1
bf ov420
ovcheck419:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov420:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln419:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr419,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr419,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr419: .long group_2_exception
bf_addr419: .long basefunction
! Opcode 83FB
S3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln421
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck421
add #1,r1
tst r1,r1
bf ov422
ovcheck421:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-21,r7
ov422:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-26,r7
ln421:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr421,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr421,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr421: .long group_2_exception
bf_addr421: .long basefunction
! Opcode 83FC
S3FC:
mov.w @r6+,r3
mov.l @(4,r13),r1
mov r3,r8
tst r8,r8
bt/s ln423
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck423
add #1,r1
tst r1,r1
bf ov424
ovcheck423:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(4,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov424:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln423:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr423,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr423,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr423: .long group_2_exception
bf_addr423: .long basefunction
! Opcodes 8400 - 8407
S400:
add r13,r2
mov.b @r2,r3
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8410 - 8417
S410:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8418 - 841F
S418:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8420 - 8427
S420:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8428 - 842F
S428:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8430 - 8437
S430:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8438
S438:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8439
S439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 843A
S43A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 843B
S43B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 843C
S43C:
mov.b @r6,r3
add #2,r6
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov #8,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8440 - 8447
S440:
add r13,r2
mov.w @r2,r3
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8450 - 8457
S450:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8458 - 845F
S458:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8460 - 8467
S460:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8468 - 846F
S468:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8470 - 8477
S470:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8478
S478:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8479
S479:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 847A
S47A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 847B
S47B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 847C
S47C:
mov.w @r6+,r3
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov #8,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8480 - 8487
S480:
add r13,r2
mov.l @r2,r3
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8490 - 8497
S490:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8498 - 849F
S498:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 84A0 - 84A7
S4A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 84A8 - 84AF
S4A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 84B0 - 84B7
S4B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 84B8
S4B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 84B9
S4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 84BA
S4BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 84BB
S4BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 84BC
S4BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(8,r13),r1
or r1,r3
mov.l r3,@(8,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 84C0 - 84C7
S4C0:
add r13,r2
mov.w @r2,r3
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln425
shll16 r3
cmp/hs r3,r1
bt ov426
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-106,r7
ov426:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-10,r7
ln425:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr425,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr425,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_except_addr425: .long group_2_exception
bf_addr425: .long basefunction
! Opcodes 84D0 - 84D7
S4D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln427
shll16 r3
cmp/hs r3,r1
bt ov428
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov428:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln427:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr427,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr427,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr427: .long group_2_exception
bf_addr427: .long basefunction
! Opcodes 84D8 - 84DF
S4D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln429
shll16 r3
cmp/hs r3,r1
bt ov430
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov430:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln429:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr429,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr429,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr429: .long group_2_exception
bf_addr429: .long basefunction
! Opcodes 84E0 - 84E7
S4E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln431
shll16 r3
cmp/hs r3,r1
bt ov432
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-112,r7
ov432:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-16,r7
ln431:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr431,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr431,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-44,r7
.align 2
g2_except_addr431: .long group_2_exception
bf_addr431: .long basefunction
! Opcodes 84E8 - 84EF
S4E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln433
shll16 r3
cmp/hs r3,r1
bt ov434
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov434:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln433:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr433,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr433,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr433: .long group_2_exception
bf_addr433: .long basefunction
! Opcodes 84F0 - 84F7
S4F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln435
shll16 r3
cmp/hs r3,r1
bt ov436
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-116,r7
ov436:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln435:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr435,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr435,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr435: .long group_2_exception
bf_addr435: .long basefunction
! Opcode 84F8
S4F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln437
shll16 r3
cmp/hs r3,r1
bt ov438
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov438:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln437:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr437,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr437,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr437: .long group_2_exception
bf_addr437: .long basefunction
! Opcode 84F9
S4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln439
shll16 r3
cmp/hs r3,r1
bt ov440
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-118,r7
ov440:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-22,r7
ln439:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr439,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr439,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_addr439: .long group_2_exception
bf_addr439: .long basefunction
! Opcode 84FA
S4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln441
shll16 r3
cmp/hs r3,r1
bt ov442
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-114,r7
ov442:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-18,r7
ln441:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr441,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr441,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr441: .long group_2_exception
bf_addr441: .long basefunction
! Opcode 84FB
S4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln443
shll16 r3
cmp/hs r3,r1
bt ov444
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-116,r7
ov444:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln443:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr443,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr443,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr443: .long group_2_exception
bf_addr443: .long basefunction
! Opcode 84FC
S4FC:
mov.w @r6+,r3
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln445
shll16 r3
cmp/hs r3,r1
bt ov446
mov r1,r0
div0u
.rept 16
div1 r3,r1
.endr
rotcl r1
extu.w r1,r3
mulu.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
jmp @r10
add #-110,r7
ov446:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-14,r7
ln445:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr445,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr445,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr445: .long group_2_exception
bf_addr445: .long basefunction
! Opcodes 8500 - 8507
S500:
mov r3,r4
mov #8,r0
mov.b @(r0,r13),r3
mov r2,r0
mov.b @(r0,r13),r1
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd447
add #-6,r8
.nonibadd447:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop447
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop447:
exts.b r3,r3
mov r9,r8
mov #8,r0
mov.b r3,@(r0,r13)
or r4,r3
jmp @r10
add #-6,r7
! Opcodes 8508 - 850F
S508:
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r2
mov.l @(40,r13),r4
add #-1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r1
mov #0x0F,r0
and r1,r0
mov #0x0F,r8
and r3,r8
cmp/pl r9
subc r0,r8
mov #9,r0
cmp/hi r0,r8
bf .nonibadd448
add #-6,r8
.nonibadd448:
mov r3,r0
and #0xF0,r0
mov r0,r3
mov r1,r0
and #0xF0,r0
sub r0,r3
add r8,r3
mov #0x99,r0
extu.b r0,r0
cmp/hi r0,r3
movt r9
bf .endop448
mov #0xA0,r0
extu.b r0,r0
add r0,r3
.endop448:
exts.b r3,r3
mov r9,r8
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
mov.l @r15+,r2
or r2,r3
jmp @r10
add #-18,r7
! Opcodes 8510 - 8517
S510:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8518 - 851F
S518:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8520 - 8527
S520:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8528 - 852F
S528:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 8530 - 8537
S530:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 8538
S538:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 8539
S539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8550 - 8557
S550:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8558 - 855F
S558:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8560 - 8567
S560:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8568 - 856F
S568:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 8570 - 8577
S570:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 8578
S578:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 8579
S579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w @(r0,r13),r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8590 - 8597
S590:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 8598 - 859F
S598:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-20,r7
! Opcodes 85A0 - 85A7
S5A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #0,r8
jmp @r10
add #-22,r7
! Opcodes 85A8 - 85AF
S5A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcodes 85B0 - 85B7
S5B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-26,r7
! Opcode 85B8
S5B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-24,r7
! Opcode 85B9
S5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #0,r8
jmp @r10
add #-28,r7
! Opcodes 85C0 - 85C7
S5C0:
add r13,r2
mov.w @r2,r3
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln449
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck449
add #1,r1
tst r1,r1
bf ov450
ovcheck449:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-11,r7
ov450:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-16,r7
ln449:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr449,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr449,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-38,r7
.align 2
g2_except_addr449: .long group_2_exception
bf_addr449: .long basefunction
! Opcodes 85D0 - 85D7
S5D0:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln451
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck451
add #1,r1
tst r1,r1
bf ov452
ovcheck451:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov452:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln451:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr451,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr451,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr451: .long group_2_exception
bf_addr451: .long basefunction
! Opcodes 85D8 - 85DF
S5D8:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln453
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck453
add #1,r1
tst r1,r1
bf ov454
ovcheck453:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov454:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln453:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr453,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr453,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr453: .long group_2_exception
bf_addr453: .long basefunction
! Opcodes 85E0 - 85E7
S5E0:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln455
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck455
add #1,r1
tst r1,r1
bf ov456
ovcheck455:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-17,r7
ov456:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-22,r7
ln455:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr455,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr455,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-44,r7
.align 2
g2_except_addr455: .long group_2_exception
bf_addr455: .long basefunction
! Opcodes 85E8 - 85EF
S5E8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln457
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck457
add #1,r1
tst r1,r1
bf ov458
ovcheck457:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov458:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln457:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr457,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr457,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr457: .long group_2_exception
bf_addr457: .long basefunction
! Opcodes 85F0 - 85F7
S5F0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln459
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck459
add #1,r1
tst r1,r1
bf ov460
ovcheck459:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-21,r7
ov460:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-26,r7
ln459:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr459,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr459,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr459: .long group_2_exception
bf_addr459: .long basefunction
! Opcode 85F8
S5F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln461
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck461
add #1,r1
tst r1,r1
bf ov462
ovcheck461:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov462:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln461:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr461,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr461,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr461: .long group_2_exception
bf_addr461: .long basefunction
! Opcode 85F9
S5F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln463
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck463
add #1,r1
tst r1,r1
bf ov464
ovcheck463:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-23,r7
ov464:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-28,r7
ln463:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr463,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr463,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-50,r7
.align 2
g2_except_addr463: .long group_2_exception
bf_addr463: .long basefunction
! Opcode 85FA
S5FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln465
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck465
add #1,r1
tst r1,r1
bf ov466
ovcheck465:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-19,r7
ov466:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-24,r7
ln465:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr465,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr465,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-46,r7
.align 2
g2_except_addr465: .long group_2_exception
bf_addr465: .long basefunction
! Opcode 85FB
S5FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln467
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck467
add #1,r1
tst r1,r1
bf ov468
ovcheck467:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-21,r7
ov468:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-26,r7
ln467:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr467,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr467,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-48,r7
.align 2
g2_except_addr467: .long group_2_exception
bf_addr467: .long basefunction
! Opcode 85FC
S5FC:
mov.w @r6+,r3
mov.l @(8,r13),r1
mov r3,r8
tst r8,r8
bt/s ln469
shll16 r3
mov r1,r0
mov #0,r2
rotl r0
subc r2,r1
rotr r0
div0s r3,r1
.rept 16
div1 r3,r1
.endr
exts.w r1,r3
rotcl r3
addc r2,r3
extu.w r3,r3
mov #-15,r2
shad r2,r1
tst r1,r1
bt/s ovcheck469
add #1,r1
tst r1,r1
bf ov470
ovcheck469:
muls.w r3,r8
sts macl,r8
sub r8,r0
shll16 r0
or r0,r3
mov.l r3,@(8,r13)
exts.w r3,r3
mov #0,r8
add #-128,r7
jmp @r10
add #-15,r7
ov470:
mov #0x2,r8
mov #-1,r3
jmp @r10
add #-20,r7
ln469:
mov #0xFC,r0
and r0,r8
mov.l g2_except_addr469,r0
jsr @r0
mov #0x14,r4
mov.l bf_addr469,r0
jsr @r0
nop
add r5,r6
jmp @r10
add #-42,r7
.align 2
g2_except_addr469: .long group_2_exception
bf_addr469: .long basefunction
! Opcodes 8600 - 8607
S600:
add r13,r2
mov.b @r2,r3
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8610 - 8617
S610:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8618 - 861F
S618:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
cmp/eq #28,r0
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8620 - 8627
S620:
mov r2,r0
mov.l @(r0,r14),r4
mov r2,r0
cmp/eq #28,r0
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8628 - 862F
S628:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8630 - 8637
S630:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8638
S638:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8639
S639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 863A
S63A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 863B
S63B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 863C
S63C:
mov.b @r6,r3
add #2,r6
mov #12,r0
mov.b @(r0,r13),r1
or r1,r3
mov #12,r0
mov.b r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8640 - 8647
S640:
add r13,r2
mov.w @r2,r3
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-4,r7
! Opcodes 8650 - 8657
S650:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8658 - 865F
S658:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8660 - 8667
S660:
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-10,r7
! Opcodes 8668 - 866F
S668:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcodes 8670 - 8677
S670:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 8678
S678:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 8679
S679:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcode 867A
S67A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-12,r7
! Opcode 867B
S67B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcode 867C
S67C:
mov.w @r6+,r3
mov #12,r0
mov.w @(r0,r13),r1
or r1,r3
mov #12,r0
mov.w r3,@(r0,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8680 - 8687
S680:
add r13,r2
mov.l @r2,r3
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-8,r7
! Opcodes 8690 - 8697
S690:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 8698 - 869F
S698:
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-14,r7
! Opcodes 86A0 - 86A7
S6A0:
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 86A8 - 86AF
S6A8:
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcodes 86B0 - 86B7
S6B0:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r2,r0
jsr @r4
mov.l @(r0,r14),r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 86B8
S6B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 86B9
S6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-22,r7
! Opcode 86BA
S6BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-18,r7
! Opcode 86BB
S6BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-20,r7
! Opcode 86BC
S6BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(12,r13),r1
or r1,r3
mov.l r3,@(12,r13)
mov #0,r8
jmp @r10
add #-16,r7
! Opcodes 86C0 - 86C7
S6C0:
add r13,r2
mov.w @r2,r3
mov r3,r8