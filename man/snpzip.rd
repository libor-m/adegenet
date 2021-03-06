\encoding{UTF-8}
\name{snpzip}
\alias{snpzip}
\title{Identification of structural SNPs}
\description{
  The function \code{snpzip} identifies the set of alleles which contribute most
  significantly to phenotypic structure.
  
  This procedure uses Discriminant Analysis of Principal Components (DAPC)
  to quantify the contribution of individual alleles to between-population
  structure. Then, defining contribution to DAPC as the measure of distance
  between alleles, hierarchical clustering is used to identify two groups
  of alleles: structural SNPs and non-structural SNPs.
}
\usage{
  snpzip(snps, y, plot = TRUE, xval.plot = FALSE, loading.plot = FALSE,
         method = c("complete", "single", "average", "centroid", 
                    "mcquitty", "median", "ward"), \dots)
}
\arguments{
  \item{snps}{a snps \code{matrix} used as input of DAPC.}
  \item{y}{either a \code{factor} indicating the group membership of individuals, 
           or a dapc object.}
  \item{plot}{a \code{logical} indicating whether a graphical representation of the 
              DAPC results should be displayed.}
  \item{xval.plot}{a \code{logical} indicating whether the results of the 
                   cross-validation step should be displayed (iff \code{y} is a factor).}
  \item{loading.plot}{a \code{logical} indicating whether a loading.plot displaying 
                      the SNP selection threshold should be displayed.}
  \item{method}{the clustering method to be used. This should be 
                (an unambiguous abbreviation of) one of \code{"complete", "single", "average", 
                                                              "centroid", "mcquitty", "median",} or \code{"ward"}.} 
  \item{\dots}{further arguments.}
  
}

\details{
  \code{snpzip} provides an objective procedure to delineate between structural 
  and non-structural SNPs identified by Discriminant Analysis of Principal Components 
  (DAPC, Jombart et al. 2010). 
  \code{snpzip} precedes the multivariate analysis with a cross-validation step 
  to ensure that the subsequent DAPC is performed optimally.
  The contributions of alleles to the DAPC are then submitted to \code{hclust}, 
  where they define a distance matrix upon which hierarchical clustering is carried out.
  To complete the procedure, \code{snpzip} uses \code{cutree} to automatically 
  subdivide the set of SNPs fed into the analysis into two groups: 
    those which contribute significantly to the phenotypic structure of interest, 
  and those which do not.   
}

\value{
  A \code{list} with four items if \code{y} is a factor, or two items if
  \code{y} is a dapc object: 
    The first cites the number of principal components (PCs) of PCA retained in the DAPC. 
  
  The second item is an embedded list which
  first indicates the number of structural and non-structural SNPs identified by 
  \code{snpzip}, second provides a list of the structuring alleles, third
  gives the names of the selected alleles, and fourth details the 
  contributions of these structuring alleles to the DAPC.
  
  The optional third item provides measures of discrimination success both overall 
  and by group.
  
  The optional fourth item contains the dapc object generated if \code{y} was a factor.
  
  
  If \code{plot=TRUE}, a scatter plot will provide a visualization of the DAPC results.
  
  If \code{xval.plot=TRUE}, the results of the cross-validation step will be displayed 
  as an \code{array} of the format generated by xvalDapc, and a scatter plot of 
  the results of cross-validation will be provided.   
  
  If \code{loading.plot=TRUE}, a loading plot will be generated to show the 
  contributions of alleles to the DAPC, and the SNP selection threshold will be indicated.
  If the number of Discriminant Axes (\code{n.da}) in the DAPC is greater than 1, 
  \code{loading.plot=TRUE} will generate one loading plot for each discriminant axis.
}

\references{
  Jombart T, Devillard S and Balloux F (2010) Discriminant analysis of principal 
  components: a new method for the analysis of genetically structured populations. 
  BMC Genetics11:94. doi:10.1186/1471-2156-11-94
}

\author{ Caitlin Collins \email{caitlin.collins12@imperial.ac.uk} }
\examples{
  \dontrun{
    simpop <- glSim(100, 10000, n.snp.struc = 10, grp.size = c(0.3,0.7), 
                    LD = FALSE, alpha = 0.4, k = 4)
    snps <- as.matrix(simpop)
    phen <- simpop@pop
    
    outcome <- snpzip(snps, phen, method = "centroid")
    outcome
  }
  \dontrun{
    simpop <- glSim(100, 10000, n.snp.struc = 10, grp.size = c(0.3,0.7), 
                    LD = FALSE, alpha = 0.4, k = 4)
    snps <- as.matrix(simpop)
    phen <- simpop@pop
    
    dapc1 <- dapc(snps, phen, n.da = 1, n.pca = 30)
    
    features <- snpzip(dapc1, loading.plot = TRUE, method = "average")
    features
  }
}
\keyword{multivariate}