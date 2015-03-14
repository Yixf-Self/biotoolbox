_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
get\_bam\_seq\_stats.pl

A script to report the alignment sequence nucleotide frequencies.

## SYNOPSIS ##
get\_bam\_seq\_stats.pl <file.bam>

```
  Options:
  --in <file.bam>
  --out <filename>
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in <file.bam>


> Specify the file name of a binary Bam file of alignments as  described for Samtools. It will be automatically indexed if  necessary.

> 
--out <filename>


> Optionally specify the base name of the output file. The default is to use  input base name. The output file names are appended with '.seq\_stats.txt'.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation

> 
## DESCRIPTION ##
This program will generate some statistics about the alignment  sequences associated with a Bam file. This is using the the  query sequence reported in the Bam file, not the genomic  sequence or alignment. Only aligned sequences are analyzed.

The number and fraction of total for each length of the query  sequences are reported. Additionally, the nucleotide composition  for each position in the query sequences are also reported in  a table, which should be suitable for generating a sequence logo,  if desired.

The input file must be a BAM file as described by the Samtools  project (http://samtools.sourceforge.net).

## AUTHOR ##
```
 Timothy J. Parnell, PhD
 Dept of Oncological Sciences
 Huntsman Cancer Institute
 University of Utah
 Salt Lake City, UT, 84112
```
This package is free software; you can redistribute it and/or modify it under the terms of the GPL (either version 1, or at your option, any later version) or the Artistic License 2.0.
