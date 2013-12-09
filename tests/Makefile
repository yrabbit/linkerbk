LINK_CMD=../linkbk -v
ASM_CMD=macro11 -ysl 32
.SUFFIXES: .o .asm

all:	abs simple abs2 overlay ovr2 save linker.img
	
.asm.o:
	${ASM_CMD} -o $@ -l $*.lst $<

abs:	abs.o
	${LINK_CMD} -o $@ $^ >$@.log

simple:	simple.o
	${LINK_CMD} -o $@ $^ >$@.log

abs2:	abs2.o
	${LINK_CMD} -o $@ $^ >$@.log

overlay:	overlay.o 
	${LINK_CMD} -o $@ $^ >$@.log

ovr2:	ovr2.o ovr2-part2.o 
	${LINK_CMD} -o $@ $^ >$@.log

save:	save.o save-part2.o 
	${LINK_CMD} -o $@ $^ >$@.log

linker.img: abs simple abs2 overlay ovr2 save overlay-SUBS.v ovr2-SUBS.v
	${MKDISK_CMD} -o $@ $^

