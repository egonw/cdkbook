all: stereo.png

%.png : %.dot
	@echo "Processing " $<
	@dot -Tpng $< -o $@

