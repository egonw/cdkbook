all: stereo.png crystal.png electronContainerInheritance.png

%.png : %.dot
	@echo "Processing " $<
	@dot -Tpng $< -o $@

