This tool box is a collection of various library modules and programs for processing, converting, analyzing, and manipulating genomic data and/or features. They are written in Perl, and rely on [BioPerl](http://www.bioperl.org/wiki/Main_Page) and [GMOD](http://www.gmod.org/wiki/Main_Page) related modules for working with a wide variety of modern file formats and databases. The flexibility and versatility provides a nice complement to many other common bioinformatic tools in popular use today.

Some notable features and capabilities include
  * Primary object-oriented module, [Bio::ToolBox::Data](Pod_Data.md), for easily working with data files and data sets
  * Working with a wide variety of modern data [file formats](http://code.google.com/p/biotoolbox/wiki/DataFileFormats), including GFF3, BED, UCSC refSeq and genePred, Encode narrowPeak and broadPeak, wig, bigWig, bigBed, Bam, USeq, and any other tab-delimited text file with an integrated, abstract interface
  * Working with relational [databases](http://code.google.com/p/biotoolbox/wiki/WorkingWithDatabases) of genomic annotation
  * Tools for exporting annotation from [UCSC](http://code.google.com/p/biotoolbox/wiki/Pod_ucsc_table2gff3) and [Ensembl](http://code.google.com/p/biotoolbox/wiki/Pod_get_ensembl_annotation) genome repositories
  * Scripts for [collecting](http://code.google.com/p/biotoolbox/wiki/Pod_get_datasets) and summarizing scores for known annotated features using a variety of statistical methods
  * Scripts for collecting [binned data](http://code.google.com/p/biotoolbox/wiki/Pod_get_relative_data) relative to annotated reference points, for example generating class average profiles around start sites of transcription
  * Tools for converting data between popular file formats
  * Tools for converting [Bam alignment](http://code.google.com/p/biotoolbox/wiki/Pod_bam2wig) files into wig coverage maps, including both stranded coverage and empirically-determined shifted coverage from RNASeq and ChIPSeq experiments.
  * Tools for [manipulating](http://code.google.com/p/biotoolbox/wiki/Pod_manipulate_datasets) and analyzing collected data, including generating simple graphs
  * Tools for working with nucleosome mapping
  * Tools for working with [SNPs](http://code.google.com/p/biotoolbox/wiki/MappingSNPs)
  * Multi-CPU utilization for enhanced performance on modern servers
  * Much, much more

### Who is this for? ###
BioToolBox is for individuals who need simple tools for high level gene analysis of their ChIP and RNA sequencing and microarray data. While some low level tools are included here for processing, such as [Bam to wig](http://code.google.com/p/biotoolbox/wiki/Pod_bam2wig) conversion and raw [microarray](http://code.google.com/p/biotoolbox/wiki/Pod_process_microarray) processing, the data collection is best used with processed data.

Since many of the adaptors and modules used by BioToolBox are shared with [GMOD](http://www.gmod.org/wiki/Main_Page) components, including [GBrowse](http://gmod.org/wiki/GBrowse), BioToolBox makes an excellent companion to those who use those resources in their bioinformatics analysis.

### What programs are available? ###
This is a [list](http://code.google.com/p/biotoolbox/wiki/ProgramList) of available programs and their descriptions.

### Downloads ###
Google Code no longer supports new downloads. Deprecated versions are still available but not recommended. Users should download the latest versions through [CPAN](http://search.cpan.org/perldoc?Bio::ToolBox).

### How do I get started? ###
BioToolBox is designed to run on the command line in a Unix-like environment (Linux and Mac OS X have been tested). You can try Windows; some of it may work.

BioToolBox is available on [CPAN](http://search.cpan.org/perldoc?Bio::ToolBox), and can be installed from there. There is a [Quick Guide](http://code.google.com/p/biotoolbox/wiki/QuickGuide) to help you get started, and a more detailed [general guide](http://code.google.com/p/biotoolbox/wiki/BioToolBoxSetUp).

BioToolBox works best (although not required) with a relational database of genomic annotation. See [Working With Databases](http://code.google.com/p/biotoolbox/wiki/WorkingWithDatabases) for a guide on setting up your database and working with features from it.

A primary function of BioToolBox is collecting and working with datasets. See [Working With Datasets](http://code.google.com/p/biotoolbox/wiki/WorkingWithDatasets) for a guide on collecting data and working with it.

## News ##
  * 12 March 2015: Release v1.25 on CPAN with some internal library changes, script improvements, and bug fixes.
  * 1 February 2015: Release v1.24001 on CPAN with no code changes but improved installation tests to avoid problems and accommodate new UCSC library testing for bigWig files.
  * 20 January 2015: Release v1.24 on CPAN with a major addition of Bio::ToolBox::Data::Stream for working with very large files line by line, rather loading entirely into memory. Also added support for more file formats and precise counting of Bam alignments, along with numerous bug fixes.
  * 28 November 2014: Release v1.23 on CPAN with more bug fixes
  * 9 November 2014: Release v1.22 on CPAN with several major bug fixes
  * 31 October 2014: Release v1.21 on CPAN with several major bug fixes
  * 13 October 2014: Release v1.20 on CPAN with major code refactoring in libraries and scripts. Almost all scripts now use Bio::ToolBox::Data. Specialized scripts are no longer included in the CPAN distro but still available here. Libraries are optimized to only load database adaptors as necessary to reduce bloat.
  * 29 May 2014: Release v1.19 on CPAN with new support for shared sub features in GFF3 files
  * 9 May 2014: Release v1.18 on CPAN with some critical and minor bug fixes, plus some new script options
  * 22 April 2014: Release v1.17 on CPAN with new Data APIs and updated script documentation.
  * 15 March 2014: Released v.1.16 on CPAN with bug fixes.
  * 10 March 2014: Released v.1.15 on CPAN with a number of bug fixes and improvements.
  * 15 February 2014: Released v.1.14.1 on CPAN with a number of bug fixes.
  * 23 January 2014: Released v.1.14 on CPAN. The library architecture has been completely redesigned to conform to a standard Perl module format, and a brand new object-oriented interface has been added to easily work with data files and datasets. A new script has been added to greatly ease database setup. A number of bug fixes have also been included.
  * 19 November 2013: Released v.1.13 with added support for USeq files in data collection, plus two new scripts for filtering and collecting statistics from Bam sequence alignments
  * 21 August 2013: Released v.1.12.4 with some critical bugs fixed and significant improvements to bam2wig.
  * 16 July 2013: Released v.1.12.2 with two scripts converted to multi-CPU execution and bug fixes
  * 6 June 2013: Updating wikis and front page
  * 23 May 2013: Released major version 1.12 with multi-CPU core utilization in data collection scripts and Bam to wig conversion for dramatic improvements in speed
  * 28 April 2013: Released major version 1.11. Database feature collection was updated to handle non-unique features and improve efficiency. GFF3 export scripts were updated to improve compatability.
  * 15 March 2013: Release major version 1.10 with improved low-level Bam file access for significant improvements in data collection and file conversion
  * 12 October 2012: Release major version 1.9 with two new scripts, get\_features.pl and correlate\_position\_data.pl.
  * 6 July 2012: Release new script CpG\_calculator.pl.
  * 16 May 2012: Release major version 1.8 with updated SNP analysis scripts.
  * 30 March 2012: Release major version 1.7 with new scripts get\_gene\_regions.pl, data2fasta.pl, and compare\_subfeature\_scores.pl.
  * 16 December 2011: Release major version 1.6.
  * 3 June 2011: Release major version 1.5.
  * 9 February 2011: Release major version 1.4 with new script bam2wig.pl
  * 20 January 2011: Release version 1.2 with Bam file support.
  * 13 December 2010: Initial release of version 1.0.

### Why were these programs written? ###
They were initially written to assist me in my own laboratory research. As they were expanded in scope, I realized they could be potentially useful to others in the same predicament as me. Thus, releasing these programs for others to use.

### Bugs? Problems? ###
I do not have a mailing list (yet?). If you find bugs (there always are), please let me know. Create a New Issue under the Issues tab above, or email me directly (parnell dot tj at gmail dot com).