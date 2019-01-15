all: stereo.png crystal.png electronContainerInheritance.png biopolymer.png \
     strandmonomer.png

%.png : %.dot
	@echo "Processing " $<
	@dot -Tpng $< -o $@

