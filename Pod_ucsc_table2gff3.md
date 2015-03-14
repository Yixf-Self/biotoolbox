_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
ucsc\_table2gff3.pl

A script to convert UCSC gene tables to GFF3 annotation.

## SYNOPSIS ##
```
   ucsc_table2gff3.pl --ftp <text> --db <text>
```
```
   ucsc_table2gff3.pl [--options] --table <filename>
```
```
  Options:
  --ftp [refgene|ensgene|xenorefgene|known|all]
  --db <text>
  --host <text>
  --table <filename>
  --status <filename>
  --sum <filename>
  --ensname <filename>
  --enssrc <filename>
  --kgxref <filename>
  --chromo <filename>
  --source <text>
  --(no)chr             (true)
  --(no)gene            (true)
  --(no)cds             (true)
  --(no)utr             (false)
  --(no)codon           (false)
  --(no)share           (true)
  --(no)name            (false)
  --gz
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--ftp `[`refgene|ensgene|xenorefgene|known|all`]`


> Request that the current indicated tables and supporting files be  downloaded from UCSC via FTP. Four different tables may be downloaded,  including _refGene_, _ensGene_, _xenoRefGene_ mRNA gene prediction  tables, and the UCSC _knownGene_ table (if available). Specify all to  download all four tables. A comma delimited list may also be provided.

> 
--db <text>


> Specify the genome version database from which to download the requested  table files. See <http://genome.ucsc.edu/FAQ/FAQreleases.html> for a  current list of available UCSC genomes. Examples included hg19, mm9, and  danRer7.

> 
--host <text>


> Optionally provide the host FTP address for downloading the current  gene table files. The default is 'hgdownload.cse.ucsc.edu'.

> 
--table <filename>


> Provide the name of a UCSC gene or gene prediction table. Tables known  to work include the _refGene_, _ensGene_, _xenoRefGene_, and UCSC  _knownGene_ tables. Both simple and extended gene prediction tables, as  well as refFlat tables are supported. The file may be gzipped. When  converting multiple tables, use this option repeatedly for each table.  The `--ftp` option is recommended over using this one.

> 
--status <filename>


> Optionally provide the name of the _refSeqStatus_ table file. This file  provides additional information for the _refSeq_-based gene prediction  tables, including _refGene_, _xenoRefGene_, and _knownGene_ tables.  The file may be gzipped. The `--ftp` option is recommended over using this.

> 
--sum <filename>


> Optionally provide the name of the _refSeqSummary_ file. This file  provides additional information for the _refSeq_-based gene prediction  tables, including _refGene_, _xenoRefGene_, and _knownGene_ tables. The  file may be gzipped. The `--ftp` option is recommended over using this.

> 
--ensname <filename>


> Optionally provide the name of the _ensemblToGeneName_ file. This file  provides a key to translate the Ensembl unique gene identifier to the  common gene name. The file may be gzipped. The `--ftp` option is  recommended over using this.

> 
--enssrc <filename>


> Optionally provide the name of the _ensemblSource_ file. This file  provides a key to translate the Ensembl unique gene identifier to the  type of transcript, provided by Ensembl as the source. The file may be  gzipped. The `--ftp` option is recommended over using this.

> 
--kgxref <filename>


> Optionally provide the name of the _kgXref_ file. This file  provides additional information for the UCSC _knownGene_ gene table. The file may be gzipped.

> 
--chromo <filename>


> Optionally provide the name of the chromInfo text file. Chromosome  and/or scaffold features will then be written at the beginning of the  output GFF file (when processing a single table) or written as a  separate file (when processing multiple tables). The file may be gzipped.

> 
--source <text>


> Optionally provide the text to be used as the GFF source. The default is  automatically derived from the source table file name, if recognized, or  'UCSC' if not recognized.

> 
--(no)chr


> When downloading the current gene tables from UCSC using the `--ftp`  option, indicate whether (or not) to include the _chromInfo_ table.  The default is true.

> 
--(no)gene


> Specify whether (or not) to assemble mRNA transcripts into genes. This  will create the canonical gene->mRNA->(exon,CDS) heirarchical  structure. Otherwise, mRNA transcripts are kept independent. The gene name,  when available, are always associated with transcripts through the Alias  tag. The default is true.

> 
--(no)cds


> Specify whether (or not) to include CDS features in the output GFF file.  The default is true.

> 
--(no)utr


> Specify whether (or not) to include three\_prime\_utr and five\_prime\_utr  features in the transcript heirarchy. If not defined, the GFF interpreter  must infer the UTRs from the CDS and exon features. The default is false.

> 
--(no)codon


> Specify whether (or not) to include start\_codon and stop\_codon features  in the transcript heirarchy. The default is false.

> 
--(no)share


> Specify whether exons, UTRs, and codons that are common between multiple  transcripts of the same gene may be shared in the GFF3. Otherwise, each  subfeature will be represented individually. This will reduce the size of  the GFF3 file at the expense of increased complexity. If your parser  cannot handle multiple parents, set this to --noshare. Due to the  possibility of multiple translation start sites, CDS features are never  shared. The default is true.

> 
--(no)name


> Specify whether you want subfeatures, including exons, CDSs, UTRs, and  start and stop codons to have display names. In most cases, this  information is not necessary. The default is false.

> 
--gz


> Specify whether the output file should be compressed with gzip.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation

> 
## DESCRIPTION ##
This program will convert a UCSC gene or gene prediction table file into a GFF3 format file. It will build canonical gene->transcript->`[`exon,  CDS, UTR`]` heirarchical structures. It will attempt to identify non-coding genes as to type using the gene name as inference. Various additional informational attributes may also be included with the gene and transcript features, which are derived from supporting table files.

Four table files are supported. Gene prediction tables, including _refGene_,  _xenoRefGene_, and _ensGene_, are supported. The UCSC _knownGene_ gene  table, if available, is also supported. Supporting tables include _refSeqStatus_,  _refSeqSummary_, _ensemblToGeneName_, _ensemblSource_, and _kgXref_.

Tables obtained from UCSC are typically in the extended GenePrediction  format, although simple genePrediction and refFlat formats are also  supported. See <http://genome.ucsc.edu/FAQ/FAQformat.html#format9> regarding UCSC gene prediction table formats.

The latest table files may be automatically downloaded using FTP from  UCSC or other host. Since these files are periodically updated, this may  be the best option. Alternatively, individual files may be specified  through command line options. Files may be obtained manually through FTP,  HTTP, or the UCSC Table Browser. However, it is _highly recommended_ to  let the program obtain the necessary files using the `--ftp` option, as  using the wrong file format or manipulating the tables may prevent the  program from working properly.

If provided, chromosome and/or scaffold features may also be written to a  GFF file. If only one table is being converted, then the chromosome features  are prepended to the GFF file; otherwise, a separate chromosome GFF file is  written.

If you need to set up a database using UCSC annotation, you should first  take a look at the BioToolBox script _db\_setup.pl_, which provides a  convenient automated database setup based on UCSC annotation. You can also  find more information about loading a database in a How To document at  <https://code.google.com/p/biotoolbox/wiki/WorkingWithDatabases>.

## AUTHOR ##
```
 Timothy J. Parnell, PhD
 Dept of Oncological Sciences
 Huntsman Cancer Institute
 University of Utah
 Salt Lake City, UT, 84112
```
This package is free software; you can redistribute it and/or modify it under the terms of the GPL (either version 1, or at your option, any later version) or the Artistic License 2.0.
