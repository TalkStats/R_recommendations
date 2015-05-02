library(rmarkdown,lib='~/R/lib')
library(yaml,lib='~/R/lib')
library(knitr,lib='~/R/lib')
library(stringr,lib='~/R/lib')
library(formatR,lib='~/R/lib')

## pacman::p_load(rmarkdown, yaml, knitr, stringr, formatR)

render("README.Rmd", "all") 

md_toc <- function(path = {(x <- dir())[tools::file_ext(x) == "md"]}){
    
    ## Read in README.md
    x <- suppressWarnings(readLines(path))
    
    ## Locate the toc lines
    inds <- 1:(which(!grepl("^\\s*-", x))[1] - 1)
    
    ## Grab the beginning hypen + space part of the toc
    temp <- gsub("(^[ -]+)(.+)", "\\1", x[inds])
    
    ## Grab the toc content [remove the hypen + space part of the toc]
    content <- gsub("^[ -]+", "", x[inds])
    
    ## replace pace w/ -; remove invalid characters
    hrefs <- gsub("[;/?:@&=+$,]", "", gsub("\\s", "-", tolower(content)))
    
    ## Insert the hyperlinks back in to the toc 
    x[inds] <- sprintf("%s[%s](#%s)", temp, content, hrefs)
    
    ## Output the file as README.md
    cat(paste(x, collapse = "\n"), file = path)
}

md_toc(path="./README.md")