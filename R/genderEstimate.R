#' Convert names into features
#' @param x data frame where
#'   name: kanji name
#'   yomi: hiragana
#' @param levels a vector of usable kanji&kana characters
#' @return 13-dimensional features
#' @importFrom stringr str_split
as_feature <- function(x,levels) {
  res <- matrix(1,nrow=nrow(x),ncol=13)
  for (i in 1:nrow(x)) {
    cc <- stringr::str_split(x$name[i],"")[[1]]
    N <- length(cc)
    if (N > 5) N <- 5
    for (j in 1:N) {
      res[i,j] <- as.integer(factor(cc[j],levels=levels))
    }
    cc <- stringr::str_split(x$yomi[i],"")[[1]]
    N <- length(cc)
    if (N > 8) N <- 8
    for (j in 1:N) {
      res[i,j+5] <- as.integer(factor(cc[j],levels=levels))
    }
  }
  for (i in 1:13) {
    res[is.na(res[,i]),i] <- 1
  }
  res
}

#' Estimate Gender from kanji and kana of the name
#' @param nm a vector of kanji name
#' @param yomi a vector of hiragana name
#' @return a vector of probabilities of the names to be male names
#' @export
genderEstimate <- function(nm,yomi) {
  if (length(nm) != length(yomi)) {
    stop("Length of name should be the same as the length of yomi")
  }
  x <- data.frame(
    name=nm,
    yomi=yomi
  )
  feat <- as_feature(x,jkanji)
  predict(genderModel,feat)
}

