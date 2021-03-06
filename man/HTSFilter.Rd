% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HTSFilter-methods.R
\name{HTSFilter}
\alias{HTSFilter}
\alias{HTSFilter-methods}
\alias{HTSFilter,matrix-method}
\alias{HTSFilter,data.frame-method}
\alias{HTSFilter,DGEList-method}
\alias{HTSFilter,DGEExact-method}
\alias{HTSFilter,DGEGLM-method}
\alias{HTSFilter,DGELRT-method}
\alias{HTSFilter,DESeqDataSet-method}
\title{Calculate data-based filtering threshold for replicated transcriptome sequencing data.}
\usage{
HTSFilter(x, ...)

\S4method{HTSFilter}{matrix}(
  x,
  conds,
  s.min = 1,
  s.max = 200,
  s.len = 100,
  loess.span = 0.3,
  normalization = c("TMM", "DESeq", "none"),
  plot = TRUE,
  plot.name = NA,
  parallel = FALSE,
  BPPARAM = bpparam()
)

\S4method{HTSFilter}{data.frame}(
  x,
  conds,
  s.min = 1,
  s.max = 200,
  s.len = 100,
  loess.span = 0.3,
  normalization = c("TMM", "DESeq", "none"),
  plot = TRUE,
  plot.name = NA,
  parallel = FALSE,
  BPPARAM = bpparam()
)

\S4method{HTSFilter}{DGEList}(
  x,
  s.min = 1,
  s.max = 200,
  s.len = 100,
  loess.span = 0.3,
  normalization = c("TMM", "DESeq", "pseudo.counts", "none"),
  plot = TRUE,
  plot.name = NA,
  parallel = FALSE,
  BPPARAM = bpparam(),
  conds
)

\S4method{HTSFilter}{DGEExact}(
  x,
  DGEList,
  s.min = 1,
  s.max = 200,
  s.len = 100,
  loess.span = 0.3,
  normalization = c("TMM", "DESeq", "pseudo.counts", "none"),
  plot = TRUE,
  plot.name = NA,
  parallel = FALSE,
  BPPARAM = bpparam(),
  conds
)

\S4method{HTSFilter}{DGEGLM}(
  x,
  s.min = 1,
  s.max = 200,
  s.len = 100,
  loess.span = 0.3,
  normalization = c("TMM", "DESeq", "none"),
  plot = TRUE,
  plot.name = NA,
  parallel = FALSE,
  BPPARAM = bpparam(),
  conds
)

\S4method{HTSFilter}{DGELRT}(
  x,
  DGEGLM,
  s.min = 1,
  s.max = 200,
  s.len = 100,
  loess.span = 0.3,
  normalization = c("TMM", "DESeq", "none"),
  plot = TRUE,
  plot.name = NA,
  parallel = FALSE,
  BPPARAM = bpparam(),
  conds
)

\S4method{HTSFilter}{DESeqDataSet}(
  x,
  s.min = 1,
  s.max = 200,
  s.len = 100,
  loess.span = 0.3,
  normalization = c("DESeq", "TMM", "none"),
  plot = TRUE,
  plot.name = NA,
  pAdjustMethod = "BH",
  parallel = FALSE,
  BPPARAM = bpparam(),
  conds
)
}
\arguments{
\item{x}{A numeric matrix or data.frame representing the counts of dimension (\emph{g} x \emph{n}),
for \emph{g} genes in \emph{n} samples, a \code{DGEList} object, a
\code{DGEExact} object, a \code{DGEGLM} object, a \code{DGELRT} object, or a \code{DESeqDataSet} object.}

\item{...}{Additional optional arguments}

\item{conds}{Vector of length \emph{n} identifying the experimental condition of each of the \emph{n} samples; required when sQuote(x)
is a numeric matrix. In the case of objects of class \code{DGEList},
\code{DGEExact}, \code{DGEGLM}, \code{DGELRT}, or \code{DESeqDataSet}, the design matrix is automatically}

\item{s.min}{Minimum value of filtering threshold to be considered, with default value equal to 1}

\item{s.max}{Maximum value of filtering threshold to be considered, with default value equal to 200}

\item{s.len}{Length of sequence of filtering thresholds to be considered (from \code{s.min} to \code{s.max})
for the calculation of the global similarity index}

\item{loess.span}{Span of the loess curve to be fitted to the filtering thresholds and corresponding global similarity
indices, with default value equal to 0.3}

\item{normalization}{Normalization method to be used to correct for differences in library sizes, with
choices  \dQuote{TMM} (Trimmed Mean of M-values), \dQuote{DESeq} (normalization method proposed in the
DESeq package), \dQuote{pseudo.counts} (pseudo-counts obtained via quantile-quantile normalization in
the edgeR package, only available for objects of class \code{DGEList} and \code{DGEExact}), and
\dQuote{none} (to be used only if user is certain no normalization is required, or if data have already
been pre-normalized by an alternative method)}

\item{plot}{If \dQuote{TRUE}, produce a plot of the calculated global similarity indices against the
filtering threshold with superimposed loess curve}

\item{plot.name}{If \code{plot} = \dQuote{TRUE}, the name of the PDF file to be saved to the current working directory.
If \code{plot.name} = NA, the plot is drawn in the current window.}

\item{parallel}{If \code{FALSE}, no parallelization. If \code{TRUE}, parallel
execution using BiocParallel (see next argument \code{BPPARAM}). A note on running
in parallel using BiocParallel: it may be advantageous to remove large, unneeded objects
from the current R environment before calling the function, as it is possible that R's
internal garbage collection will copy these files while running on worker nodes.}

\item{BPPARAM}{Optional parameter object passed internally to \code{bplapply} when
\code{parallel=TRUE}. If not specified, the parameters last registered with \code{register}
will be used.}

\item{DGEList}{Object of class DGEList, to be used when filtering objects of class DGEExact}

\item{DGEGLM}{Object of class DGEGLM, to be used when filtering objects of class DGELRT}

\item{pAdjustMethod}{The method used to adjust p-values, see \code{?p.adjust}}
}
\value{
\itemize{
 \item{filteredData }{An object of the same class as \code{x} containing the data that passed the filter}

 \item{on }{A binary vector of length \emph{g}, where 1 indicates a gene with normalized expression
  greater than the optimal filtering threshold \code{s.optimal} in at least one sample (irrespective of
  condition labels), and 0 indicates a gene with normalized expression less than or equal to the optimal
  filtering threshold in all samples}

 \item{s }{The optimal filtering threshold as identified by the global similarity index}

 \item{indexValues }{A matrix of dimension (\code{s.len} x 2) giving the tested filtering thersholds and the
 corresponding global similarity indices. Note that the threshold values are equally spaced on the \emph{log}
 scale, and thus unequally spaced on the count scale (i.e., we test more threshold values at very low levels
 of expression, and fewer at very high levels of expression).}

 \item{normFactor }{A vector of length \emph{n} giving the estimated library sizes estimated by the
  normalization method specified in \code{normalization}}

 \item{removedData }{A matrix containing the filtered data}
}
}
\description{
Calculate a data-based filtering threshold for replicated transcriptome
sequencing data through the pairwise Jaccard similarity index between pairs
of replicates within each experimental condition.
}
\details{
The Jaccard similarity index, which measures the overlap of two sets, is calculated as follows.
Given two binary vectors, each of length \emph{n}, we define the following values:
  \itemize{
      \item \emph{a} = the number of attributes with a value of 1 in both vectors
      \item \emph{b} = the number of attributes with a value of 1 in the first vector and 0 in the second
      \item \emph{c} = the number of attributes with a value of 0 in the first vector and 1 in the second
      \item \emph{d} = the number of attributes with a value of 0 in both vectors
        }
We note that all attributes fall into one of these four quantities, so \eqn{a+b+c+d=n}. Given these
quantities, we may calculate the Jaccard similarity index between the two vectors as follows:
  \deqn{J = \frac{a}{a+b+c}.}{J = a/(a+b+c).}
}
\examples{
library(Biobase)
data("sultan")
conds <- pData(sultan)$cell.line

########################################################################
## Matrix or data.frame
########################################################################

filter <- HTSFilter(exprs(sultan), conds, s.len=25, plot=FALSE)

########################################################################
## DGEExact
########################################################################

library(edgeR)
dge <- DGEList(counts=exprs(sultan), group=conds)
dge <- calcNormFactors(dge)
dge <- estimateCommonDisp(dge)
dge <- estimateTagwiseDisp(dge)
et <- exactTest(dge)
et <- HTSFilter(et, DGEList=dge, s.len=25, plot=FALSE)$filteredData
## topTags(et)


########################################################################
## DESeq2
########################################################################

library(DESeq2)
conds <- gsub(" ", ".", conds)
dds <- DESeqDataSetFromMatrix(countData = exprs(sultan),
                              colData = data.frame(cell.line = conds),
                              design = ~ cell.line)
## Not run:
##
## dds <- DESeq(dds)
## filter <- HTSFilter(dds, s.len=25, plot=FALSE)$filteredData
## class(filter)
## res <- results(filter, independentFiltering=FALSE)
}
\references{
R. Bourgon, R. Gentleman, and W. Huber. (2010) Independent filtering increases detection power for high-
throughput experiments. \emph{PNAS} \bold{107}(21):9546-9551.

P. Jaccard (1901). Etude comparative de la distribution
orale dans une portion des Alpes et des Jura.
\emph{Bulletin de la Societe Vaudoise des Sciences Naturelles}, \bold{37}:547-549.

A. Rau, M. Gallopin, G. Celeux, F. Jaffrezic (2013). Data-based filtering
for replicated high-throughput transcriptome sequencing experiments. \emph{Bioinformatics},
doi: 10.1093/bioinformatics/btt350.
}
\author{
Andrea Rau, Melina Gallopin, Gilles Celeux, and Florence Jaffrezic
}
\keyword{methods}
