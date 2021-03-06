% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import.R
\name{df2genind}
\alias{df2genind}
\title{Convert a data.frame of allele data to a genind object.}
\usage{
df2genind(X, sep = NULL, ncode = NULL, ind.names = NULL,
  loc.names = NULL, pop = NULL, NA.char = "", ploidy = 2,
  type = c("codom", "PA"), strata = NULL, hierarchy = NULL)
}
\arguments{
\item{X}{a matrix or a data.frame containing allelle data only (see 
decription)}

\item{sep}{a character string separating alleles. See details.}

\item{ncode}{an optional integer giving the number of characters used for 
coding one genotype at one locus. If not provided, this is determined from 
data.}

\item{ind.names}{optinal, a vector giving the individuals names; if NULL,
taken from rownames of X. If factor or numeric, vector is converted to
character.}

\item{loc.names}{an optional character vector giving the markers names; if 
NULL, taken from colnames of X.}

\item{pop}{an optional factor giving the population of each individual.}

\item{NA.char}{a character string corresponding to missing allele (to be
treated as NA)}

\item{ploidy}{an integer indicating the degree of ploidy of the genotypes.}

\item{type}{a character string indicating the type of marker: 'codom' stands 
for 'codominant' (e.g. microstallites, allozymes); 'PA' stands for 
'presence/absence' markers (e.g. AFLP, RAPD).}

\item{strata}{an optional data frame that defines population stratifications 
for your samples. This is especially useful if you have a hierarchical or 
factorial sampling design.}

\item{hierarchy}{a hierarchical formula that explicitely defines hierarchical
levels in your strata. see \code{\link{hierarchy}} for details.}
}
\value{
an object of the class \linkS4class{genind} for \code{df2genind}; a 
  matrix of biallelic genotypes for \code{genind2df}
}
\description{
The function \code{df2genind} converts a data.frame (or a matrix) into a 
\linkS4class{genind} object. The data.frame must meet the following 
requirements:
\itemize{
\item genotypes are in row (one row per genotype)
\item markers/loci are in columns
\item each element is a string of characters coding alleles, ideally
separated by a character string (argument \code{sep}); if no separator is
used, the number of characters coding alleles must be indicated (argument
\code{ncode}).}
}
\details{
See \code{\link{genind2df}} to convert \linkS4class{genind} objects back to
such a data.frame.

=== Details for the \code{sep} argument ===\cr this character is directly 
used in reguar expressions like \code{gsub}, and thus require some characters
to be preceeded by double backslashes. For instance, "/" works but "|" must
be coded as "\\|".
}
\examples{

## simple example
df <- data.frame(locusA=c("11","11","12","32"),
locusB=c(NA,"34","55","15"),locusC=c("22","22","21","22"))
row.names(df) <- .genlab("genotype",4)
df

obj <- df2genind(df, ploidy=2, ncode=1)
obj
tab(obj)


## converting a genind as data.frame
genind2df(obj)
genind2df(obj, sep="/")

}
\author{
Thibaut Jombart \email{t.jombart@imperial.ac.uk}, Zhian N. Kamvar 
  \email{kamvarz@science.oregonstate.edu}
}
\seealso{
\code{\link{genind2df}}, \code{\link{import2genind}}, 
  \code{\link{read.genetix}}, \code{\link{read.fstat}}, 
  \code{\link{read.structure}}
}
\keyword{manip}

