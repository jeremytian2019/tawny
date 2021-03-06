\name{tawny-package}
\alias{tawny-package}
\alias{tawny}
\docType{package}
\title{
  Clean Covariance Matrices Using Random Matrix Theory and Shrinkage Estimators 
  for Portfolio Optimization
}
\description{
  Portfolio optimization typically requires an estimate of a covariance matrix
  of asset returns. There are many approaches for constructing such a 
  covariance matrix, some using the sample covariance matrix as a starting 
  point. This package provides implementations for two such methods: random 
  matrix theory and shrinkage estimation. Each method attempts to clean or 
  remove noise related to the sampling process from the sample covariance 
  matrix. Random matrix theory does this by using the known eigenvalue 
  distribution of a random matrix as the null hypothesis, scaling any 
  eigenvalues below a threshold to a lower bound, thus eliminating the noise
  related to the idiosyncratic noise of the matrix. Shrinkage estimation 
  shrinks the sample covariance matrix towards a so-called global average that
  theoretically represents a truer estimate of the covariance matrix. A single
  API is provided for generating asset weights based on the different 
  approaches.
}
\details{
\tabular{ll}{
Package: \tab tawny\cr
Type: \tab Package\cr
Version: \tab 2.1.7\cr
Date: \tab 2018-04-20\cr
License: \tab GPL-3\cr
}
There are a number of ways to use this package. At a high level, the estimation
techniques can be
applied to a portfolio and optimized portfolio weights are returned. This is
followed by calculation of basic portfolio statistics and comparison functions
to provide a quick, visual check to the results. It is possible to embark on
further study using other packages (e.g. PerformanceAnalytics). If a zoo object
already exists, then this is as simple as calling optimizePortfolio and 
specifying an appropriate (and built-in) function for generating a correlation
matrix.

In addition to these functions there are a number of convenience methods for
constructing simple portfolios for a given date range via quantmod. This 
includes getPortfolioReturns and ensure.

To get started using the package, the only requirement is to have a history of
returns for the assets in the portfolio. The length of the portfolio is the sum
of the window selected and the time frame to optimize against,

For people interested in studying the core behavior of Random Matrix Theory, theunderlying mp.* functions are available. These functions provide direct control
over eigenvalue density histogram plotting, theoretical distributions as
specified by Marcenko and Pastur, and optimization functions for fitting the
two. In most cases the functions are designed to be pluggable as they climb the
tree of abstraction, meaning that an arbitrary optimization function can be
plugged into the fitting function, and so on.

For people interested in studying shrinkage estimation techniques, these 
functions are primarily exposed as shrinkage.*.

NOTE: This is an alpha release and the high-level portfolio functions have not 
been fully ported nor tested.
. Use PerformanceAnalytics for performance analysis
. Clean up optimization workflow
. Clean up back testing vs single day workflows
}
\author{
Brian Lee Yung Rowe

Maintainer: Brian Lee Yung Rowe <r@zatonovo.com>
}
\references{
Gatheral, Jim. "Random Matrix Theory and Covariance Estimation." 3 Oct. 2008.
New York. 7 Oct. 2008
<http://www.math.nyu.edu/fellows\_fin\_math/gatheral/RandomMatrixCovariance2008.pdf>.

Potters, Marc; Bouchaud, Jean-Philippe; Laloux, Laurent.
"Financial Applications of Random Matrix Theory: Old Laces and New Pieces."
Jul. 2005. Paris. 10 Dec. 2008
<http://www.cfm.fr/papers/0507111.pdf>

Olivier Ledoit and Michael Wolf.
"Improved Estimation of the Covariance Matrix of Stock Returns With an 
Application to Portfolio Selection."
Oct. 2001. London. 12 Feb. 2009
<http://ideas.repec.org/a/eee/empfin/v10y2003i5p603-621.html>
}

\keyword{ package }
\keyword{ ts }
\seealso{ \code{\link{optimizePortfolio}}, \code{\link{denoise}}, \code{\link{getPortfolioReturns}} }
\examples{
\dontrun{
# Select a portfolio using 200 total observations
data(sp500.subset)
h <- sp500.subset
p <- TawnyPortfolio(h, 150)
b <- BenchmarkPortfolio('^GSPC', 150, nrow(h), end=end(h))

# Optimize using a window of length 200 (there will be 51 total iterations)
ws <- optimizePortfolio(p, RandomMatrixDenoiser())
rs <- PortfolioReturns(p, ws)
o <- zoo(cbind(portfolio=rs, benchmark=b$returns), index(rs))
charts.PerformanceSummary(o)


# Generate weights based on the constant correlation shrinkage estimator
ws <- optimizePortfolio(p, ShrinkageDenoiser())
rs <- PortfolioReturns(p, ws)
o <- zoo(cbind(portfolio=rs, benchmark=b$returns), index(rs))
charts.PerformanceSummary(o)
}

}
