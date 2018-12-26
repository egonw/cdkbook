TARGETS := introduction.md cheminfo.md atomsbonds.md index.md

SUBDIRS := code

all: ${SUBDIRS} ${TARGETS}

clean:
	@rm -f ${TARGETS}

%.md : %.i.md createMarkdown.groovy references.dat
	@groovy createMarkdown.groovy $< > $@

install:
	@cp ${TARGETS} live/.
	@cp code/*.code.md live/code/.
	@cp images/*.png live/images/.

$(SUBDIRS):
	@$(MAKE) -C $@

