SOURCES := io.i.md introduction.i.md cheminfo.i.md atomsbonds.i.md index.i.md \
  chemobject.i.md ctr.i.md stereo.i.md salts.i.md appatomtypes.i.md \
  migration.i.md unpairedelectrons.i.md protein.i.md reaction.i.md \
  substructure.i.md missing.i.md atomtype.i.md inchi.i.md builders.i.md \
  properties.i.md appisotopes.i.md descriptor.i.md graph.i.md \
  appmoldescs.i.md
TARGETS := io.md introduction.md cheminfo.md atomsbonds.md index.md \
  chemobject.md ctr.md stereo.md indexList.md salts.md appatomtypes.md \
  migration.md unpairedelectrons.md protein.md reaction.md \
  substructure.md missing.md atomtype.md inchi.md builders.md \
  properties.md appisotopes.md descriptor.md graph.md appmoldescs.md

SUBDIRS := code

all: cdk.version ${SUBDIRS} classinfo.tsv scriptcount.tex references.dat ${TARGETS}

clean:
	@rm -f ${TARGETS} scriptcount.tex cdk.version

cdk.version: README.md
	@grep "^\[Edition" README.md | cut -d' ' -f2 | cut -d'-' -f1 > cdk.version

minor.version: README.md
	@grep "^\[Edition" README.md | cut -d' ' -f2 | cut -d'-' -f2 | cut -d']' -f1 > minor.version

sections.txt: order.txt ${SOURCES}
	@groovy findSections.groovy > sections.txt

figures.txt: order.txt ${SOURCES}
	@groovy findFigures.groovy > figures.txt

toc.txt: order.txt ${SOURCES}
	@groovy makeToC.groovy > toc.txt

classinfo.tsv: classes.lst updateClassInfo.groovy
	@echo "Updating the class info TSV..."
	@groovy updateClassInfo.groovy  . > classinfo.tsv.new
	@mv classinfo.tsv.new classinfo.tsv

classes.lst: ${SOURCES} findClasses.groovy foo.sh
	@groovy findClasses.groovy . | sort | uniq > classes.lst
	@bash foo.sh  | sed -r 's/..\/cdk\/[^\/]*\/([^\/]*)\/src\/main\/java\/(.*)\/(.*)\.java/\3\t\2\t\1/' | grep "org/openscience" | grep -v "\.\./cdk" | sed 's/\//\./g' > classes.lst2
	@mv classes.lst2 classes.lst

indexList.i.md: topics.tsv makeIndex.groovy
	@groovy makeIndex.groovy > indexList.i.md

topics.tsv: ${SOURCES} findTopics.groovy
	@groovy findTopics.groovy . | sort > topics.tsv

references.qids: findCitations.groovy
	@groovy findCitations.groovy . | grep "^Q" | sort | uniq > references.qids

references.dat: references.qids references.js
	@nodejs references.js
	@cat references.extra.dat >> references.dat

scriptcount.tex: code/scriptCount.tex
	@mv code/scriptCount.tex scriptcount.tex

code/scriptCount.tex:
	@cd code; make scriptCount.tex

%.md : %.i.md createMarkdown.groovy
	@echo "Creating $@"
	@groovy createMarkdown.groovy $< > $@

install:
	@cp ${TARGETS} live/.
	@cp code/*.code.md live/code/.
	@cp images/*.png live/images/.
	@cp images/generated/*.png live/images/generated/.

$(SUBDIRS):
	@$(MAKE) -C $@

