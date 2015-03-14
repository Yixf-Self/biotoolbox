# Main Programs #

List of programs included in the main CPAN distribution. These are organized by function.

### Data (score) collection ###
  * [get\_datasets.pl](Pod_get_datasets.md) - Collect single data value for features
  * [get\_relative\_data.pl](Pod_get_relative_data.md) - Collect data in bins flanking a specific point relative to a feature
  * [get\_binned\_data.pl](Pod_get_binned_data.md) - Collect data in defined bins across a feature

### Data file manipulation ###
  * [manipulate\_datasets.pl](Pod_manipulate_datasets.md) - Interactive column, row, and statistical manipulation of data files
  * [merge\_datasets.pl](Pod_merge_datasets.md) - Merge columns from two or more data files into one
  * [split\_data\_file.pl](Pod_split_data_file.md) - Split a large data file into two or more smaller files based on criteria
  * [join\_data\_file.pl](Pod_join_data_file.md) - Concatenate rows in two or more data files into one
  * [pull\_features.pl](Pod_pull_features.md) - Pull out rows from a data file based on a list of names

### Data analysis ###
  * [graph\_data.pl](Pod_graph_data.md) - Generate xy plots between two columns of data
  * [graph\_profile.pl](Pod_graph_profile.md) - Generate profile graph across static positions
  * [graph\_histogram.pl](Pod_graph_histogram.md) - Generate distribution histogram plots from columns of data
  * [data2frequency.pl](Pod_data2frequency.md) - Convert column values to a frequency distribution
  * [run\_cluster.pl](Pod_run_cluster.md) - Generate k-means clusters for datasets
  * [change\_cluster\_order.pl](Pod_change_cluster_order.md) - Change the order of k-means clusters from random to meaningful
  * [correlate\_position\_data.pl](Pod_correlate_position_data.md) - Calculate positional correlation between two datasets

### File format conversion ###
  * [bam2wig.pl](Pod_bam2wig.md) - Generate many styles of coverage maps based on sequence alignments
  * [data2wig.pl](Pod_data2wig.md) - Convert any data table into a UCSC-style wig file
  * [data2bed.pl](Pod_data2bed.md) - Convert any data table file into a UCSC-style bed file
  * [data2gff.pl](Pod_data2gff.md) - Convert any data table file into a GFF file
  * [data2fasta.pl](Pod_data2fasta.md) - Convert any data table file into a multi-fasta file
  * [wig2data.pl](Pod_wig2data.md) - Convert any wig file into a standard data table file

### Obtaining genome annotation ###
  * [db\_setup.pl](Pod_db_setup.md) - Quick and easy annotation database setup using UCSC annotation
  * [db\_types.pl](Pod_db_types.md) - Print a list of feature types in an annotation database
  * [ucsc\_table2gff3.pl](Pod_ucsc_table2gff3.md) - Convert UCSC annotation tables into feature-rich GFF3 files
  * [get\_ensembl\_annotation.pl](Pod_get_ensembl_annotation.md) - Export Ensembl annotation as feature-rich GFF3 files
  * [gff3\_to\_ucsc\_table.pl](Pod_gff3_to_ucsc_table.md) - Convert a GFF3 file to an UCSC annotation table

### Finding features and annotation ###
  * [get\_features.pl](Pod_get_features.md) - Get a list of features from an annotation database
  * [get\_feature\_info.pl](Pod_get_feature_info.md) - Get additional information for annotated features
  * [get\_gene\_regions.pl](Pod_get_gene_regions.md) - Get a list of implicit or calculated regions based on gene annotation
  * [get\_intersecting\_features.pl](Pod_get_intersecting_features.md) - Find annotation in a database that intersects regions
  * [find\_enriched\_regions.pl](Pod_find_enriched_regions.md) - Find regions across a genome whose score values exceed a threshold

### Sequence manipulation ###
  * [filter\_bam.pl](Pod_filter_bam.md) - Filter a bam file of sequence alignments based on various criteria
  * [CpG\_calculator.pl](Pod_CpG_calculator.md) - Calculate observed and predicted CpG frequency over regions


# Extra programs #

Additional programs available through SVN only. These are specialized, out-of-date, or no longer useful scripts. Some people may still find these useful.

  * [bin\_genomic\_data.pl](Pod_bin_genomic_data.md) - Collate genomic datasets into binned data
  * [compare\_subfeature\_scores.pl](Pod_compare_subfeature_scores.md) - Compare the scores of subfeatures
  * [bam2gff\_bed.pl](Pod_bam2gff_bed.md) - Covert Bam sequence alignments to a bed or gff file
  * [bar2wig.pl](Pod_bar2wig.md) - Convert USeq or T2 Bar files to wig files
  * [map\_transcripts.pl](Pod_map_transcripts.md) - Identify transcript start and stop sites from transcriptome data
  * [ucsc\_cytoband2gff3.pl](Pod_ucsc_cytoband2gff3.md) - Convert UCSC cytoband tables into GFF3 for GBrowse
  * [convert\_yeast\_genome\_version.pl](Pod_convert_yeast_genome_version.md) - Convert positional data between different yeast versions
  * [get\_actual\_nuc\_sizes.pl](Pod_get_actual_nuc_sizes.md) - Calculate actual nucleosome sizes from paired-end sequencing data
  * [get\_bam\_seq\_stats.pl](Pod_get_bam_seq_stats.md) - Calculate sequence stats from a Bam file
  * [novo\_wrapper.pl](Pod_novo_wrapper.md) - Pseudo parallel novoalign wrapper
  * [split\_bam\_by\_isize.pl](Pod_split_bam_by_isize.md) - Split a Bam file based on paired-end insert size
  * [intersect\_nucs.pl](Pod_intersect_nucs.md) - Intersect two sets of nucleosome files
  * [map\_nucleosomes.pl](Pod_map_nucleosomes.md) - Identify nucleosome positions from MNase sequencing
  * [verify\_nucleosome\_mapping.pl](Pod_verify_nucleosome_mapping.md) - Verify mapped nucleosome positions with original data
  * [map\_oligo\_data2gff.pl](Pod_map_oligo_data2gff.md) - Associate microarray oligo values with genomic positions
  * [process\_microarray.pl](Pod_process_microarray.md) - Quantile normalization of raw microarray data for Agilent, GenePix, and Nimblegen formats
  * [intersect\_SNPs.pl](Pod_intersect_SNPs.md) - Intersect SNPs in two or more VCF files to find common and unique
  * [locate\_SNPs.pl](Pod_locate_SNPs.md) - Locate SNPs relative to gene annotation and identify mutation impact
  * [big\_file2gff3.pl](Pod_big_file2gff3.md) - Generate a GFF3 file and GBrowse conf stanzas for big files
  * [change\_chr\_prefix.pl](Pod_change_chr_prefix.md) - Change a chromosome prefix for a variety of data file formats

