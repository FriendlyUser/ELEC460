ALL_FIGURE_NAMES=$(shell cat ELEC460Notes.figlist)
ALL_FIGURES=$(ALL_FIGURE_NAMES:%=%.pdf)

allimages: $(ALL_FIGURES)
	@echo All images exist now. Use make -B to re-generate them.

FORCEREMAKE:

include $(ALL_FIGURE_NAMES:%=%.dep)

%.dep:
	mkdir -p "$(dir $@)"
	touch "$@" # will be filled later.


ALL_FIGURES_png=$(ALL_FIGURE_NAMES:%=%.png)

allimagespng: $(ALL_FIGURES_png)
	@echo All png images exist now. Use make -B to re-generate them.

ELEC460Notes-figure0.pdf: 
	pdflatex -halt-on-error -interaction=batchmode -jobname "ELEC460Notes-figure0" "\def\tikzexternalrealjob{ELEC460Notes}\input{ELEC460Notes}"

ELEC460Notes-figure0.png: ELEC460Notes-figure0.pdf
	convert -density 300 "ELEC460Notes-figure0.pdf" "ELEC460Notes-figure0.png"

ELEC460Notes-figure0.pdf: ELEC460Notes-figure0.md5
ELEC460Notes-figure1.pdf: 
	pdflatex -halt-on-error -interaction=batchmode -jobname "ELEC460Notes-figure1" "\def\tikzexternalrealjob{ELEC460Notes}\input{ELEC460Notes}"

ELEC460Notes-figure1.png: ELEC460Notes-figure1.pdf
	convert -density 300 "ELEC460Notes-figure1.pdf" "ELEC460Notes-figure1.png"

ELEC460Notes-figure1.pdf: ELEC460Notes-figure1.md5
ELEC460Notes-figure2.pdf: 
	pdflatex -halt-on-error -interaction=batchmode -jobname "ELEC460Notes-figure2" "\def\tikzexternalrealjob{ELEC460Notes}\input{ELEC460Notes}"

ELEC460Notes-figure2.png: ELEC460Notes-figure2.pdf
	convert -density 300 "ELEC460Notes-figure2.pdf" "ELEC460Notes-figure2.png"

ELEC460Notes-figure2.pdf: ELEC460Notes-figure2.md5
ELEC460Notes-figure3.pdf: 
	pdflatex -halt-on-error -interaction=batchmode -jobname "ELEC460Notes-figure3" "\def\tikzexternalrealjob{ELEC460Notes}\input{ELEC460Notes}"

ELEC460Notes-figure3.png: ELEC460Notes-figure3.pdf
	convert -density 300 "ELEC460Notes-figure3.pdf" "ELEC460Notes-figure3.png"

ELEC460Notes-figure3.pdf: ELEC460Notes-figure3.md5
ELEC460Notes-figure4.pdf: 
	pdflatex -halt-on-error -interaction=batchmode -jobname "ELEC460Notes-figure4" "\def\tikzexternalrealjob{ELEC460Notes}\input{ELEC460Notes}"

ELEC460Notes-figure4.png: ELEC460Notes-figure4.pdf
	convert -density 300 "ELEC460Notes-figure4.pdf" "ELEC460Notes-figure4.png"

ELEC460Notes-figure4.pdf: ELEC460Notes-figure4.md5
ELEC460Notes-figure5.pdf: 
	pdflatex -halt-on-error -interaction=batchmode -jobname "ELEC460Notes-figure5" "\def\tikzexternalrealjob{ELEC460Notes}\input{ELEC460Notes}"

ELEC460Notes-figure5.png: ELEC460Notes-figure5.pdf
	convert -density 300 "ELEC460Notes-figure5.pdf" "ELEC460Notes-figure5.png"

ELEC460Notes-figure5.pdf: ELEC460Notes-figure5.md5
ELEC460Notes-figure6.pdf: 
	pdflatex -halt-on-error -interaction=batchmode -jobname "ELEC460Notes-figure6" "\def\tikzexternalrealjob{ELEC460Notes}\input{ELEC460Notes}"

ELEC460Notes-figure6.png: ELEC460Notes-figure6.pdf
	convert -density 300 "ELEC460Notes-figure6.pdf" "ELEC460Notes-figure6.png"

ELEC460Notes-figure6.pdf: ELEC460Notes-figure6.md5
