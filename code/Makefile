CDKVERSION=2.0

CODEFILES: \
 $(shell groovy ../findScripts.groovy .. .out)

.PRECIOUS: %.groovy

all: allScriptsCompiled

CLASSPATH=cdk-${CDKVERSION}.jar:.

distclean: clean
	@rm -f *.md *.out *.bsh *.java *.groovy

clean:
	@rm -f *~ *.class allScriptsCompiled

allScriptsCompiled: ${CODEFILES}
	@touch allScriptsCompiled

%.groovy : %.groovyin md.*.template
	@echo "Processing " $<
	@groovy process $<

%.out: %.groovy
	@echo "doing $@..."
	@groovy -cp ${CLASSPATH} ${OPTIONS} -d $< | grep -v "net.sf.jnati.deploy." | groovy ../wrap.groovy >> $@
