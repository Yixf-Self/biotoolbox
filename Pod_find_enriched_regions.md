_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
find\_enriched\_regions.pl

A script to find enriched regions in a dataset using a simple threshold.

## SYNOPSIS ##
```
 find_enriched_regions.pl --db <db_name> [--options]
```
```
 find_enriched_regions.pl --data <file> [--options]
```
```
  Options:
  --db <name | filename>
  --ddb <name | filename>
  --data <dataset | filename>
  --out <filename>
  --win <integer>
  --step <integer>
  --tol <integer>
  --thresh <number>
  --sd <number>
  --method [mean|median|sum]
  --value [score|count|length]
  --strand [f|r]
  --deplete
  --trim
  --min <integer>
  --sort
  --feat
  --log
  --genes
  --gff
  --gz
  --cpu <integer>
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--db <name>


> Specify the name of a `Bio::DB::SeqFeature::Store` annotation database  from which gene or feature annotation may be derived. A database is  required for generating new data files with features. For more information  about using annotation databases,  see <https://code.google.com/p/biotoolbox/wiki/WorkingWithDatabases>.

> 
--ddb <name>


> When data scores are present in a separate database from annotation, then specify the second data-specific database. The same options  apply as --db.

> 
--data <dataset | filename>


> Specify the feature type or primary\_tag of the dataset within the  database from which to collect the scores. If not specified, then  the data set may be chosen interactively from a presented list.

> 
> Alternatively, the name of a single data file may be provided.  Supported file types include BigWig (.bw), BigBed (.bb), or  single-end Bam (.bam). The file may be local or remote.

> 
--out <filename>


> Specify the output file name. If not specified, then it will be  automatically generated from dataset, window, step, and threshold  values.

> 
--win <integer>


> Specify the genomic bin window size in bp. If not specified,  then the default window size is retrieved from the biotoolbox.cfg  configuration file. Default is 500 bp.

> 
--step <integer>


> Specify the step size for moving the window. Default value is  equal to the window size.

> 
--tol <integer>


> Specify the tolerance distance when merging windows together.  Windows not actually overlapping but within this tolerance  distance will actually be merged. Default value is 1/2 the  window size.

> 
--thresh <number>


> Specify the window score threshold explicitly rather than calculating a threshold based on standard deviations from the mean.

> 
--sd <number>


> Specify the multiple of standard deviations above the mean as a window score threshold. Default is 1.5 standard deviations. Be  quite careful with this method as it attempts to pull all of the  datapoints out of the database to calculate the mean and  standard deviation - which may be acceptable for limited tiling  microarrays but not acceptable for next generation sequencing  data with single bp resolution.

> 
--method `[`mean|median|sum`]`


> Specify the method for combining score values within each window  when determining whether the window exceeds the threshold. Default method is mean.

> 
--value `[`score|count|length`]`


> Specify the type of value to collect from the dataset. The  default value type is score.

> 
> --strand `[`f|r`]`

> 
> Optionally specify a specific strand from which to restrict the  data collection. This requires that the dataset supports  stranded data collection (GFF3, Bam, bigBed, BigWigSet).  Default is to collect from both strands.

> 
--deplete


> Specify whether depleted regions should be reported instead.  For example, windows whose scores are 1.5 standard deviations  below the mean, rather than above.

> 
--trim


> Indicate that the merged windows should be trimmed of below  threshold scores on the ends of the window. Normally when windows  are merged, there may be some data points on the ends of the  windows whose scores don't actually pass the threshold, but were  included because the entire window mean (or median) exceeded  the threshold. This step removes those data points. The default  behavior is false.

> 
--min <integer>


> Set the minimum window size in bp when trimming the merged windows.  The default value is equal to the search window size.

> 
--sort


> Indicate that the regions should be sorted by their score.  Sort order is decreasing for enriched regions and increasing  for depleted regions. Default is false (they should be  ordered mostly by coordinate).

> 
--feat


> Indicate that features overlapping the windows should be  identified. The default behavior is false.

> 
--genes


> Write out a text file containing a list of the found overlapping genes.

> 
--gff


> Indicate that a GFF version 3 file should be written out in addition to the data text file.

> 
--log


> Flag to indicate that source data is log2, and to calculate  accordingly and report as log2 data.

> 
--gz


> Compress the output file through gzip.

> 
--cpu <integer>


> Specify the number of CPU cores to execute in parallel. This requires  the installation of Parallel::ForkManager. With support enabled, the  default is 2. Disable multi-threaded execution by setting to 1.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation.

> 
## DESCRIPTION ##
This program will search for regions in the genome that are enriched for a  particular data set. It walks through each chromosome using a  window of specified size (default 500 bp) and specified step size (default  same as window). Data scores within a window that exceed a determined threshold will be noted. Adjoining windows (within a specific tolerance, default is  1/2 of window size) are merged. The windows may be optionally trimmed  of flanking below-threshold positions.

The method for identifying enrichment is based on a very simple criteria:  a window is kept if the mean (or median) value for the window is greater  than (or less than for depletion) the threshold. No statistics or False  Discovery Rate is calculated.

The threshold may be automatically determined based on a calculated  mean and standard deviation from a sampling of the dataset. For sampling  purposes, the largest chromosome, scaffold, or sequence defined in the  database is used. A multiple (default 1.5X) of the standard deviation  is used to set the threshold.

If an annotation database is provided, gene, ORF, non-coding RNA, or  other features may optionally be identified overlapping the enriched  regions.

The program writes out a tab-delimited text file consisting of chromosome,  start, stop, strand, score, and overlapping gene or non-gene genomic  features. It will optionally write a GFF3 file.

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
