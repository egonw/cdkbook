all: stereo.png crystal.png electronContainerInheritance.png biopolymer.png

%.png : %.dot
	@echo "Processing " $<
	@dot -Tpng $< -o $@

