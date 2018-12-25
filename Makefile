
all: code chapter3.md

clean:
	@rm chapter3.md

code:
	@cd code; make all

chapter3.md: chapter3.mdi createMarkdown.groovy
	@groovy createMarkdown.groovy chapter3.mdi > chapter3.md

install:
	@cp index.md ch*.md live/.
	@cp code/*.code.md live/code/.
