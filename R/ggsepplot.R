
# this is maybe better implemented under the hood as a sepplot geometry layer
# see
# https://ggplot2.tidyverse.org/articles/extending-ggplot2.html#inheriting-from-an-existing-geom
# also
# https://stackoverflow.com/questions/55811839/extending-ggplot2-with-a-custom-geometry-for-sf-objects
#


#' ggplot2 separation plot
#'
#' @param pred something
#' @param ... for methods
#'
#' @export
ggsepplot <- function(pred, ...) {

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggsepplot requires 'ggplot2' to work, please install it.")
  }

  UseMethod("ggsepplot", pred)
}

#' @export
ggsepplot.default <- function(pred, actual, ...) {
  # from http://www.peterhaschke.com/r/2013/04/22/SeparationPlot.html
  dat <- data.frame(pred = pred, actual = actual)
  dat$actual <- factor(dat$actual)
  dat <- dat[order(dat$pred), ]
  dat$position = 1:nrow(dat)

  col <- c(rgb(red = 254, green = 232, blue = 200, max = 255),
           rgb(red = 227, green = 74, blue = 51, max = 255))

  ggplot2::ggplot(dat, ggplot2::aes(x = position)) +
    ggplot2::geom_bar(ggplot2::aes(fill = actual, y = 1), stat = "identity", width = 1) +
    ggplot2::geom_step(ggplot2::aes(y = pred)) +
    ggplot2::scale_fill_manual(values = col) +
    ggplot2::scale_y_continuous("Y-hat\n", breaks = c(0, 0.25, 0.5, 0.75, 1.0)) +
    ggplot2::scale_x_continuous("", breaks = NULL) +
    ggplot2::theme(legend.position = "none",
                  panel.background = ggplot2::element_blank(),
                  panel.grid = ggplot2::element_blank())
}

#' @export
ggsepplot.glm <- function(pred, ...) {
  model <- pred
  stopifnot(model$family$family=="binomial")

  actual <- model$data[, all.vars(model$terms)[1]]
  phat <- predict(model, type = "response")

  ggsepplot(phat, actual)
}
