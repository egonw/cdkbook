TARGETS := io.md introduction.md cheminfo.md atomsbonds.md index.md chemobject.md

SUBDIRS := code

all: ${SUBDIRS} scriptcount.tex references.dat ${TARGETS}

clean:
	@rm -f ${TARGETS}

references.qids: findCitations.groovy *.i.md
	@groovy findCitations.groovy . | grep "^Q" | sort | uniq > references.qids

references.dat: references.qids
	@nodejs references.js

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
	@cp images/generated/*.png live/images/generated/.

$(SUBDIRS):
	@$(MAKE) -C $@

