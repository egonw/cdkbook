all: stereo.png crystal.png electronContainerInheritance.png biopolymer.png \
     strandmonomer.png descriptor.png descriptorResults.png rings.png

%.png : %.dot
	@echo "Processing " $<
	@dot -Tpng $< -o $@

