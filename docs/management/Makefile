# commands:
#    'file'	 creates dvi/ps or pdf file, according to 'mode'
#    bib	 like all, but with updates bibtex info
#    clean	 removes unneede files

# LaTeX file name
source = forecast_spec

# ps or pdf
MODE   = pdf

DD     = $(source)-`date +"%Y%m%d"`.tgz


ifeq ($(MODE), pdf) 
   LATEX  = $(source)-pdf
   LATEX3 = $(LATEX)
else
   LATEX  = $(source)-dvi
   LATEX3 = $(source)-ps
endif

all: bib


$(source)-pdf:
	pdflatex $(source)

$(source)-dvi:
	latex $(source).tex

$(source)-ps:
	latex $(source).tex && dvips $(source).dvi -o tmptmp.ps && mv tmptmp.ps $(source).ps

pdf:
	pstopdf $(source).ps

bib:
	make $(LATEX)
	make bibtex
	#make bibsub
	make $(LATEX3)
	make $(LATEX3)

bibtex:
	bibtex $(source)


PHONY: clean

clean:
	rm -f *~ $(source).b?? *.bbl *.blg *.aux *.log $(source).dvi $(source).ps $(source).pdf $(source).toc

