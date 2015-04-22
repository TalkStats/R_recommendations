####################
# Makefile for automated ms creation in various formats
####################

## Setup 
DATE= $(shell date +"%m-%d-%Y")
CV_DIR = .
BASENAME = recomenddocument
MASTER = $(CV_DIR)/README.Rmd
MD = $(CV_DIR)/$(BASENAME)_$(DATE).md
FINAL=$(CV_DIR)/README.md
PDF = $(CV_DIR)/$(BASENAME)_$(DATE).pdf


## functions
RNAME = cp '$<' '$@' 
PDOC = pandoc -s --toc --smart '$<' -o '$@'
KNIT = Rscript --vanilla -e "library(markdown,lib='~/R/lib');require(knitr,lib='~/R/lib'); knit('$<','$@')"
PDFLATEX = pdflatex -synctex=1 -interaction=nonstopmode '$<' '$@'
all: $(MD) $(PDF) $(FINAL)

#########################
## main markdownx
## $(OUTPUT):$(INPUT)
## 	: RULES

$(MD):$(MASTER)
	$(KNIT)

$(PDF):$(MD)
	$(PDOC)

$(FINAL):$(MD)
	$(RNAME)
