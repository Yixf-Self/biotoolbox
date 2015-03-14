_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
filter\_bam.pl

A script to filter a Bam file for specific criteria.

## SYNOPSIS ##
filter\_bam.pl <file.bam>

```
  Options:
  --in <file.bam>
  --out <filename>
  --(no)pass
  --(no)fail
  --(no)align
  --mismatch
  --gap
  --indel
  --mproper
  --mseqid
  --mstrand
  --score <integer>
  --length <integer>
  --seq <pos:[ATCG]>
  --attrib <key:value>
  --index
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--in <file.bam>


> Specify the file name of a binary Bam file as described for  Samtools. It does not need to be sorted or indexed.

> 
--out <filename>


> Optionally specify the base name of the output file. The default is  to use input base name, appended with '.filter'. If both pass and  fail files are written, then they are appended with '.pass' and  '.fail', respectively.

> 
--pass


--nopass


> Indicate whether (or not) alignments which pass the test criteria  should be written to an output Bam file. The default is true.

> 
--fail


--nofail


> Indicate whether (or not) alignments which fail the test criteria  should be written to an output Bam file. The default is false.

> 
--align


--noalign


> Indicate whether (or not) aligned reads should pass. The default is true.

> 
--mismatch


> Indicate that only alignments with a mismatch should pass. A  mismatch is indicated by either the `NM` or `MD` attributes of  the alignment, or by the presence of X (mismatch) operations   in the CIGAR string. Gaps, clipped, or padded sequences are not  counted.

> 
--gap


> Indicate that only alignments with a gap should pass. Gaps are  determined by the presence of N (skipped) operations in the  CIGAR string.

> 
--indel


> Indicate that only alignments with either an insertion or deletion  should pass. Indels are determined by the presence of I (insertion)  or D (deletion) operations in the CIGAR string.

> 
--mproper


> Indicate that only alignments that are part of a proper pair  should pass. Proper pairs are Forward-Reverse alignments on  the same reference, and do not include Forward-Forward,  Reverse-Reverse, Reverse-Forward, or separate reference  sequence alignments.

> 
--mseqid


> Indicate that only paired alignments that are on the same  reference sequence should pass.

> 
--mstrand


> Indicate that only paired alignments that align to different  strands should pass, i.e. a Forward-Reverse or Reverse-Forward.

> 
--score <integer>


> Indicate that only alignments which have a quality score equal  or greater than that indicated shall pass. The mapping quality  score is a posterior probability that the alignment was mapped incorrectly, and reported as a -10Log10(P) value, rounded to the  nearest integer (range 0..255). Higher numbers are more stringent.

> 
--length <integer>


> Indicate that only alignments whose query sequence equals the  indicated length shall pass. Provide a comma-delimited list and/or  range of lengths. Note that only the query sequence is checked,  not the length of the alignment. Multiple lengths are treated  as a logical OR operation.

> 
--seq <pos:`[`ATCG`]`>


> Indicate that only alignments that have a specific nucleotide at  a specific position in the query sequence shall pass. Provide a  position:nucleotide pair, where position is a 1-based integer and  the nucleotide is one or more of A,C,G, or T. Providing two or  more nucleotides per position is treated as a logical OR operation.  Multiple sequence positions may be tested by issuing multiple  command line options, in which case they are combined in a logical  AND operation.

> 
--attrib <key>


--attrib <key:value>


> Indicate that only alignments that contain a specific optional  attribute shall pass. One or more values may also be provided for  the key, in which case only those alignments which match one of  the key values shall pass. The values may be provided as a comma  delimited list separated from the key by a colon. Attribute keys  are typically two letter codes; see the SAM specification at  <http://samtools.sourceforge.net/SAM1.pdf> for a list of standard  attributes. Two or more key values are combined in a logical OR  operation. Two or more attribute keys may be tested by specifying  multiple --attrib command line options; in this case, they are   combined in a logical AND operation.

> 
--index


> Optionally re-index the output bam file(s) when finished. If  necessary, the bam file is sorted by coordinate first. Default is  false.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation

> 
## DESCRIPTION ##
This program will filter the alignments in a Bam file according to a  series of one or more boolean tests. Alignments which pass all the  tests are written to an output Bam file. Alignments which do not pass  one or more filters may be optionally written to a second Bam file.

There are a number of tests that may be applied to the alignments,  controlled by command line arguments. Please note carefully how the  test is performed and whether your desired outcome should be the  pass or fail outcome. When multiple tests are indicated, they are  combined using a logical AND operation.

The input and output files are BAM files as described by the Samtools  project (http://samtools.sourceforge.net).

## EXAMPLES ##
Here are a few examples of how to use filters.

Alignments that may indicate a SNP


> SNPs could be either a mismatch, insertion, or deletion

> 
```
 filter_bam.pl --mismatch --indel --in file.bam
```
RNASeq alignments that could span an intron


```
 filter_bam.pl --gap --in file.bam
```
MNase digested DNA


> Chromatin may be digested using MNase, which cuts blunt ends between  `[`AT`]``[`AT`]` dinucleotides. To increase the likelihood that sequences were  derived from MNase digestion, filter for an `[`AT`]` nucleotide at the  first position.

> 
```
 filter_bam.pl --seq 1:AT --in file.bam
```
Alignments indicating chromosomal rearrangement


> Paired-end sequencing of genomic DNA where two ends map to separate  chromosomes or not in a proper forward-reverse arrangement may  suggest a chromosomal rearrangement. In this case, we want those  alignments that fail the test.

> 
```
 filter_bam.pl --nopass --fail --mproper --out non_properly_paired --in file.bam
```
```
 filter_bam.pl --nopass --fail --mseqid --out translocations --in file.bam
```
## AUTHOR ##
```
 Timothy J. Parnell, PhD
 Dept of Oncological Sciences
 Huntsman Cancer Institute
 University of Utah
 Salt Lake City, UT, 84112
```
This package is free software; you can redistribute it and/or modify it under the terms of the GPL (either version 1, or at your option, any later version) or the Artistic License 2.0.
