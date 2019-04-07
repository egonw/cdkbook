SOURCES := io.i.md introduction.i.md cheminfo.i.md atomsbonds.i.md index.i.md \
  chemobject.i.md ctr.i.md stereo.i.md salts.i.md appatomtypes.i.md \
  migration.i.md unpairedelectrons.i.md protein.i.md reaction.i.md \
  substructure.i.md missing.i.md atomtype.i.md inchi.i.md builders.i.md \
  properties.i.md appisotopes.i.md descriptor.i.md graph.i.md \
  appmoldescs.i.md protein.i.md appfileformats.i.md
TARGETS := io.md introduction.md cheminfo.md atomsbonds.md index.md \
  chemobject.md ctr.md stereo.md indexList.md salts.md appatomtypes.md \
  migration.md unpairedelectrons.md protein.md reaction.md \
  substructure.md missing.md atomtype.md inchi.md builders.md \
  properties.md appisotopes.md descriptor.md graph.md appmoldescs.md \
  appfileformats.md ioclasseslist.md
METAS := scriptcount.tex references.dat cdk.version minor.version \
  sections.txt figures.txt toc.txt indexList.i.md topics.tsv \
  ioclasseslist.md

SUBDIRS := code

all: cdk.version ${SUBDIRS} ${METAS} classinfo.tsv ${TARGETS}

clean:
	@rm -f ${TARGETS} ${METAS}

cdk.version: README.md
	@grep "^\[Edition" README.md | cut -d' ' -f2 | cut -d'-' -f1 > cdk.version

minor.version: README.md
	@grep "^\[Edition" README.md | cut -d' ' -f2 | cut -d'-' -f2 | cut -d']' -f1 > minor.version

sections.txt: order.txt ${SOURCES}
	@echo "Indexing the sections"
	@groovy findSections.groovy > sections.txt

figures.txt: order.txt ${SOURCES}
	@echo "Indexing the figures"
	@groovy findFigures.groovy > figures.txt

toc.txt: order.txt ${SOURCES}
	@echo "Making the ToC"
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
	@echo "Making the index"
	@groovy makeIndex.groovy > indexList.i.md

topics.tsv: ${SOURCES} findTopics.groovy
	@echo "Extracting the topics"
	@groovy findTopics.groovy . | sort > topics.tsv

references.qids: findCitations.groovy
	@echo "Finding the citations"
	@groovy findCitations.groovy . | grep "^Q" | sort | uniq > references.qids

references.dat: references.qids references.js references.extra.dat
	@nodejs references.js
	@cat references.extra.dat >> references.dat

scriptcount.tex: code/scriptCount.tex
	@mv code/scriptCount.tex scriptcount.tex

code/scriptCount.tex:
	@cd code; make scriptCount.tex

%.md : %.i.md createMarkdown.groovy references.dat
	@echo "Creating $@"
	@groovy createMarkdown.groovy $< > $@

install:
	@cp ${TARGETS} live/.
	@cp code/*.code.md live/code/.
	@cp images/*.png live/images/.
	@cp images/generated/*.png live/images/generated/.

$(SUBDIRS):
	@$(MAKE) -C $@

