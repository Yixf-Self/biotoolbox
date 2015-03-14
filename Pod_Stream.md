_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
Bio::ToolBox::Data::Stream - Read, Write, and Manipulate Data File Line by Line

## SYNOPSIS ##
```
  use Bio::ToolBox::Data;
```
```
  ### Open a pre-existing file
  my $Stream = Bio::ToolBox::Data->new(
        file    => 'regions.bed',
        stream  => 1,
  );
```
```
  # or directly
  my $Stream = Bio::ToolBox::Data::Stream->new(
        file    => 'regions.bed',
  );
```
```
```
```
  ### Working line by line
  while (my $line = $Stream->next_line) {
  	  # get the positional information from the file data
  	  # assuming that the input file had these identifiable columns
  	  # each line is Bio::ToolBox::Data::Feature item
  	  my $seq_id = $line->seq_id;
  	  my $start  = $line->start;
  	  my $stop   = $line->end;
```
```
  	  # change values
  	  $line->value(1, 100); # index, new value
  }
```
```
```
```
  ### Working with two file streams
  my $inStream = Bio::ToolBox::Data::Stream->new(
        file    => 'regions.bed',
  );
  my $outStream = $inStream->duplicate('regions_ext100.bed');
  my $sc = $inStream->start_column;
  my $ec = $inStream->end_column;
  while (my $line = $inStream->next_line) {
      # adjust positions by 100 bp
      my $s = $line->start;
      my $e = $line->end;
      $line->value($sc, $s - 100);
      $line->value($ec, $e + 100);
      $outStream->write_row($line);
  }
```
```
```
```
  ### Finishing
  # close your file handles when you are done
  $Stream->close_fh;
```
## DESCRIPTION ##
This module works similarly to the [Bio::ToolBox::Data](Pod_Bio_ToolBox_Data.md) object, except that  rows are read from a file handle rather than a memory structure. This  allows very large files to be read, manipulated, and even written without  slurping the entire contents into a memory.

For an introduction to the [Bio::ToolBox::Data](Pod_Bio_ToolBox_Data.md) object and methods, refer to  its documentation and the [Bio::ToolBox::Data::Feature](Pod_Bio_ToolBox_Data_Feature.md) documentation.

Typically, manipulations are only performed on one row at a time, not on an  entire table. Therefore, large scale table manipulations, such as sorting, is  not possible.

A typical workflow consists of opening two Stream objects, one for reading and  one for writing. Rows are read, one at a time, from the read Stream, manipulated  as necessary, and then written to the write Stream. Each row is passed as a  [Bio::ToolBox::Data::Feature](Pod_Bio_ToolBox_Data_Feature.md) object. It can be manipulated as such, or the  corresponding values may be dumped as an array. Working with the row data  as an array is required when adding or deleting columns, since these manipulations  are not allowed with a Feature object. The write Stream can then be passed  either the Feature object or the array of values to be written.

```
```
## METHODS ##
### Initializing the structure ###
new()


> Create a new Bio::ToolBox::Data::Stream object. For simplicity, a new file  may also be opened using the [Bio::ToolBox::Data](Pod_Bio_ToolBox_Data.md) new function.

> 
```
	my $Stream = Bio::ToolBox::Data->new(
	   stream       => 1,
	   file         => $filename,
	);
```
> Options to the new function are listed below. Streams are inherently either  read or write mode, determined by the mode given through the options.

> 
> file => $filename

> 
> > Provide the path and name of the file to open. File types are recognized by  the extension, and compressed files (.gz) are supported. File types supported  include all those listed in [Bio::ToolBox::file\_helper](Pod_Bio_ToolBox_file_helper.md). Files are  checked for existence. Existing files are assumed to be read, and non-existent  files are assumed to be written, unless otherwise specified by the mode  option. This option is required.

> 
> > 

> overwrite => boolean

> 
> > If a file exists and you wish to overwrite, pass this option with a true value.

> 
> > 

> columns => `[`qw(Column1 Column2 ...)`]`

> 
> > When a new file is written, provide the names of the columns as an  anonymous array.

> 
> > 
duplicate($filename)



> For an opened-to-read Stream object, you may duplicate the object as a new  opened-to\_write Stream object that maintains the same columns and metadata.  A new different filename must be provided.

> 
### General Metadata ###
There is a variety of general metadata regarding the Data structure that  is available.

The following methods may be used to access or set these  metadata properties. Note that metadata is only written at the beginning  of the file, and so must be set prior to iterating through the file.

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
### Column Metadata ###
Information about the columns may be accessed. This includes the  names of the column and shortcuts to specific identifiable columns,  such as name and coordinates. In addition, each column may have  additional metadata. Each metadata is a series of key =>  value pairs. The minimum keys are 'index' (the 0-based index  of the column) and 'name' (the column header name). Additional  keys and values may be queried or set as appropriate. When the  file is written, these are stored as commented metadata lines at  the beginning of the file. Setting metadata is futile after  reading or writing has begun.

list\_columns


> Returns an array or array reference of the column names  in ascending (left to right) order.

> 
number\_columns


> Returns the number of columns in the Data table.

> 
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
### Modifying Columns ###
These methods allow modification to the number and order of the  columns in a Stream object. These methods can only be employed  prior to opening a file handle for writing, i.e. before the first  write\_row() method is called. This enables one, for example, to  duplicate a read-only Stream object to create a write-only Stream,  add or delete columns, and then begin the row iteration.

add\_column($name)


> Appends a new column at the rightmost position (highest  index). It adds the column header name and creates a  new column metadata hash. Pass a text string representing  the new column name. It returns the new column index if  successful.

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
### Row Data Access ###
Once a file Stream object has been opened, and metadata and/or  columns adjusted as necessary, then the file contents can be  iterated through, one row at a time. This is typically a one-way  direction. If you need to go back or start over, the easiest thing  to do is re-open the file as a new Stream object.

There are two main methods, next\_row() for reading and write\_row()  for writing. They cannot and should not be used on the same Stream  object.

next\_row()


> This method reads the next line in the file handle and returns a  [Bio::ToolBox::Data::Feature](Pod_Bio_ToolBox_Data_Feature.md) object. This object represents the  values in the current file row.

> 
> Note that strand values and 0-based start coordinates are automatically  converted to BioPerl conventions if required by the file type.

> 
add\_row()


write\_row()


> This method writes a new row or line to a file handle. The first  time this method is called the file handle is automatically opened for  writing. Up to this point, columns may be manipulated. After this point,  columns cannot be adjusted (otherwise the file structure becomes  inconsistent).

> 
> This method may be implemented in one of three ways, based on the type  data that is passed.

> 
> A <Bio::ToolBox::Data::Feature> object

> 
> > A Feature object representing a row from another <Bio::ToolBox::Data>  data table or Stream. The values from this object will be automatically  obtained. _Note:_ Only pass this object if the number and names of the columns  are identical between read and write Streams, otherwise very strange  things may happen! If you modify the number of columns, then use the second  approach below. Modified strand and 0-based coordinates may be adjusted back  as necessary.

> 
> > 

> An array of values

> 
> > Pass an array of values. The number of elements should match the number  of expected columns. The values will be automatically joined using tabs.  This implementation should be used if you using values from another Stream  and the number of columns have been modified.

> 
> > 
> > Manipulation of strand and 0-based starts may be performed if the  metadata indicates this should be done.

> 
> > 

> A string

> 
> > Pass a text string. This assumes the values are already concatenated.  A new line character is appended if one is not included. No data  manipulation (strand or 0-based starts) or sanity checking of the  required number of columns is performed. Use with caution!

> 
> > 
### File Handle methods ###
The below methods work with the file handle. When you are finished with  a Stream, you should be kind and close the file handle properly.

mode



> Returns the write mode of the Stream object. Read-only objects  return false (0) and write-only Stream objects return true (1).

> 
close\_fh


> Closes the file handle.

> 
fh


> Returns the [IO::File](Pod_IO_File.md) compatible file handle object representing  the file handle. Use with caution.

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
