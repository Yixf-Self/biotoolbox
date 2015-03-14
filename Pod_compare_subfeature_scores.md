_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
compare\_subfeature\_scores.pl

A script to compare the scores between one or more subfeatures.

## SYNOPSIS ##
compare\_subfeature\_scores.pl --in <filename> --out <filename>

```
  Options:
  --in <filename>
  --out <filename> 
  --parent <index>
  --subfeature <index>
  --score <index>
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in <filename>


> Specify the input file. It should be a tab-delimited text file with  headers. At least three columns must be present: the name of the  parent (gene) feature, the name of subfeature (transcript) and the  score. The file may be compressed with gzip.

> 
--out <filename>


> Specify the output filename.

> 
--parent <index>


> Optionally specify the index column for the parent or gene name. If  not specified, the program will interactively present a list of columns  to choose from.

> 
--subfeature <index>


> Optionally specify the index column for the subfeature or transcript  name. If not specified, the program will interactively present a list  of columns to choose from.

> 
--score <index>


> Optionally specify the index column for the score to compare. If  not specified, the program will interactively present a list of columns  to choose from.

> 
--gz


> Specify whether (or not) the output file should be compressed with gzip.

> 
--version


> Print the version number.

> 
--help


> Display this POD documentation.

> 
## DESCRIPTION ##
This program will compare the scores of all the subfeatures of a parent  feature. For example, comparing RNA expression of all of the alternative  transcripts from a gene. As input, it expects a tab-delimited text file  with at least three columns: the name of the parent (e.g. gene) feature  (not expected to be unique in the file), the name of the subfeature (e.g.  transcript; must be unique with respect to each parent feature), and a  score for each subfeature. Such a file may be generated using the  biotoolbox script [get\_gene\_regions.pl](Pod_get_gene_regions_pl.md) followed by [get\_datasets.pl](Pod_get_datasets_pl.md).

The program will output a new file. Each line will represent one  parent feature. The columns include the parent feature name, number of  subfeatures, the minimum and maximum subfeature names and scores, and  the range of scores.

## AUTHOR ##
```
 Timothy J. Parnell, PhD
 Howard Hughes Medical Institute
 Dept of Oncological Sciences
 Huntsman Cancer Institute
 University of Utah
 Salt Lake City, UT, 84112
```
This package is free software; you can redistribute it and/or modify it under the terms of the GPL (either version 1, or at your option, any later version) or the Artistic License 2.0.
