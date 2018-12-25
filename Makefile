TARGETS= chapter3.md index.md

all: code ${TARGETS}

clean:
	@rm chapter3.md index.md

code:
	@cd code; make all

%.md : %.i.md createMarkdown.groovy
	@groovy createMarkdown.groovy $< > $@

install:
	@cp ${TARGETS} live/.
	@cp code/*.code.md live/code/.
