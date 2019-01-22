CDKVERSION=`cat ../cdk.version`

CODEFILES: \
 $(shell groovy ../findScripts.groovy .. .out)

.PRECIOUS: %.java %.groovy

all: allScriptsCompiled scriptCount.tex

CLASSPATH=cdk-${CDKVERSION}.jar:.

distclean: clean
	@rm -f *.md *.out *.bsh *.java *.groovy

clean:
	@rm -f *~ *.class allScriptsCompiled

scriptCount.tex: SMILESFormatMatcher.class SimpleFingerprinter.class ${CODEFILES}
	@groovy ../findScripts.groovy .. .out | sort | uniq | wc -l > scriptCount.tex

allScriptsCompiled: ${CODEFILES}
	@touch allScriptsCompiled

%.groovy : %.groovyin source.*.template
	@echo "Processing " $<
	@groovy preprocess $<

%.class : %.java
	@javac -classpath ${CLASSPATH} $<

%.java : %.javap
	@echo "Processing " $<
	@groovy preprocess $<

%.out: %.class
	@echo "doing $@..."
	@java ${OPTIONS} -classpath ${CLASSPATH} `echo "$<" | sed -e "s/.class//"` > $@
	@groovy postprocess $<

%.out: %.groovy md.*.template
	@echo "doing $@..."
	@groovy -cp ${CLASSPATH} ${OPTIONS} -d $< | grep -v "net.sf.jnati.deploy." | groovy ../wrap.groovy > $@
	@if [ -e *.png ]; then mogrify -trim *.png ; fi
	@if [ -e *.png ]; then mv *.png ../images/generated/. ; fi
	@groovy postprocess $<
