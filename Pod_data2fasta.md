_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
data2fasta.pl

A script to retrieve sequences from a list of features

## SYNOPSIS ##
data2fasta.pl `[`--options...`]` <filename>

```
  Options:
  --in <filename>
  --db <name|file|directory>
  --id <index>
  --seq <index>
  --desc <index>
  --chr <index>
  --start <index>
  --stop <index>
  --strand <index>
  --extend <integer>
  --cat
  --pad <integer>
  --out <filename> 
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in <filename>


> Specify the input data file. The file should be a tab-delimited text file  with columns representing the sequence id or name, sequence, description,  chromosome, start, stop, and/or strand information. The file may be  compressed with gzip.

> 
--db <name|file|directory>


> Provide the name of an uncompressed Fasta file (multi-fasta is ok) or  directory containing multiple fasta files representing the genomic  sequence. The directory must be writeable for a small index file to be  written. Alternatively, the name of a Bio::DB::SeqFeature::Store  annotation database that contains genomic sequence may be provided.  For more information about using databases, see  <https://code.google.com/p/biotoolbox/wiki/WorkingWithDatabases>.   The database name may be obtained from the input file metadata.  Required only if collecting sequence from genomic coordinates.

> 
--id <index>


> Optionally specify the index for the name or ID column. It may be  automatically determined from the column header.

> 
--seq <index>


> Optionally specify the index for the sequence column. It may be  automatically determined from the column header.

> 
--desc <index>


> Optionally specify the index of the description column. It may be  automatically determined from the column header.

> 
--chr <index>


> Optionally specify the index for the chromosome column. It may be  automatically determined from the column header.

> 
--start <index>


> Optionally specify the index for the start position column. It may be  automatically determined from the column header.

> 
--stop <index>


> Optionally specify the index for the stop position column. It may be  automatically determined from the column header.

> 
--strand <index>


> Optionally specify the index for the strand column. It may be  automatically determined from the column header.

> 
--extend <integer>


> Optionally provide the number of extra base pairs to extend the start  and stop positions. This will then include the given number of base  pairs of flanking sequence from the database. This only applies when  sequence is obtained from the database.

> 
--cat


> Optionally indicate that all of the sequences should be concatenated  into a single Fasta sequence. The default is to write a multi-fasta  file with separate sequences.

> 
--pad <integer>


> When concatenating sequences into a single Fasta sequence, optionally  indicate the number of 'N' bases to insert between the individual  sequences. The default is zero.

> 
--out <filename>


> Specify the output filename. By default it uses the input file basename.

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
This program will take a tab-delimited text file (BED file,  for example) and generate either a multi-sequence fasta file containing the  sequences of each feature defined in the input file, or optionally a single  concatenated fasta file. If concatenating, the individual sequences may be  padded with the given number of 'N' bases.

This program has two modes. If the name and sequence is already present in  the file, it will generate the fasta file directly from the file content.

Alternatively, if only genomic position information (chromosome, start,  stop, and optionally strand) is present in the file, then the sequence will  be retrieved from a database, either a Bio::DB::SeqFeature::Store database,  a genomic sequence multi-fasta, or a directory of multiple fasta files.  If strand information is provided, then the sequence reverse complement  is returned for reverse strand coordinates.

## AUTHOR ##
```
 Timothy J. Parnell, PhD
 Dept of Oncological Sciences
 Huntsman Cancer Institute
 University of Utah
 Salt Lake City, UT, 84112
```
This package is free software; you can redistribute it and/or modify it under the terms of the GPL (either version 1, or at your option, any later version) or the Artistic License 2.0.
