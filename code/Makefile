CDKVERSION=2.0

CODEFILES: \
 $(shell groovy ../findScripts.groovy .. .out)

all: allScriptsCompiled

CLASSPATH=cdk-${CDKVERSION}.jar:.

distclean: clean
	@rm -f *.md *.out *.bsh *.java *.groovy

clean:
	@rm -f *~ *.class allScriptsCompiled

allScriptsCompiled: ${CODEFILES}
	@touch allScriptsCompiled

%.groovy : %.groovyin
	@echo "Processing " $<
	@groovy process $<

%.out: %.groovy md.*.template 
	@echo "doing $@..."
	@groovy -cp ${CLASSPATH} ${OPTIONS} -d $< | grep -v "net.sf.jnati.deploy." | groovy ../wrap.groovy >> $@
