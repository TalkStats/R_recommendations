library(rmarkdown,lib='~/R/lib')
library(yaml,lib='~/R/lib')
library(knitr,lib='~/R/lib')
library(stringr,lib='~/R/lib')
library(formatR,lib='~/R/lib')


render("README.Rmd", "all") 

md_toc <- function(path = {(x <- dir())[tools::file_ext(x) == "md"]}){
    x <- suppressWarnings(readLines(path))
    inds <- 1:(which(!grepl("^\\s*-", x))[1] - 1)
    temp <- gsub("(^[ -]+)(.+)", "\\1", x[inds])
    content <- gsub("^[ -]+", "", x[inds])
    x[inds] <- sprintf("%s[%s](#%s)", temp, content, gsub("\\s", "-", tolower(content)))
    cat(paste(x, collapse = "\n"), file = path)
}

md_toc(path="./README.md")