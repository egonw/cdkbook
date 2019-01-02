all: stereo.png crystal.png

%.png : %.dot
	@echo "Processing " $<
	@dot -Tpng $< -o $@

