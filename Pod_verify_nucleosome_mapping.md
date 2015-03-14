_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
verify\_nucleosome\_mapping.pl

A script to verify nucleosome mapping and identify overlaps.

## SYNOPSIS ##
verify\_nucleosome\_mapping.pl `[`--options...`]` <filename>

```
  Options:
  --in <filename>
  --db <text>
  --data <text | filename>
  --filter
  --max <integer>           (30)
  --recenter
  --out <filename> 
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in <filename>


> Specify the input file. The program expects a text data file with  at least chromosome, start, and stop coordinates representing  nucleosome annotation. The output file from the biotoolbox script  'map\_nucleosomes.pl' is ideal, although a Bed, GFF, or other file  is allowed. The file may be compressed with gzip.

> 
--db <text>


> Specify the name of a `Bio::DB::SeqFeature::Store` annotation database  from which gene or feature annotation may be derived. For more  information about using annotation databases, see  <https://code.google.com/p/biotoolbox/wiki/WorkingWithDatabases>.

> 
--data <text | filename>


> Provide the name of the dataset or data file (bigWig format) containing the nucleosome midpoint occupancy data with which to verify nucleosomal positions. If data is obtained from a database, the type or primary\_tag should be provided. Default is to use the  dataset defined in the input file metadata.

> 
--filter


> Optionally filter out nucleosomes that exceed a maximum allowed  overlap. Filtered nucleosomes are deleted from the file. Default is  no filtering.

> 
--max <integer>


> Specify the maximum allowed overlap in bp when filtering out  overlapping nucleosomes. The default is 30 bp.

> 
--recenter


> Optionally re-center those nucleosomes determined to be offset  from the actual peak in the data.

> 
--out <filename>


> Optionally specify the output file name. By default it will overwrite  the input file.

> 
--gz


> Optionally indicate the file should be compressed when written.

> 
--version


> Print the version number.

> 
--help


> Display this POD documentation.

> 
## DESCRIPTION ##
This program will verify the mapping of nucleosomes. It expects as input a text file containing the genomic coordinates of annotated nucleosomes. The output data file from the BioToolBox script 'map\_nucleosomes.pl' is ideal, although other text files, including Bed and GFF, are supported. Nucleosomes are verified by comparing the peak of nucleosome reads collected from the original dataset with the recorded midpoint of the mapped nucleosome. If the peak is <= 10 bp from the recorded midpoint, then the nucleosome is considered centered on the peak and it is properly mapped. If the peak is > 10 bp from the recorded midpoint, then it is considered offset, or improperly mapped. This is most often due to nucleosomes being called prematurely when the dataset is being scanned in windows from left to right. Adjusting the parameters for window and buffer in map\_nucleosomes.pl can limit the number of overlapping nucleosomes.

The program can optionally re-center those nucleosomes considered to  be offset from their actual data peak. The start, end, midpoint, and  name is changed to reflect the new position.

The program can also optionally filter out nucleosomes which exceed a  set limit of overlap. The overlapping nucleosome to be deleted is  chosen based on a set of rules: offset nucleosomes are deleted, or if  both nucleosomes are offset, then the one with the greatest offset is  deleted. If neither nucleosome is offset, then the nucleosome with the  lowest occupancy is deleted, or if both occupancies are equal, then  the rightmost is deleted. Overlap statistics are then recalculated after  filtering.

The same data file is re-written or a new file written with three  additional columns appended, overlap\_length, center\_peak\_mapping, and  center\_peak\_offset.

Overlap\_length records the amount of overlap between mapped nucleosomes.  Ideally this should be 0 as nucleosomes should not overlap; overlapping  nucleosomes indicates either an error in mapping or multiple phasing of  nucleosomes.

Center\_peak\_mapping records whether the nucleosome was properly mapped or  not. One of three values is recorded: centered, recentered, or offset.

Center\_peak\_offset records the distance in bp between the observed data  peak and the recorded midpoint.

Basic statistics are reported to Standard Output for the overlap and  offset lengths.

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
