####################
# Makefile for automated ms creation in various formats
####################

## Setup 
DATE= $(shell date +"%m-%d-%Y")
CV_DIR = .
BASENAME = recomenddocument
MASTER = $(CV_DIR)/README.Rmd
RENDERED=$(CV_DIR)/temp_$(DATE).md
MD = $(CV_DIR)/$(BASENAME)_$(DATE).md
FINAL=$(CV_DIR)/README.md
PDF = $(CV_DIR)/$(BASENAME)_$(DATE).pdf


## functions
RNAME = cp '$<' '$@' 
PDOC = pandoc -s --toc --smart '$<' -o '$@'
KNIT = Rscript --vanilla -e "library(markdown,lib='~/R/lib');require(knitr,lib='~/R/lib'); knit('$<','$@')"
PDFLATEX = pdflatex -synctex=1 -interaction=nonstopmode '$<' '$@'
all: $(RENDERED) $(MD) $(PDF) $(FINAL)

#########################
## main markdownx
## $(OUTPUT):$(INPUT)
## 	: RULES

$(RENDERED):$(MASTER)
	$(KNIT)

# TOC creation
$(MD):$(RENDERED)
	$(PDOC)

$(PDF):$(MD)
	$(PDOC)

$(FINAL):$(MD)
	$(RNAME)
