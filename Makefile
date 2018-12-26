TARGETS := io.md introduction.md cheminfo.md atomsbonds.md index.md

SUBDIRS := code

all: ${SUBDIRS} scriptcount.tex ${TARGETS}

clean:
	@rm -f ${TARGETS}

scriptcount.tex: code/scriptCount.tex
	@mv code/scriptCount.tex scriptcount.tex

code/scriptCount.tex:
	@cd code; make scriptCount.tex

%.md : %.i.md createMarkdown.groovy references.dat
	@groovy createMarkdown.groovy $< > $@

install:
	@cp ${TARGETS} live/.
	@cp code/*.code.md live/code/.
	@cp images/*.png live/images/.

$(SUBDIRS):
	@$(MAKE) -C $@

