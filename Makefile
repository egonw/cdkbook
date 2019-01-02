SOURCES := io.i.md introduction.i.md cheminfo.i.md atomsbonds.i.md index.i.md \
  chemobject.i.md ctr.i.md stereo.i.md
TARGETS := io.md introduction.md cheminfo.md atomsbonds.md index.md \
  chemobject.md ctr.md stereo.md indexList.md

SUBDIRS := code

all: ${SUBDIRS} scriptcount.tex ${TARGETS}

clean:
	@rm -f ${TARGETS}

indexList.i.md: topics.tsv makeIndex.groovy
	@groovy makeIndex.groovy > indexList.i.md

topics.tsv: ${SOURCES} findTopics.groovy
	@groovy findTopics.groovy . | sort > topics.tsv

references.qids: findCitations.groovy
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

