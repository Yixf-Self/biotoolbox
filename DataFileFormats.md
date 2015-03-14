The **BioToolBox** scripts, as well as [GBrowse](http://www.gmod.org/wiki/GBrowse), can utilize data stored in a number of different file formats. This is a brief list of these formats and how to use them.

## Genomic Features and Intervals ##
These data formats describe genomic regions or intervals that usually describe a feature or function encoded in the genomic DNA. For example, a gene may be comprised of several features, including but not limited to exons, introns, coding sequence (CDS), start and stop codons, untranslated regions, etc. They may also describe artificial constraints, such as a region of enrichment for a particular factor or mark, or an oligo binding site.

These regions are defined by at least three attributes: the chromosome name, the start position, and the end position. All of the data formats contain at least these three attributes. A fourth optional attribute is the strand. Beyond this, the various formats may describe additional attributes, including a numeric score value, a text name, feature type, and more. Additionally, mechanisms exist to describe a heirarchical relationship between parental and sub features.

### GFF ###
The [Generic Feature Format](http://gmod.org/wiki/GFF) is a tab-delimited text format. Each line represents a separate feature. Each line is comprised of exactly nine columns describing the feature. These include the following:
  * Chromosome (text)
  * Source (text)
  * Type (text)
  * Start (integer)
  * End (integer)
  * Score (number or '.')
  * Strand ('+', '-', or '.')
  * Frame (0, 1, or 2)
  * (version specific)
Numerous versions of GFF formats exist, including versions 1, 2, 2.5, and 3. They have subtle differences, primarily in the last column; the first eight columns are identical. All versions use base (1-base) numbering.

#### GFF v1 ####
In GFF v1, the ninth column is comprised of a single word that describe a group. All features with the same group name are grouped together. This format is mostly superseded by the other versions and is considered an outdated format.

#### GFF v2 ####
In [GFF version 2](http://www.sanger.ac.uk/resources/software/gff/spec.html), the ninth column is comprised of tag value pairs describing various attributes of the feature. Multiple tag value pairs may be included, separated by a semicolon.

#### GTF ####
The [Gene Transfer Format](http://mblab.wustl.edu/GTF22.html) is also refered to as GFF version 2.2 or 2.5. It is a specialized form of GFF v2, in which two required attribute tags are _gene\_id_ and _transcript\_id_. Additionally, the GFF types allowed are typically limited to 'CDS', 'start\_codon', 'stop\_codon', and 'exon', with some others tolerated.

If you need to convert your GTF file to GFF3, you can use an available [GTF to GFF3](http://www.sequenceontology.org/cgi-bin/converter.cgi) converter. Note that it doesn't work with UCSC-generated GTF files; for that, use the UCSC gene table, see below.

#### GFF3 ####
In [GFF version 3](http://www.sequenceontology.org/gff3.shtml), the specification is considerably more strict, allowing for more accurate parsing and data exchange. First, the GFF type is typically a Sequence Ontology term. Second, the tag value pairs in the ninth column are delimited with '='. Third, multiple heirarchical features are allowed through the use of specific 'ID' and 'Parent' attribute tags. Fourth, special attribute keys are reserved, including the aforementioned  'ID' and 'Parent', as well as 'Name' and 'Note'. Fifth, special pragmas are allowed to control parsing and include other types of data, including seqence.

To convert data to the GFF3 format, the [data2gff.pl](Pod_data2gff.md) script may be used. Additionally, genome annotation may be obtained from Ensembl and written to GFF3 format using [get\_ensembl\_annotation.pl](Pod_get_ensembl_annotation.md). Or a gene table may be obtained from the UCSC Genome [Table Browser](http://genome.ucsc.edu/cgi-bin/hgTables) and converted to GFF3 using [ucsc\_table2gff3.pl](Pod_ucsc_table2gff3.md).

GFF files are best used by loading them into a SQL database (SQLite, MySQL, memory, etc) using the `Bio::DB::SeqFeature::Store` schema; they cannot be directly used by any of the **BioToolBox** analysis programs.

### BED ###
The [Browser Extensible Data](http://genome.ucsc.edu/FAQ/FAQformat.html#format1) (BED) format was developed for use by the UCSC Genome Browser. Like the GFF format, it is a text-based, tab-delimited data format. It has at minimum three columns (chromosome, start, stop), and up to 12 columns (for specifying exonic and intronic gene structure). The most common format with regards to data is the 6 column format, with the following columns:
  * chromosome (text)
  * start (integer)
  * end (integer)
  * name (text)
  * score (0..1000)
  * strand ('+' or '-')
It uses interbase (0-based) numbering system.

BED files may be generated using the [data2bed.pl](Pod_data2bed.md) script. They cannot be used directly by any of the **BioToolBox** analysis programs, and are best converted to a GFF3 file for loading into a database or converted to a bigBed format, below.

### bigBed ###
The [bigBed](http://genome.ucsc.edu/goldenPath/help/bigBed.html) format is a compressed, indexed, binary format of the BED file developed by the UCSC genome center. It's primary advantage is for rapid, random access by a genome browser or analysis program, either remotely or locally. BigBed files may be generated from BED files using the [bedToBigBed](http://hgdownload.cse.ucsc.edu/admin/exe/) converter.

### UCSC Gene Table ###
Genome annotation may be obtained from the UCSC Genome [Table Browser](http://genome.ucsc.edu/cgi-bin/hgTables). While this format cannot be used directly, it can be converted to a GFF3 file using the **BioToolBox** script [ucsc\_table2gff3.pl](Pod_ucsc_table2gff3.md). Numerous other data tables may also be downloaded from the Table Browser, although the format of each table is variable. While the gene table from refSeq or ensGene may be converted using [ucsc\_table2gff3.pl](Pod_ucsc_table2gff3.md), other tables may or may not work. In that case, you may be able to use [data2gff.pl](Pod_data2gff.md) and select the appropriate tables to generate a GFF3 file.

In the odd case that you need to back convert from GFF3 to gene table for some reason, there is also a [gff3\_to\_ucsc\_table.pl](Pod_gff3_to_ucsc_table.md) script. This is useful, for example, when Ensembl releases a new genome update and UCSC hasn't yet, and your friends are using the [USeq](http://useq.sourceforge.net) package that requires a gene table.

## Score Data ##
These formats convey score information across the genome. These are numeric data formats associated with discrete genomic positions. The scores may represent microarray values, sequence tag counts, enrichment ratios, probability scores, etc.

### GFF and BED ###
Both GFF and BED files include a score column, allowing them to convey this data. However, these formats are not ideal for large amounts of information; primarily because they must be loaded into a SQL database. Other formats are simpler and faster.

### Wig file ###
Developed for use by the UCSC Genome Browser and adopted by virtually all other genome browsers, the [wiggle](http://genome.ucsc.edu/goldenPath/help/wiggle.html) file is a simple text file for exchanging dense quantitative data. The wig file has two formats.

The fixedStep format assumes regularly spaced datapoints along the chromosome, for example every 10 bp. It records a starting position, a step size, and a value for each stepped position along the length of the chromosome.

The variableStep format assumes irregularly spaced, but relatively dense, datapoints. It records the position and score value at each datapoint.

Wig files use base (1-base) numbering.

Most genome browsers compress the scores to 8-bit precision (256 values) or less, such that the retrieved value may not be identical to the original input value; This may be sufficient for browsing (where the generated plot can only show a limited amount of vertical resolution) but not ideal for analysis.

Wig files may be generated using the [data2wig.pl](Pod_data2wig.md) script. The **BioToolBox** analysis programs require that `.wig` files be converted to binary `.wib` files using the `wiggle2gff3.pl` script included with [GBrowse](http://www.gmod.org/wiki/GBrowse). The `.wib` files are accessed through a generated GFF3 file, which in turn must be loaded in a SQL or memory database. The `.wib` files only have 8-bit precision, making analysis adequate for most purposes but perhaps not ideal. Alternatively they can be converted to bigWig files using the [wigToBigWig](http://hgdownload.cse.ucsc.edu/admin/exe/) converter (see below).

### bedGraph ###
The [bedGraph](http://genome.ucsc.edu/goldenPath/help/bedgraph.html) file format is essentially a cross between the wig and BED files. It is used as a wig file, but looks like a BED file. It is a four-column, tab-delimited text file. The four columns are
  * chromosome
  * start
  * end
  * score
BedGraph files are meant for sparse data, unlike dense wig files, and also maintain numeric precision, at least in the [UCSC Genome Browser](http://genome.ucsc.edu/cgi-bin/hgGateway). They are also useful when your scores represent variable-sized regions and not single nucleotide points (although wig files do have a span option).

BedGraph files may be generated using the [data2bed.pl](Pod_data2bed.md) script. They use interbase (0-based) numbering.

To use BedGraph files, they must be converted to `.wib` files as with `.wig` files using the [wiggle2gff3.pl script](http://search.cpan.org/~lds/GBrowse-2.44/bin/wiggle2gff3.pl) included with GBrowse. Alternatively, they can be converted to bigWig files using the [bedGraphToBigWig](http://hgdownload.cse.ucsc.edu/admin/exe/) program.

### bigWig ###
Like the bigBed file, the [bigWig](http://genome.ucsc.edu/goldenPath/help/bigWig.html) file format is a compressed, indexed, binary format of the wig file developed by the UCSC genome center. It's primary advantage is for rapid, random access by a genome browser or analysis program, either remotely or locally. These files maintain the numeric precision and are much faster in accession than the old `.wib` files used by the Bio::Graphics module. Furthermore, they can be used by both GBrowse and **BioToolBox** analysis scripts. Their use is highly recommended.

BigWig files may be generated from either wig files using the [wigToBigWig](http://hgdownload.cse.ucsc.edu/admin/exe/) converter or from bedGraph files using the [bedGraphToBigWig](http://hgdownload.cse.ucsc.edu/admin/exe/) converter. The **BioToolBox** script [data2wig.pl](Pod_data2wig.md) also includes the option to generate bigWig files, as do several other scripts, including [bam2wig.pl](Pod_bam2wig.md) and [bar2wig.pl](Pod_bar2wig.md).

### BigWigSet directory ###
While not a format per se, this is a convenient collection of bigWig files that acts as a unified database. Simply, this is a directory containing two or more bigWig files and optionally a `metadata.txt` index file. When loaded, each bigWig file is assigned `type` and `display_name` attributes, and can be queried like any other BioPerl database. Additional attributes, such as `strand` or other identifying information, can be assigned using the `metadata.txt` index file. See the documentation for the [BigWigSet module](http://search.cpan.org/perldoc?Bio%3A%3ADB%3A%3ABigWigSet) for more information.

### Bar files ###
Bar files are binary, serial float files used by David Nix's [USeq](http://useq.sourceforge.net) and [T2](http://http://timat2.sourceforge.net/) suites of analysis programs. Each chromosome strand is represented by one bar file, so that a genome is represented by a directory of multiple bar files. The bar files are usually compressed with zip. Bar files internally store the score values along with an offset from the previous position. Unlike wig files, the format tolerates multiple values at the same position.

Bar files are not directly usable by any other genome browser other than [IGB](http://bioviz.org/igb/), necessitating their export to a more universal format, such as wig. It is recommended to convert Bar files to USeq format and use that directly.

### USeq files ###
[USeq archives](http://useq.sourceforge.net/useqArchiveFormat.html) (.useq) are indexed, compressed archives generated by David Nix's [USeq](http://useq.sourceforge.net) package and primarily developed for DAS/2 servers such as [GenoPub](http://bioserver.hci.utah.edu/BioInfo/index.php/Software:DAS2), as well as [IGB](http://bioviz.org/igb/). USeq archives can be generated from Bar files, wig files, BED files, or other text files using various utilities in the [USeq](http://useq.sourceforge.net) package.

USeq files can now be utilized directly with either **BioToolBox** or GBrowse without conversion to other formats.

### GR files ###
This is a simple text format generated by exporting Bar files to a text graph format. It is comprised of a two-column tab-delimited text format, position and score. Like Bar files, each file represents a single chromosome, and multiple values are tolerated at a single position. The [bar2wig.pl](Pod_bar2wig.md) script uses this as an intermediate when converting Bar files to wig files.

### SGR files ###
A variant of the GR file, it has three columns of data: chromosome, position, score. Thus an entire genome may be represented by a single file, unlike GR files.

## Next Generation Sequencing Data ##
With the advent of next generation sequencing such as [Illumina](http://www.illumina.com/), among others, comes the problem of disseminating large volumes of data. The data generated is in the form of millions of raw sequence reads, from 30 bp to hundreds of bp in length, and stored as FASTA or FASTQ files. These sequence tags are then aligned to a genome using any of a variety of fast sequence aligners. Most aligners output a native file format, usually a tab-delimited text file. Recently a de facto standard format has emerged, the SAM format.

### SAM file ###
The Sequence Alignment Map, or SAM, file is a tab-delimited text file representing the alignments of short sequence reads to a genome. The [SAMtools](http://samtools.sourceforge.net/) project is a collection of tools for working with and manipulating `.sam` files. Most aligners now export directly to `.sam` format, facilitating analysis and avoiding a conversion step. Because the format is text, it is relatively amenable to manipulation, but not to rapid, random data analysis. For this we convert to the BAM format.

### BAM file ###
This is a binary, compressed format of the SAM file. BAM files may be sorted and indexed, generating a second small bam index file (`*.bam.bai`). This allows for the alignments to be quickly searched, useful for displaying in a genome browser or performing data analysis.

BAM files may be generated from SAM files using the C-based [samtools](http://samtools.sourceforge.net/) program, or the Java-based [Picard](http://picard.sourceforge.net/). Both collections also include tools for sorting, indexing, manipulating, and viewing SAM and BAM files.

There are several **BioToolBox** scripts for working with bam files, including data analysis, conversions, and some manipulation.

### BAM coverage ###
While not a file format, many people are interested in where the sequence tags align and how many align to specific loci. A coverage map is simply a summation of the number of alignments at each position across the genome. It typically represents a count of alignments over each basepair in the genome, although alignments can also be counted only once at the alignment's midpoint or start point. Mathematical manipulations of the counts may also be performed.

There are several programs which will calculate genome coverage from a BAM file, including programs in the [Bio-Samtools](http://search.cpan.org/dist/Bio-SamTools/) module, [bedtools](http://code.google.com/p/bedtools) package, and [USeq](http://useq.sourceforge.net) package. The **BioToolBox** script [bam2wig.pl](Pod_bam2wig.md) will also calculate coverage as well as perform many other manipulations not present in the previously listed programs.

In most cases, you will want to output the coverage graph as a wig (or bigWig) file. The advantages of using a wig file are speed and efficiency. While the **BioToolBox** data analysis scripts and GBrowse use the Bio-SamTools module and can calculate coverage on demand from a BAM file, it does so by parsing through the alignments in BAM which can be time-consuming. Pre-calculating the coverage as a wig file and using that is substantially faster.