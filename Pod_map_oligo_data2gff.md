_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
map\_oligo\_data2gff.pl

A script to assign processed microarray data to genomic coordinates.

## SYNOPSIS ##
map\_oligo\_data2gff.pl --oligo <oligo\_file.gff> --data <oligo\_data.txt> `[`--options`]`

```
  Options:
  --oligo <oligo_file.gff>
  --data <oligo_data.txt>
  --index <column_index>
  --name <text>
  --type <text>
  --source <text>
  --strand
  --(no)mid
  --places [0,1,2,3]
  --out <filename> 
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--oligo <oligo\_file.gff>


> Specify the file name of the oligo probe GFF file. This file should identify  all positions that the probes align to in the genome. It may be either v.2 or  v.3 GFF file, but the oligo probe name or ID must be present in the group  field.

> 
--data <oligo\_data.tx>


> Specify the file name of a data file. It must be a tab-delimited text file, preferably in the tim data format as described in Bio::ToolBox::file\_helper,  although any format should work. The file may be compressed with gzip. The  first column MUST be the oligo or probe unique name or ID.

> 
--index <column\_index>


> Specify the data column index in the data file that will be used in the  final GFF score column. By default, it lists the column names for the user  to interactively select.

> 
--col <column\_index>


> Alias to --index.

> 
--name <text>


> Specify the name of the dataset to be used in the output GFF file. By default  it uses the column name from the data file.

> 
--type <text>


> Specify the output GFF type or method field value. By default, it uses the name.

> 
--source <text>


> Specify the output GFF source field value. By default it is 'lab'.

> 
--strand


> Indicate whether the original strand information should be kept from the  original oligo GFF file. The default is false, as most ChIP data is inherently  not stranded.

> 
--(no)mid


> Indicate whether the original position information should (not) be converted  to the midpoint position. The GBrowse xyplot data works best when data is  present at single points (start = end) rather than regions. Default is true.

> 
--places `[`0,1,2,3`]`


> Indicate the number of decimal places the score value should be formatted. The  default is no formatting.

> 
--out <filename>


> Specify the output filename. The default is to use the name value.

> 
--gz


> Indicate whether the output file should (not) be compressed with gzip.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation

> 
## DESCRIPTION ##
This script assigns data values for microarray oligo probes to positions in the  genome. It essentially merges the information from a data file, consisting of  unique oligo probe names and data values, with a GFF file referencing the  genomic positions of each microarray oligo probe.

The score value may be formatted, and the GFF type, source, name, and strand  may be set to new values. It will write a GFF v.3 file, regardless of the  source oligo GFF file version.

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
