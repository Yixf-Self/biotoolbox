#!/usr/bin/perl

# documentation at end of file

use strict;
use Pod::Usage;
use Getopt::Long;
use Bio::ToolBox::Data::Stream;
use Bio::ToolBox::utility;
my $VERSION =  '1.41';

print "\n This script will split a data file by features\n\n";


### Quick help
unless (@ARGV) { 
	# when no command line options are present
	# print SYNOPSIS
	pod2usage( {
		'-verbose' => 0, 
		'-exitval' => 1,
	} );
}



### Get command line options and initialize values
my (
	$infile, 
	$index,
	$tag,
	$max,
	$gz,
	$prefix,
	$help,
	$print_version,
);

# Command line options
GetOptions( 
	'in=s'        => \$infile, # specify the input data file
	'index|col=i' => \$index, # index for the column to use for splitting
	'tag=s'       => \$tag, # attribute tag name
	'max=i'       => \$max, # maximum number of lines per file
	'prefix=s'    => \$prefix, # output file prefix
	'gz!'         => \$gz, # compress output files
	'help'        => \$help, # request help
	'version'     => \$print_version, # print the version
) or die " unrecognized option(s)!! please refer to the help documentation\n\n";

# Print help
if ($help) {
	# print entire POD
	pod2usage( {
		'-verbose' => 2,
		'-exitval' => 1,
	} );
}

# Print version
if ($print_version) {
	print " Biotoolbox script split_data_file.pl, version $VERSION\n\n";
	exit;
}





### Check for required values
unless ($infile) {
	$infile = shift @ARGV or
		die "  No input file specified! \n use $0 --help\n";
}
unless (defined $gz) {
	if ($infile =~ /\.gz$/) {
		# input file is compressed, so keep it that way
		$gz = 1;
	}
	else {
		$gz = 0;
	}
}


### Load Input file
my $Input = Bio::ToolBox::Data::Stream->new(in => $infile) or
	die "Unable to open input file!\n";

# Identify the column
unless (defined $index or defined $tag) {
	$index = ask_user_for_index($Input, 
		"  Enter the column index number containing the values to split by   ");
	unless (defined $index) {
		die " Must provide a valid index!\n";
	}
}
if ($tag) {
	unless ($Input->gff or $Input->vcf) {
		die " Input file must be in GFF or VCF format to use attribute tags!";
	}
	if ($Input->vcf and not defined $index) {
		die " Please provide a column index for accessing VCF attributes.\n" . 
			" The INFO column is 0-based index 7, and sample columns begin\n" . 
			" at index 9.\n";
	}
	elsif ($Input->gff) {
		$index = 8;
	}
}


### Split the file
printf " Splitting file by elements in column %s%s...\n", 
	$Input->name($index), 
	$tag ? ", attribute tag $tag" : "";
my %out_files; # a hash of the file names written
	# we can't assume that all the data elements we're splitting on are 
	# contiguous in the file
	# if they're not, then we would be simply re-writing over the 
	# previous block
	# also, we're enforcing a maximum number of lines per file
	# so we'll remember the files we've written, and re-open that file 
	# to write the next block of data
my $split_count = 0;
while (my $row = $Input->next_row) {
	
	# Get the check value
	my $check;
	if ($tag) {
		my $attrib = $row->attributes;
		$check = $attrib->{$tag} || $attrib->{$index}{$tag} || undef;
	}
	else {
		$check = $row->value($index);
	}
	unless (exists $out_files{$check}{'stream'}) {
		request_new_file_name($check);
	}
	
	# write the row
	$out_files{$check}{'stream'}->add_row($row);
	$out_files{$check}{'number'} += 1;
	$out_files{$check}{'total'} += 1;
	
	# Check the number of lines collected, close if necessary
	if (defined $max and $out_files{$check}{'number'} == $max) {
		# we've reached the maximum number of data lines for this current data
		$out_files{$check}{'stream'}->close_fh;
		delete $out_files{$check}{'stream'};
	}
}



### Finish
# Properly close out all file handles
$Input->close_fh;
foreach my $value (keys %out_files) {
	$out_files{$value}{'stream'}->close_fh if exists $out_files{$value}{'stream'};
}

# report
print " Split '$infile' into $split_count files\n";
foreach my $value (sort {$a cmp $b} keys %out_files) {
	printf "  wrote %s lines in %d file%s for '$value'\n", 
		format_with_commas( $out_files{$value}{total} ), $out_files{$value}{parts}, 
		$out_files{$value}{parts} > 1 ? 's' : '';
}




sub request_new_file_name {
	# calculate a new file name based on the current check value and part number
	my $value = shift;
	my $filename_value = $value;
	$filename_value =~ s/[\:\|\\\/\+\*\?\#\(\)\[\]\{\} ]+/_/g; 
		# replace unsafe characters
	
	my $file;
	if ($prefix and $prefix eq 'none') {
		$file = $Input->path . $filename_value;
	}
	elsif ($prefix) {
		$file = $prefix . '#' . $filename_value;
	}
	else {
		$file = $Input->path . $Input->basename . '#' . $filename_value;
	}
	
	# add the file part number, if we're working with maximum line files
	# padded for proper sorting
	if (defined $max) {
		if (defined $out_files{$value}{'parts'}) {
			$out_files{$value}{'parts'} += 1; # increment
			$file .= '_' . sprintf("%03d", $out_files{$value}{'parts'});
		}
		else {
			$out_files{$value}{'parts'} = 1; # initial
			$file .= '_' . sprintf("%03d", $out_files{$value}{'parts'});
		}
	}
	else {
		# only 1 part is necessary
		$out_files{$value}{'parts'} = 1;
	}
	
	# finish the file name
	$file .= $Input->extension;
	$out_files{$value}{'number'} = 0;
	
	# open an output Stream
	if (exists $out_files{$value}{'stream'}) {
		# an open stream, close it
		$out_files{$value}{'stream'}->close_fh;
	}
	my $Stream = $Input->duplicate($file);
	$out_files{$value}{'stream'} = $Stream;
	
	# check the total
	unless (exists $out_files{$value}{'total'}) {
		$out_files{$value}{'total'}  = 0;
	}
	
	# keept track of the number of files opened
	$split_count++;
}



__END__

=head1 NAME

split_data_file.pl

A script to split a data file by rows based on common data values.

=head1 SYNOPSIS

split_data_file.pl [--options] <filename>
  
  Options:
  --in <filename>               (txt bed gff gtf vcf refFlat ucsc etc)
  --index <column_index>
  --tag <text>
  --max <integer>
  --prefix <text>
  --gz
  --version
  --help                        show extended documentation

=head1 OPTIONS

The command line flags and descriptions:

=over 4

=item --in <filename>

Specify the file name of a data file. It must be a tab-delimited text file. 
The file may be compressed with gzip.

=item --index <column_index>

Provide the index number of the column or dataset containing the values 
used to split the file. If not specified, then the index is requested 
from the user in an interactive mode.

=item --tag <text>

Provide the attribute tag name that contains the values to split the 
file. Attributes are supported by GFF and VCF files. If splitting a 
VCF file, please also provide the column index. The INFO column is 
index 7, and sample columns begin at index 9.

=item --max <integer>

Optionally specify the maximum number of data lines to write to each 
file. Each group of specific value data is written to one or more files. 
Enter as an integer; underscores may be used as thousands separator, e.g. 
100_000. 

=item --prefix <text>

Optionally provide a filename prefix for the output files. The default 
prefix is the input filename base name. If no prefix is desired, using 
just the values as filenames, then set the prefix to 'none'.

=item --gz

Indicate whether the output files should be compressed 
with gzip. Default behavior is to preserve the compression 
status of the input file.

=item --version

Print the version number.

=item --help

Display the POD documentation

=back

=head1 DESCRIPTION

This program will split a data file into multiple files based on common 
values in the data table. All rows with the same value will be 
written into the same file. A good example is chromosome, where all 
data points for a given chromosome will be written to a separate file, 
resulting in multiple files representing each chromosome found in the 
original file. The column containing the values to split and group 
should be indicated; if the column is not sepcified, it may be 
selected interactively from a list of column headers. 

This program can also split files based on an attribute tag in GFF or 
VCF files. Attributes are often specially formatted delimited key value 
pairs associated with each feature in the file. Provide the name of the 
attribute tag to split the file. Since attributes may vary based on 
the feature type, an interactive list is not supplied from which to 
choose the attribute.

If the max argument is set, then each group will be written to one or 
more files, with each file having no more than the indicated maximum 
number of data lines. This is useful to keep the file size reasonable, 
especially when processing the files further and free memory is 
constrained. A reasonable limit may be 100K or 1M lines.

The resulting files will be named using the basename of the input file, 
appended with the unique group value (for example, the chromosome name)
demarcated with a #. If a maximum line limit is set, then the file part 
number is appended to the basename, padded with zeros to three digits 
(to assist in sorting). Each file will have duplicated and preserved 
metadata. The original file is preserved.

This program is intended as the complement to 'join_data_files.pl'.

=head1 AUTHOR

 Timothy J. Parnell, PhD
 Howard Hughes Medical Institute
 Dept of Oncological Sciences
 Huntsman Cancer Institute
 University of Utah
 Salt Lake City, UT, 84112

This package is free software; you can redistribute it and/or modify
it under the terms of the Artistic License 2.0.  
