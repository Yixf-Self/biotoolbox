_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
join\_data\_file.pl

A script to join two or more data files and concatenate rows.

## SYNOPSIS ##
join\_data\_file.pl `[`--options`]` <file1> <file2> ...

```
  Options:
  --out <filename>
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--out <filename>


> Provide the name of the output file. If the input files were  split using 'split\_data\_file.pl', then the original base name  may be reconstituted. Otherwise, the user will be asked for  an output file name.

> 
--gz


> Indicate whether the output files should be compressed  with gzip. Default behavior is to preserve the compression  status of the first input file.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation

> 
## DESCRIPTION ##
This program will join two or or more data files, essentially concatanating the files but intelligently dealing with the metadata and column headers.  Checks are made to ensure that the number of columns in the subsequent files  match the first file.

The program will not merge datasets from multiple files; see  the program 'merge\_datasets.pl' for that.

This program is intended as the complement to 'split\_data\_files.pl'.

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
