# Makefile for cweave, ctangle, plain TeX etc
CTANGLE = ctangle
CWEAVE = cweave
TEX = plain-ru
CFLAGS=-Wall -g
CFLAGS+=-I /usr/local/include
LDFLAGS=-L/usr/local/lib -largp 

all: linker.pdf link

linker.pdf: linker.ps
	gs -sDEVICE=pdfwrite -sOutputFile=linker.pdf -dBATCH -dNOPAUSE linker.ps

linker.ps: linker.dvi
	dvips -j0 linker.dvi -o

linker.dvi: linker.tex
	$(TEX) linker.tex

linker.tex: linker.w
	$(CWEAVE) linker.w

link: linker.c
	CC $(CFLAGS) $(LDFLAGS) linker.c -o link

linker.c: linker.w
	$(CTANGLE) linker.w

clean:
	-rm -Rf *.c *.o link
	-rm -Rf *.tex *.aux *.log *.toc *.idx *.scn *.dvi *.pdf *.ps


