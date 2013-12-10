LINK_CMD=../linkbk -v
ASM_CMD=macro11 -ysl 32
MKDISK_CMD=mkdisk

.SUFFIXES: .o .asm

all:	abs simple abs2 overlay ovr2 save linker.img
	
.asm.o:
	${ASM_CMD} -o ${.TARGET} -l ${.PREFIX}.lst $<

abs:	abs.o
	${LINK_CMD} -o ${.TARGET} ${.ALLSRC} >${.TARGET}.log

simple:	simple.o
	${LINK_CMD} -o ${.TARGET} ${.ALLSRC} >${.TARGET}.log

abs2:	abs2.o
	${LINK_CMD} -o ${.TARGET} ${.ALLSRC} >${.TARGET}.log

overlay:	overlay.o 
	${LINK_CMD} -o ${.TARGET} ${.ALLSRC} >${.TARGET}.log

ovr2:	ovr2.o ovr2-part2.o 
	${LINK_CMD} -o ${.TARGET} ${.ALLSRC} >${.TARGET}.log

save:	save.o save-part2.o 
	${LINK_CMD} -o ${.TARGET} ${.ALLSRC} >${.TARGET}.log

ram-bios:	ram-bios.o
	${LINK_CMD} -o ${.TARGET} ${.ALLSRC} >${.TARGET}.log

linker.img: abs simple abs2 overlay ovr2 save overlay-SUBS.v ovr2-SUBS.v ram-bios
	${MKDISK_CMD} -o ${.TARGET} ${.ALLSRC}

