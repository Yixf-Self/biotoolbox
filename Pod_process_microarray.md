_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
process\_microarray.pl

A script to quantile normalize two or more raw microarray data sets.

## SYNOPSIS ##
process\_microarray.pl --in <filename1>,<filename2> --channel <redgreen>  --out <filename>

process\_microarray.pl --recipe <file>

```
  Options:
  --in <filename>
  --recipe <filename>
  --out <filename>
  --channel <redgreen> [e | c | n]
  --median <integer>
  --nlist <filename>
  --(no)norm
  --separate
  --(no)log
  --processed
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in <filename>


> Specify the input microarray file(s). Either provide a single comma-delimited  list, or use this argument repeatedly for each file. Agilent text files,  Nimblegen .pair files, or GenePix .gpr files are accepted. The file(s) may be  compressed with gzip.

> 
--recipe <filename>


> Specify a text file containing the list of input files to process, along  with the channel assignment for experiment and control microarray values.  See below for the format.

> 
--out <filename>


> Specify the output filename. By default it uses the basename of the recipe  filename, if available.

> 
--channel `[`e|c|n`]`


> Specify (e)xperiment, (c)ontrol or (n)one designation for each channel  of each input file. For two-channel microarrays, provide two designations  for red (Cy5) and green (Cy3) channels, respectively. For one-channel  microarrays, provide only one designation per file. There must be one  designation for each specified file. Use this argument repeatedly for  each file, or provide a single comma-delimited list.

> 
--median <integer>


> Optionally specify the target value to which the microarray probes will  be median scaled. The default value is no scaling.

> 
--nlist <filename>


> Optionally specify the filename of a text file containing a list of control  probe ID names to which all the rest of the probes will be normalized  against. The control probe median value will be used as the scaling target.

> 
--(no)norm


> Optionally indicate whether to quantile normalize (or not) the values   between microarray sets. The default is true (quantile normalize values).

> 
--separate


> Optionally indicate that experiment and control microarray data sets  should be quantile normalized separately and not together. The default  is false (quantile everything together).

> 
--(no)log


> Optionally indicate that the experiment, control, and ratio values  should (not) be converted to a log2 ratio. The default is true.

> 
--processed


> Optionally indicate that the Processed values in an Agilent text file  should be used. The default is to use the Raw values.

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
This program will process raw microarray data files and return normalized  values for each named probe. It will quantile normalize replicate datasets,  median scale the values, and calculate an experiment/control log2 ratio. It  supports Agilent Feature Extraction files, GenePix files, and NimbleGen  pair files.

It will accept as many input files as you provide, although quantile  normalization requires at least two replicates. Experiment and control data  sets may be quantile normalized together, or separately. Experiment and  control data sets are not limited to the same data file (for two-channel  microarray hybridizations), giving creative flexibility in assigning  data files and microarray hybridizations. Control data sets may also be  excluded, in which case all provided data sources are treated as experiment.

Multi-slide hybridizations are easily taken into account if there are not  duplicate probes across the slides with identical feature numbers. Each  microarray probe is assigned a unique number based on probe name and  feature number, and each one must have the same number of data set or  replicate values. Otherwise, normalization cannot proceed. If you get this  error message, then you may have to filter the raw files first, or process  separately.

If a reference control set of oligo probes are included in the microarray  design, their probe names may be supplied as an external normalization file,  in which case the median value of those probes are used as the target for  median scaling of the entire array.

The program will determine correlation and r-squared values between datasets  and report them. For multi-slide sets, it is best if all slides in a set are  listed sequentially for this to work best.

The program will write out a tab-delimited data file consisting of  normalized data values for experiment and control, and the experiment/control ratio for each probeID. It will also write out a separate report text file.

## RECIPE FILE ##
To facilitate complex arrangements of data files, hybridizations, channel  swapping, and differing numbers of experiment and control data sets, a  recipe file may be generated. This is a simple, two-column (whitespace  delimited) text file.

The first column is the data source path and filename.

The second column is one or two letter abbreviation specifying the  channel and designation, following the nomenclature under the channel  option above. Use one letter for one-channel (red or green) data files,  or two letters for two-channel (red and green) data files. Use e for  experiment, c for control, or n for none. For two-channel files, specify  red first, then green.

Blank lines and comment lines (prefix #) are ignored.

An example is below

```
 # two-channel file, red is experiment, green is control
 path/to/file.txt	ec
 # two-channel file, red is experiment, green is not used
 path/to/file.txt	en
```
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
