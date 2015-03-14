_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
bin\_genomic\_data.pl

A script to bin genomic data into windows.

## SYNOPSIS ##
```
 bin_genomic_data.pl --data <filename> --in <filename> --method [method]
```
```
 bin_genomic_data.pl --data <filename> --new --win <integer> --db <db_name>
     --out <filename> --method [method]
```
```
  Options:
  --data <filename>
  --in <filename>
  --new
  --method [count | mean | median |sum]
  --out <filename>
  --db <database_name>
  --win <integer>
  --step <integer>
  --paired
  --span
  --midpoint
  --shift <integer>
  --interpolate
  --log
  --gff
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--data <filename>


> Specify the source genomic data file containing the datapoints to be  binned. Supported files include .gff, .bed, , .wig, .sgr, and .bam files.  Text files may be gzipped.

> 
--in <filename>


> Specify the filename of an existing data table of genomic bins or intervals.  It may be generated using this program or _get\_datasets.pl_. A Bed file  may be acceptable. Required unless `--new` is provided. The file may be  gzip compressed.

> 
--new


> Indicate that a new data file should be generated. Required unless `--in`  is used.

> 
--method `[`count | mean | median |sum`]`


> Indicate which method should be used to collect the binned data.  Acceptable values include:

> 
```
 - count         Count the number of unique features in the bin.
 - mean          Take the mean score of features in the bin.
 - median        Take the median score of features in the bin.
 - sum           Sum the scores of features in the bin
```
--out <filename>


> Specify the output file name. Required if generating a new binned  data file, otherwise if an input file was specified it will be  overwritten.

> 
--db <database\_name>


> Specify a database. This is used only to retrieve chromosome  information to generate genomic bins. Required if --new is used.

> 
--win <integer>


> Specify the genomic bin window size in bp. Required if --new is used.

> 
--step <integer>


> Specify the step size for moving the window when generating bins.  The default is to equal the window size.

> 
--paired


> Indicate that the data bam file consists of paired-end alignments  rather than single-end alignments.

> 
--span


> Assign feature value (or count) at each genomic bin across the  feature. This is dependent on the metadata step value when the  genomic bins were generated.

> 
--midpoint


> Assign the the feature value (or count) at the feature's midpoint  rather than the default feature's start point.

> 
--shift <integer>


> For stranded single-end alignments from a bam data file, the start  position may be shifted in the 3' direction by the indicated  number of bp. This is to account for ChIP-Seq data where the peak  of tag counts is offset from the actual center of the sequenced  fragments. Use a shift value of 1/2 the mean fragment length of the  sequencing library.

> 
--interpolate


> Optionally interpolate missing bin values from flanking bins.

> 
--log


> Flag to indicate that source data is log2, and to calculate  accordingly and report as log2 data.

> 
--gff


> Write a new gff output file instead of a normal tim data file.

> 
--gz


> Compress the output file through gzip.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation.

> 
## DESCRIPTION ##
This program will convert genomic data into genomic binned data. The genomic  bins are generated from the indicated database as segments of the genome of  the specified window size. The step size may be optionally specified, or  defaults to the window size. The source data may be collected from multiple  sources, including GFF, BED, BAM, WIG, or SGR files. The data may be  collected in one of two ways.

First, the program can enumerate (or count) features which overlap with a  genomic bin. Sequence tag (BAM file) alignments (both single- and  paired-end), BED, and GFF features may be counted. The feature start point,  or optionally the midpoint, is used to record the feature. Alternatively, the  counts may be enumerated across the entire span of the feature when using  small (single bp) bins.

Second, the program can statistically combine the scores (values) of features that overlap each genomic bin. Feature scores may be collected from GFF, BED,  WIG, or SGR files. Either the mean, median, or sum value can be recorded  for the genomic bin.

Genomic bins lacking a score may be interpolated from neighboring bins. Up to four consecutive non-value bins may interpolated from neighboring bins that contain values.

The program reads/writes a data file compatable with the 'get\_datasets.pl'  program. It can optionally write a new GFF file based on the genomic binned data.

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
