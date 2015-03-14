_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
Bio::ToolBox::Data - Reading, writing, and manipulating data structure

## SYNOPSIS ##
```
  use Bio::ToolBox::Data;
```
```
  ### Create new gene list from database
  my $Data = Bio::ToolBox::Data->new(
        db      => 'hg19',
        feature => 'gene:ensGene',
  );
```
```
  my $Data = Bio::ToolBox::Data->new(
        db      => 'hg19',
        feature => 'genome',
        win     => 1000,
        step    => 1000,
  );
```
```
```
```
  ### Open a pre-existing file
  my $Data = Bio::ToolBox::Data->new(
        file    => 'coordinates.bed',
  );
```
```
```
```
  ### Get a specific value
  my $value = $Data->value($row, $column);
```
```
```
```
  ### Replace or add a value
  $Data->value($row, $column, $new_value);
```
```
```
```
  ### Iterate through a Data structure one row at a time
  my $stream = $Data->row_stream;
  while (my $row = $stream->next_row) {
  	  # get the positional information from the file data
  	  # assuming that the input file had these identifiable columns
  	  my $seq_id = $row->seq_id;
  	  my $start  = $row->start;
  	  my $stop   = $row->end;
```
```
  	  # generate a Bio::Seq object from the database using 
  	  # these coordinates 
  	  my $region = $db->segment($seq_id, $start, $stop);
```
```
  	  # modify a row value
  	  my $value = $row->value($column);
  	  my $new_value = $value + 1;
  	  $row->value($column, $new_value);
  }
```
```
```
```
  ### write the data to file
  my $success = $Data->write_file(
       filename     => 'new_data.txt',
       gz           => 1,
  );
  print "wrote new file $success\n"; # file is new_data.txt.gz
```
## DESCRIPTION ##
This module works with the primary Bio::ToolBox Data structure. Simply, it  is a complex data structure representing a tabbed-delimited table (array  of arrays), with plenty of options for metadata. Many common bioinformatic  file formats are simply tabbed-delimited text files (think BED and GFF).  Each row is a feature or genomic interval, and each column is a piece of  information about that feature, such as name, type, and/or coordinates.  We can append to that file additional columns of information, perhaps  scores from genomic data sets. We can record metadata regarding how  and where we obtained that data. Finally, we can write the updated  table to a new file.

## METHODS ##
### Initializing the structure ###
new()


> Initialize a new Data structure. This generally requires options,  provided as an array of key => values. A new list of features  may be obtained from an annotation database or an existing file  may be loaded. If you do not pass any options, a new empty  structure will be generated for you to populate.

> 
> These are the options available.

> 
> file => $filename

> 
> > Provide the path and name to an existing tabbed-delimited text  file. BED and GFF files and their variants are accepted. Except  for structured files, e.g. BED and GFF, the first line is  assumed to be column header names. Commented lines (beginning  with #) are parsed as metadata. The files may be compressed  (gzip or bzip2).

> 
> > 

> feature => $type

> 
> feature => "$type:$source"

> 
> feature => 'genome'

> 
> > For de novo lists from an annotation database, provide the GFF  type or type:source (columns 3 and 2) for collection. A comma  delimited string may be accepted (not an array).

> 
> > 
> > For a list of genomic intervals across the genome, specify a  feature of 'genome'.

> 
> > 

> db => $name

> 
> db => $path

> 
> db => $database\_object

> 
> > Provide the name of the database from which to collect the  features. It may be a short name, whereupon it is checked in  the Bio::ToolBox configuration file `.biotoolbox.cfg` for  connection information. Alternatively, a path to a database  file or directory may be given.

> 
> > 
> > If you already have an opened Bio::DB::SeqFeature::Store database  object, you can simply pass that. See Bio::ToolBox::db\_helper for  more information. However, this in general should be discouraged,  since the name of the database will not be properly recorded when  saving to file. It is better to simply pass the name of database  again; multiple connections to the same database are smartly handled  in the background.

> 
> > 

> win => $integer

> 
> step => $integer

> 
> > If generating a list of genomic intervals, optionally provide  the window and step values. Default values are defined in  the Bio::ToolBox configuration file `.biotoolbox.cfg`.

> 
> > 

> columns => `[`qw(Column1 Column2 ...)`]`

> 
> datasets => `[`qw(Column1 Column2 ...)`]`

> 
> > When no file is given or database given to search, then a new,  empty Data object is returned. In this case, you may optionally  provide the column names in advance as an anonymous array. You  may also optionally provide a general feature name, if desired.

> 
> > 

> If successful, the method will return a Bio::ToolBox::Data object.
### General Metadata ###
There is a variety of general metadata regarding the Data  structure.

The following methods may be used to access or set these  metadata properties.

feature()


feature($text)


> Returns or sets the name of the features used to collect  the list of features. The actual feature types are listed  in the table, so this metadata is merely descriptive.

> 
feature\_type


> Returns one of three specific values describing the contents  of the data table inferred by the presence of specific column  names. This provides a clue as to whether the table features  represent genomic regions (defined by coordinate positions) or  named database features. The return values include:

> 
> coordinate: Table includes at least chromosome and start

> 
> named: Table includes name, type, and/or Primary\_ID

> 
> unknown: unrecognized

> 
program($name)


> Returns or sets the name of the program generating the list.

> 
database($name)


> Returns or sets the name or path of the database from which the  features were derived.

> 
The following methods may be used to access metadata only.

gff


bed


> Returns the GFF version number or the number of BED columns  indicating that the Data structure is properly formatted as  such. A value of 0 means they are not formatted as such.

> 
### File information ###
filename($text)


> Returns or sets the filename for the Data structure. If you set  a new filename, the path, basename, and extension are  automatically derived for you. If a path was not provided,  the current working directory is assumed.

> 
path


basename


extension


> Returns the full path, basename, and extension of the filename.  Concatenating these three values will reconstitute the  original filename.

> 
### Comments ###
Comments are the other commented lines from a text file (lines  beginning with a #) that were not parsed as metadata.

comments


> Returns a copy of the array containing commented lines.

> 
add\_comment($text)


> Appends the text string to the comment array.

> 
delete\_comment


delete\_comment($index)


> Deletes a comment. Provide the array index of the comment to  delete. If an index is not provided, ALL comments will be deleted!

> 
### The Data table ###
The Data table is the array of arrays containing all of the  actual information.

list\_columns


> Returns an array or array reference of the column names  in ascending (left to right) order.

> 
number\_columns


> Returns the number of columns in the Data table.

> 
last\_row


> Returns the array index number of the last row.  Since the header row is index 0, this is also the  number of actual content rows.

> 
column\_values($index)


> Returns an array or array reference representing the values  in the specified column. This includes the column header as  the first element. Pass the method the column index.

> 
add\_column($name)


add\_column(\@column\_data)


> Appends a new column to the Data table at the  rightmost position (highest index). It adds the column  header name and creates a new column metadata hash.  Pass the method one of two possibilities. Pass a text  string representing the new column name, in which case  no data will be added to the column. Alternatively, pass  an array reference, and the contents of the array will  become the column data. If the Data table already has  rows, then the passed array reference must have the same  number of elements.

> 
> It returns the new column index if successful.

> 
copy\_column($index)


> This will copy a column, appending the duplicate column at  the rightmost position (highest index). It will duplicate  column metadata as well. It will return the new index  position.

> 
delete\_column($index1, $index2, ...)


> Deletes one or more specified columns. Any remaining  columns rightwards will have their indices shifted  down appropriately. If you had identified one of the  shifted columns, you may need to re-find or calculate  its new index.

> 
reorder\_column($index1,  $index, ...)


> Reorders columns into the specified order. Provide the  new desired order of indices. Columns could be duplicated  or deleted using this method. The columns will adopt their  new index numbers.

> 
add\_row


add\_row(\@values)


> Add a new row of data values to the end of the Data table.  Optionally provide a reference to an array of values to  put in the row. The array is filled up with `undef` for  missing values, and excess values are dropped.

> 
delete\_row($row1, $row2, ...)


> Deletes one or more specified rows. Rows are spliced out  highest to lowest index to avoid issues. Be very careful  deleting rows while simultaneously iterating through the  table!

> 
row\_values($row)


> Returns a copy of an array for the specified row index.  Modifying this returned array does not migrate back to the  Data table; Use the value method below instead.

> 
value($row, $column)


value($row, $column, $new\_value)


> Returns or sets the value at a specific row or column index. Index positions are 0-based (header row is index 0).

> 
### Column Metadata ###
Each column has metadata. Each metadata is a series of key =>  value pairs. The minimum keys are 'index' (the 0-based index  of the column) and 'name' (the column header name). Additional  keys and values may be queried or set as appropriate. When the  file is written, these are stored as commented metadata lines at  the beginning of the file.

name($index)


> Convenient method to return the name of the column given the  index number.

> 
metadata($index, $key)


metadata($index, $key, $new\_value)


> Returns or sets the metadata value for a specific $key for a  specific column $index.

> 
> This may also be used to add a new metadata key. Simply provide  the name of a new $key that is not present

> 
> If no key is provided, then a hash or hash reference is returned  representing the entire metadata for that column.

> 
copy\_metadata($source, $target)


> This method will copy the metadata (everything except name and  index) between the source column and target column. Returns 1 if  successful.

> 
delete\_metadata($index, $key);


> Deletes a column-specific metadata $key and value for a specific  column $index. If a $key is not provided, then all metadata keys  for that index will be deleted.

> 
find\_column($name)


> Searches the column names for the specified column name. This  employs a case-insensitive grep search, so simple substitutions  may be made.

> 
chromo\_column


start\_column


stop\_column


strand\_column


name\_column


type\_column


id\_column


> These methods will return the identified column best matching  the description. Returns `undef` if that column is not present.  These use the find\_column() method with a predefined list of  aliases.

> 
### Efficient Data Access ###
Most of the time we need to iterate over the Data table, one row  at a time, collecting data or processing information. These methods  simplify the process.

iterate(sub {})


> This method will process a code reference on every row in the data  table. Pass a subroutine or code reference. The subroutine will  receive the row as a Bio::ToolBox::Data::Feature object. With this  object, you can retrieve values, set values, and add new values.  For example

> 
```
    $Data->iterate( sub {
       my $row = shift;
       my $number = $row->value($index);
       my $log_number = log($number);
       $row->value($index, $log_number);
    } );
```
row\_stream()


> This returns an Bio::ToolBox::Data::Iterator object, which has one  method, next\_row(). Call this method repeatedly until it returns  `undef` to work through each row of data.

> 
> Users of the Bio::DB family of database adaptors may recognize the  analogy to the seq\_stream() method.

> 
next\_row()


> Called from a Bio::ToolBox::Data::Iterator object, it returns a  Bio::ToolBox::Data::Feature object. This object represents the  values in the current Data table row.

> 
> An example using the iterator is shown below.

> 
```
  my $stream = $Data->row_stream;
  while (my $row = $stream->next_row) {
     # each $row is a Bio::ToolBox::Data::Feature object
     # representing the row in the data table
     my $value = $row->value($index);
     # do something with $value
  }
```
### Data Table Functions ###
These methods alter the Data table en masse.

verify()


> This method will verify the Data structure, including the metadata and the  Data table. It ensures that the table has the correct number of rows and  columns as described in the metadata, and that each column has the basic  metadata.

> 
> If the Data structure is marked as a GFF or BED structure, then the table  is checked that the structure matches the proper format. If not, for  example when additional columns have been added, then the GFF or BED value  is set to null.

> 
> This method is automatically called prior to writing the Data table to file.

> 
sort\_data($index, $direction);


> This method will sort the Data table by the values in the indicated column.  It will automatically determine whether the contents of the column are  numbers or alphanumeric, and will sort accordingly, either numerically or  asciibetically. The first non-null value in the column is used to determine.  The sort may fail if the values are not consistent. Pass a second optional  value to indicate the direction of the sort. The value should be either  'i' for 'increasing' or 'd' for 'decreasing'. The default order is  increasing.

> 
gsort\_data


> This method will sort the Data table by increasing genomic coordinates. It  requires the presence of chromosome and start (or position) columns,  identified by their column names. These are automatically identified.  Failure to find these columns mean a failure to sort the table. Chromosome  names are sorted first by their digits (e.g. chr2 before chr10), and then  alphanumerically. Base coordinates are sorted by increasing value.  Identical positions are kept in their original order.

> 
splice\_data($current\_part, $total\_parts)


> This method will splice the Data table into $total\_parts number of pieces,  retaining the $current\_part piece. The other parts are discarded. This  method is intended to be used when a program is forked into separate  processes, allowing each child process to work on a subset of the original  Data table.

> 
> Two values are passed to the method. The first is the current part number,  1-based. The second value is the total number of parts that the table  should be divided, corresponding to the number of concurrent processes.  One easy approach to forking is to use [Parallel::ForkManager](Pod_Parallel_ForkManager.md). The  example below shows how to fork into four concurrent processes.

> 
```
	my $Data = Bio::ToolBox::Data->new(file => $file);
	my $pm = Parallel::ForkManager->new(4);
	for my $i (1..4) {
		$pm->start and next;
		### in child ###
		$Data->splice_data($i, 4);
		# do something with this portion
		# then save to a temporary unique file
		$Data->save("$file_$i");
		$pm->finish;
	}
	$pm->wait_all_children;
	# reload children files
	$Data->reload_children(glob "$file_*");
```
> Since each forked child process is separate from their parent process,  their contents must be reloaded into the current Data object. The  [Parallel::ForkManager](Pod_Parallel_ForkManager.md) documentation recommends going through a disk  file intermediate. Therefore, write each child Data object to file using  a unique name. Once all children have been reaped, they can be reloaded  into the current Data object using the reload\_children() method.

> 
> Remember that if you fork your script into child processes, any database  connections must be re-opened; they are typically not clone safe. If you  have an existing database connection by using the open\_database() method,  it should be automatically re-opened for you when you use the splice\_data()  method, but you will need to call open\_database() again in the child  process to obtain the new database object.

> 
reload\_children(@children\_files)


> Discards the current data table in memory and reloads two or more files  written from forked children processes. Provide the name of the child  files in the order you want them loaded. The files will be automatically  deleted if successfully loaded. Returns the number of lines reloaded on  success.

> 
### File Functions ###
When you are finished modifying the Data table, it may then be written out  as a tabbed-delimited text file. If the format corresponds to a valide BED or  GFF file, then it may be written in that format.

Several functions are available for writing the Data table, exporting to a  compatible GFF file format, or writing a summary of the Data table.

save()


write\_file()


write\_file($filename)


write\_file(%options)


> These methods will write the Data structure out to file. It will  be first verified as to proper structure. Opened BED and GFF files  are checked to see if their structure is maintained. If so, they  are written in the same format; if not, they are written as regular  tab-delimited text files. You may pass additional options.

> 
> filename => $filename

> 
> > Optionally pass a new filename. Required for new objects; previous  opened files may be overwritten if a new name is not provided. If  necessary, the file extension may be changed; for example, BED files  that no longer match the defined format lose the .bed and gain a .txt  extension. Compression may or add or strip .gz as appropriate. If  a path is not provided, the current working directory is used.

> 
> > 

> gz => boolean

> 
> > Change the compression status of the output file. The default is to  maintain the status of the original opened file.

> 
> > 

> If the file save is successful, it will return the full path and  name of the saved file, complete with any changes to the file extension.
summary\_file(%options)


> Write a separate file summarizing columns of data (mean values).  The mean value of each column becomes a row value, and each column  header becomes a row identifier (i.e. the table is transposed). The  best use of this is to summarize the mean profile of windowed data  collected across a feature. See the Bio::ToolBox scripts  [get\_relative\_data.pl](Pod_get_relative_data_pl.md) and [average\_gene.pl](Pod_average_gene_pl.md) as examples.  You may pass these options.

> 
> filename => $filename

> 
> > Pass an optional new filename. The default is to take the basename  and append "`_`summed" to it.

> 
> > 

> startcolumn => $index

> 
> stopcolumn => $index

> 
> > Provide the starting and ending columns to summarize. The default  start is the leftmost column without a recognized standard name.  The default ending column is the last rightmost column. Indexes are  0-based.

> 
> > 

> If successful, it will return the name of the file saved.
### Verifying Datasets ###
When working with row Features and collecting scores, the dataset  from which you are collecting must be verified prior to collection.  This ensures that the proper database adaptor is available and loaded,  and that the dataset is correctly specified (otherwise nothing would be  collected). This verification is normally performed transparently when  you call [get\_score](Pod_Bio_ToolBox_Data_Feature.md)() or  [get\_position\_scores](Pod_Bio_ToolBox_Data_Feature.md)(). However, datasets may be explicitly verified prior to calling the score  methods.

verify\_dataset($dataset)


verify\_dataset($dataset, $database)


> Pass the name of the dataset (GFF type or type:source) for a GFF3-based  database, e.g. <Bio::DB::SeqFeature::Store>, or path and file name for a  data file, e.g. Bam, BigWig, BigBed, or USeq file. If a separate database  is being used, pass the name or opened database object as a second  parameter. For more advance options, see  ["verify\_or\_request\_feature\_types" in Bio::ToolBox::db\_helper](Pod_Bio_ToolBox_db_helper.md).

> 
> The name of the verified dataset, with a prefix if necessary, is returned.

> 
## AUTHOR ##
```
 Timothy J. Parnell, PhD
 Dept of Oncological Sciences
 Huntsman Cancer Institute
 University of Utah
 Salt Lake City, UT, 84112
```
This package is free software; you can redistribute it and/or modify it under the terms of the GPL (either version 1, or at your option, any later version) or the Artistic License 2.0.
