_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
novo\_wrapper.pl

A parallelized wrapper program for Novocraft's novoaligner.

## SYNOPSIS ##
```
 novo_wrapper.pl --index <file> [--options] <seq_file1> ...
```
```
  Options:
  --in <seq_file>
  --index </path/to/novoalign_index>
  --repeat [None | All | Random | Exhaustive]
  --split
  --cores <integer>
  --opt <"text">
  --novo </path/to/novoalign>
  --sam </path/to/samtools>
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in <seq\_file>


> Specify the name(s) of the input Fastq sequence files. Multiple files may be  specified using multiple --in arguments, with a single --in argument and a  comma delimited list, or as a list at the end of all options. The files may  kept gzipped; they will automatically be uncompressed.

> 
--index <novo\_index>


> Specify the path to genome database index file to which the sequences will  be aligned. The file should be built using Novocraft's 'novoindex' program.

> 
--repeat `[`None | All | Random | Exhaustive`]`


> Specify the novoalign option of dealing with sequences which align to  multiple locations in the genome (repeats). See the Novoalign  documentation for more information. Default value is None.

> 
--split


> Indicate that the input file should be split into numerous files (2  million lines each) and multiple instances of Novoalign should be  executed. This requires the GNU 'parallel' utility to be installed.

> 
--cores <integer>


> When used with the --split option, this will limit the number of  Novoalign instances executed at once. Default is 4.

> 
> When using a paid, licensed version of Novoalign, skip the --split  option and specify as many CPU cores you want Novoalign to use in  multi-threaded execution. Default is 1 (assume free academic version  of Novoalign).

> 
--opt <"text">


> Specify any additional options you want to passed to the Novoalign  executable. See the documentation for Novoalign for a full list of  available options. Must enclose in quotes.

> 
--novo </path/to/novoalign>


> Optionally specify the full path to Novocraft's 'novoalign' executable  file. It may also be specified in the 'biotoolbox.cfg' file, or it may  be automatically identified by searching the environment path.

> 
--sam </path/to/samtools>


> Optionally specify the full path to the 'samtools' executable  file. It may also be specified in the 'biotoolbox.cfg' file, or it may  be automatically identified by searching the environment path.

> 
--version


> Print the program version number.

> 
--help


> This help text.

> 
## DESCRIPTION ##
This program is a wrapper for Novocraft's Novoalign alignment tool. It also  performs a number of post-alignment functions, including converting the  alignments into a sorted, indexed, Bam file using samtools.

When using the unlicensed, free, academic version of Novoalign that is  limited to single-thread execution, novo\_wrapper.pl can split the input  file into numerous smaller versions and execute multiple instances of  Novoalign. This requires the Parallel::ForkManager module for managing  multiple executions. Note that only a limited number of instances  should be run simultaneously; too many and your system may come to a  standstill.

Licensed versions of Novoalign are multi-threaded and do not need to be  split.

Novoalign is executed with the "-s 2", and "-r None" as default  options. Additional custom options may be passed on to Novoalign by  using the --opt flag above.

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
