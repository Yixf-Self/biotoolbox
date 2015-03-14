_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
intersect\_nucs.pl

A script to intersect two lists of nucleosomes.

## SYNOPSIS ##
intersect\_nucs.pl `[`--options...`]` <filename\_1> <filename\_2>

```
  Options:
  --in1 <filename1>
  --in2 <filename2>
  --out <filename>
  --force_strand
  --gff
  --type <gff_type>
  --source <gff_source>
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in1 <filename>


--in2 <filename>


> Specify two files of nucleosome lists. The files must contain sorted genomic position coordinates for each nucleosome. Supported file formats include any text data file with chromosome, start, stop, and name. The file with the least number of nucleosomes is automatically designated as the target, while the file with the most is designated as the reference list. When files with equivalent numbers are provided, the first file  is target.

> 
--out <filename>


> Specify the output file name. The default is "intersection`_`" appended  with both input names.

> 
--force\_strand


> Force the target nucleosomes to be considered as stranded. This enforces  an orientation and affects the direction of any reported nucleosome shift.  A column with a label including 'strand' is required in the target file.  The default is false.

> 
--gff


> Indicate whether a GFF file should be written in addition to the standard  text data file. The GFF file version is 3. The default value is false.

> 
--type <gff\_type>


> Provide the text to be used as the GFF type (or method) used in  writing the GFF file. The default value is "nucleosome\_intersection".

> 
--source <gff\_source>


> Provide the text to be used as the GFF source used in writing the  GFF file. The default value is the name of this program.

> 
--gz


> Specify whether (or not) the output files should be compressed  with gzip.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation of the script.

> 
## DESCRIPTION ##
This program will intersect two lists of nucleosomes. It will identify which  nucleosomes overlap, the direction and extent of shift of their midpoints,  and the delta change of the occupancy (or score value). The file with the  least number of nucleosomes is automatically designated as the target list,  and the file with the most number is designated as the reference list. The  reference file, at least, must be sorted in genomic order; otherwise,  intersection will yield undesirable results.

The program will output a tim data text file of the intersections, which include the start and stop points that indicate the positions and extent of the midpoint shift, the direction of shift, and the name of the intersecting nucleosomes. Optionally a GFF file may also be written as well.

The target nucleosomes may have strand optionally imposed. This is useful  when working with nucleosomes that are associated with stranded genomic  features, for example, nucleosomes flanking a transcription start site.

A summary and statistics of the intersection are printed to standard output  upon completion.

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
