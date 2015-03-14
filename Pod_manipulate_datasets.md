_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
manipulate\_datasets.pl

A progam to manipulate tab-delimited data files.

## SYNOPSIS ##
manipulate\_datasets.pl `[`--options ...`]` <input\_filename>

```
  Options:
  --in <input_filename>
  --func [ reorder | delete | rename | new | number | concatenate | split | 
           sort | gsort | null | duplicate | above | below | specific | keep
           coordinate | cnull | absolute | minimum | maximum | log | delog | 
           format | pr | add | subtract | multiply | divide | combine | scale | 
           zscore | ratio | diff | normdiff | center | rewrite | export | 
           treeview | summary | stat ]
  --index <integers>
  --exp | --num <integer>
  --con | --den <integer>
  --target <text> or <number>
  --place [r | n]
  --(no)zero
  --dir [i | d]
  --name <text>
  --out <filename>
  --log
  --gz
  --version
  --help
  --doc
```
## OPTIONS ##
The command line flags and descriptions:

--in <input\_filename>


> Provide the name of an input file. The file must be a tab-delimited text file, with each row specifiying a genomic feature (gene) or region, and each column representing identifying information or a dataset value. The first row should include the name for each column, e.g. the name of the database dataset from which the values were collected.

> 
> If the file was generated using a BioToolBox script, then each column may have metadata stored in a header comment line at the beginning of the file. Manipulations on the data in a column dataset will be added to this metadata and recorded upon file write.

> 
> The input file may be compressed using the gzip program and recognized with  the extension '.gz'.

> 
--func <function>


> The program is designed to be run interactively. However, single manipulations  may be performed on single datasets by specifying a function name and any  other required options. These functions include the following.

> 
> _reorder_ _delete_ _rename_ _new_ _number_ _concatenate_ _split_ _coordinate_ _sort_ _gsort_ _null_ _duplicate_ _above_ _below_ _specific_ _keep_ _cnull_ _absolute_ _minimum_ _maximum_ _log_ _delog_ _format_ _pr_ _add_ _subtract_ _multiply_ _divide_ _combine_ _scale_ _zscore_ _ratio_ _diff_ _normdiff_ _center_ _rewrite_ _export_ _treeview_ _summary_ _stat_

> 
> Refer to the FUNCTIONS section for details.

> 
--index <integers>


> Provide the 0-based index number of the column(s) on which to perform the  function(s). Multiple indices may also be specified using a comma delimited  list without spaces. Ranges of contiguous indices may be specified using a  dash between the start and stop. For example, '1,2,5-7,9' would indicate  datasets '1, 2, 5, 6, 7, and 9'.

> 
--exp <integer>


--num <integer>


> Specify the 0-based index number to be used for the experiment or numerator  column with the 'ratio' or 'difference' functions. Both flags are aliases for the same thing.

> 
--con <integer>


--den <integer>


> Specify the 0-based index number to be used for the control or denominator  column with the 'ratio' or 'difference' functions. Both flags are aliases for the same thing.

> 
--target <string> or <number>


> Specify the target value when using various functions. This is a catch-all  option for a number of functions. Please refer to the function description  for more information.

> 
--place `[`r | n`]`


> Specify the placement of a transformed column. Two values are accepted ('r'  or 'n'):

> 
```
  - (r)eplace the original column with new values
  - add as a (n)ew column
```
> Defaults to new placement when executed automatically using the --func  option, or prompts the user when executed interactively.

> 
--(no)zero


> Specify that zero values should or should not be included when  calculating statistics or converting null values on a column. The default is  undefined, meaning the program may ask the user interactively whether to  include zero values or not.

> 
--dir `[`i | d`]`


> Specify the direction of a sort:

> 
```
  - (i)ncreasing
  - (d)ecreasing
```
--name <string>


> Specify a new column name when re-naming a column using the rename function  from the command line. Also, when generating a new column using a defined  function (--func <function>) from the command line, the new column will use  this name.

> 
--out <filename>


> Optionally provide an alternative output file name. If no name is provided,  then the input file will be overwritten with a new file. Appropriate  extensions will be appended as necessary.

> 
--log


> Indicate whether the data is (not) in log2 space. This is required to ensure  accurate mathematical calculations in some manipulations. This is not necessary  when the log status is appropriately recorded in the dataset metadata.

> 
--gz


> Indicate whether the output file should (not) be compressed. The appropriate extension will be  added. If this option is not specified, then the compression status of the input file will be  preserved.

> 
--version


> Print the version number.

> 
--help


> Display the POD documentation using perldoc.

> 
## DESCRIPTION ##
This program allows some common mathematical and other manipulations on one or more columns in a datafile. The program is designed as a simple replacement for common manipulations performed in a full featured spreadsheet program, e.g. Excel, particularly with datasets too large to be loaded, all in a conveniant command line program. The program is designed to be operated primarily as an interactive program, allowing for multiple manipulations to be performed. Alternatively, single manipulations may be performed as specified using command line options. As such, the program can be called in shell scripts.

Note that the datafile is loaded entirely in memory. For extremely large  datafiles, e.g. binned genomic data, it may be best to first split the  file into chunks (use `split_data_file.pl`), perform the manipulations,  and recombine the file (use `join_data_file.pl`). This could be done  through a simple shell script.

The program keeps track of the number of manipulations performed, and if  any are performed, will write out to file the changed data. Unless an  output file name is provided, it will overwrite the input file (NO backup is made!).

## FUNCTIONS ##
This is a list of the functions available for manipulating columns. These may  be selected interactively from the main menu (note the case sensitivity!),  or specified on the command line using the --func option.

_stat_ (menu option _t_)


> Print some basic statistics for a column, including mean,  median, standard deviation, min, and max. If 0 values are present, indicate whether to include them (y or n)

> 
_reorder_ (menu option _R_)


> The column may be rewritten in a different order. The new order  is requested as a string of index numbers in the desired order.  Also, a column may be deleted by skipping its number or duplicated by including it twice.

> 
_delete_ (menu option _D_)


> One or more column may be selected for deletion.

> 
_rename_ (menu option _n_)


> Assign a new name to a column. For automatic execution, use the --name  option to specify the new name. Also, for any automatically executed  function (using the --func option) that generates a new column, the  column's new name may be explicitly defined with this option.

> 
_number_ (menu option _b_)


> Assign a number to each datapoint (or line), incrementing from 1  to the end. The numbered column will be inserted after the requested  column index.

> 
_concatenate_ (menu option _C_)


> Concatenate the values from two or more columns into a single new  column. The character used to join the values may be specified  interactively or by the command line option --target (default is '`_`'  in automatic execution mode). The new column is appended at the end.

> 
_split_ (menu option _T_)


> Split a column into two or more new columns using a specified character  as the delimiter. The character may be specified interactively or  with the --target command line option (default is '`_`' in automatic  execution mode). The new columns are appended at the end. If the  number of split items are not equal amongst the rows, absent values  are appended with null values.

> 
_coordinate_ (menu option _O_)


> Generate a coordinate string from the chromosome, start, and, if  present, stop coordinate values as a new column. The string will  have the format "chr:start-stop" or "chr:start". This is useful  in making unique identifiers or working with genome browsers.

> 
_sort_ (menu option _o_)


> The entire data table is sorted by a specific column. The first datapoint is checked for the presence of letters, and the data  table is then sorted either asciibetically or numerically. If the  sort method cannot be automatically determined, it will ask. The  direction of sort, (i)ncreasing or (d)ecreasing, is requested.

> 
_gsort_ (menu option _g_)


> The entire data table is sorted by increasing genomic position,  first by chromosome then by start position. These columns must exist  and have recognizable names (e.g. 'chromo', 'chromosome', 'start').

> 
_null_ (menu option _N_)


> Delete rows that contain a null value in one or more  columns. Some of the other functions may not work properly if a non-value is present. If 0 values are present, indicate whether to toss them (y or n). This may also be specified as a command line  option using the --except flag.

> 
_duplicate_ (menu option _P_)


> Delete rows with duplicate values. One or more columns may be  selected to search for duplicate values. Values are simply concatenated  when multiple columns are selected. Rows with duplicated values are  deleted, always leaving the first row.

> 
_above_ (menu option _A_)


> Delete rows with values that are above a certain threshold value.  One or more columns may be selected to test values for the  threshold. The threshold value may be requested interactively or  specified with the --target option.

> 
_below_ (menu option _B_)


> Delete rows with values that are below a certain threshold value.  One or more columns may be selected to test values for the  threshold. The threshold value may be requested interactively or  specified with the --target option.

> 
_specific_ (menu option _S_)


> Delete rows with values that contain a specific value, either text  or number. One or more columns may be selected to check for values.  The specific values may be selected interactively from a list or  specified with the --target option.

> 
_keep_ (menu option _K_)


> Keep only those rows with values that contain a specific value,  either text or number. One or more columns may be selected to check  for values. The specific values may be selected interactively from a  list or specified with the --target option.

> 
_cnull_ (menu option _U_)


> Convert null values to a specific value. One or more columns may  be selected to convert null values. The new value may be requested  interactively or defined with the --target option.

> 
_absolute_ (menu option _G_)


> Convert signed values to their absolute value equivalents. One or  more columns may be selected to convert.

> 
_minimum_ (menu option _I_)


> Reset datapoints whose values are less than a specified minimum  value to the minimum value. One or more columns may be selected  to reset values to the minimum. The minimum value may be requested  interactively or specified with the --target option.

> 
_maximum_ (menu option _X_)


> Reset datapoints whose values are greater than a specified maximum  value to the maximum value. One or more columns may be selected  to reset values to the maximum. The maximum value may be requested  interactively or specified with the --target option.

> 
_add_ (menu option _a_)


> Add a value to a column. A real number may be supplied, or the words 'mean', 'median', or 'sum' may be entered as a proxy for those statistical values of the column. The column may either be replaced or added as a new one. For automatic execution, specify the number using the --target option.

> 
_subtract_ (menu option _u_)


> Subtract a value from a column. A real number may be supplied, or the words 'mean', 'median', or 'sum' may be entered as a proxy for those statistical values of the column. The column may either be replaced or added as a new one. For automatic execution, specify the number using the --target option.

> 
_multiply_ (menu option _y_)


> Multiply a column by a value. A real number may be supplied, or the words 'mean', 'median', or 'sum' may be entered as a proxy for those statistical values of the column. The column may either be replaced or added as a new one. For automatic execution, specify the number using the --target option.

> 
_divide_ (menu option _v_)


> Divide a column by a value. A real number may be supplied, or the words 'mean', 'median', or 'sum' may be entered as a proxy for those statistical values of the column. The column may either be replaced or added as a new one. For automatic execution, specify the number using the --target option.

> 
_scale_ (menu option _s_)


> A column may be a median scaled as a means of normalization  with other columns. The current median of the column requested is presented, and a new median target is requested. The column may  either be replaced with the median scaled values or added as a new  column. For automatic execution, specify the new median target  with the --target option.

> 
_pr_ (menu option _p_)


> A column may be converted to a percentile rank, whereby the data values are sorted in ascending order and assigned a new value  from 0..1 based on its rank in the sorted order. The column may  either be replaced with the percentile rank or added as a new column. The original order of the column is maintained.

> 
_zscore_ (menu option _Z_)


> Generate a Z-score or standard score for each value in a column. The Z-score is the number of standard deviations the value is away from the column's mean, such that the new mean is 0 and the standard  deviation is 1. Provides a simple method of normalizing columns with disparate dynamic ranges.

> 
_log_ (menu option _l_)


> A column may be converted to log values. The column may either  be replaced with the log values or added as a new column. Use  the --target option to specify the base (usually 2 or 10).

> 
_delog_ (menu option _L_)


> A column that is currently in log space may be converted back to normal numbers. The column may either be replaced with the  new values or added as a new column. Use the --target option to  specify the base (usually 2 or 10). The base may be obtained from the  metadata.

> 
_format_ (menu option _f_)


> Format the numbers of a column to a given number of decimal places.  An integer must be provided. The column may either be replaced or  added as a new column. For automatic execution, use the --target  option to specify the number decimal places.

> 
_combine_ (menu option _c_)


> Mathematically combine the data values in two or more columns. The  methods for combining the values include mean, median, min, max,  stdev, or sum. The method may be specified on the command line  using the --target option. The combined data values are added as a  new column.

> 
_ratio_ (menu option _r_)


> A ratio may be generated between two columns. The experiment and  control columns are requested and the ratio is added as a new column. For log2 numbers, the control is subtracted from the experiment. The log2 status is checked in the metadata for the  specified columns, or may be specified as a command line option, or asked of the user.

> 
_diff_ (menu option _d_)


> A simple difference is generated between two existing columns. The  values in the 'control' column are simply subtracted from the  values in the 'experimental' column and recorded as a new column. For enumerated columns (e.g. tag counts from Next Generation  Sequencing), the columns should be subsampled to equalize the sums  of the two columns. The indices for the experimental and control columns  may either requested from the user or supplied by the --exp and  --con command line options.

> 
_normdiff_ (menu option _z_)


> A normalized difference is generated between two existing columns.  The difference between 'control' and 'experimental' column values  is divided by the square root of the sum (an approximation of the  standard deviation). This is supposed to yield fewer false positives than a simple difference (see Nix et al, BMC Bioinformatics, 2008). For enumerated datasets (e.g. tag counts from Next Generation  Sequencing), the datasets should be subsampled to equalize the sums  of the two datasets. The indices for the experimental and control columns  may either requested from the user or supplied by the --exp and  --con command line options.

> 
_center_ (menu option _e_)


> Center normalize the datapoints in a row by subtracting the mean or median of the datapoints. The range of columns is requested or  provided by the --index option. Old values are replaced by new  values. This is useful for visualizing data as a heat map, for example.

> 
_new_ (menu option _w_)


> Generate a new column which contains an identical value for  each datapoint (row). The value may be either requested interactively or  supplied using the --target option. This function may be useful for  assigning a common value to all of the data points before joining the  data file with another.

> 
_summary_ (menu option _y_)


> Write out a summary of collected windowed data file, in which the mean  for each of the data columns is calculated, transposed (columns become  rows), and written to a new data file. This is essentially identical to  the summary function from the biotoolbox analysis scripts  [map\_relative\_data.pl](Pod_map_relative_data_pl.md) and [pull\_features.pl](Pod_pull_features_pl.md). It assumes that each  column has start and stop metadata. The program will automatically  identify available columns to summarize based on their name. In  interactive mode, it will request the contiguous range of start and  ending columns to summarize. The contiguous columns may also be  indicated using the --index option. By default, a new file using the  input file base name appended with '`_`summary' is written, or a  filename may be specified using the --out option.

> 
_export_ (menu option _x_)


> Export the data into a simple tab-delimited text file that contains no  metadata or header information. Non-values '.' are converted to   true nulls. If an output file name is specified using the --outfile  option, it will be used. Otherwise, a possible filename will be  suggested based on the input file name. If any modifications are  made to the data structure, a normal data file will still be written.  Note that this could overwrite the exported file if the output file name was specified on the command line, as both file write subroutines will  use the same name!

> 
_treeview_ (menu option _i_)


> Export the data to the CDT format compatible with both Treeview and  Cluster programs for visualizing and/or generating clusters. Specify the  columns containing a unique name and the columns to be analyzed (e.g.  --index <name>,<start-stop>). Extraneous columns are removed.  Additional manipulations on the columns may be performed prior to  exporting. These may be chosen interactively or using the codes  listed below and specified using the --target option.

> 
```
  su - decreasing sort by sum of row values
  sm - decreasing sort by mean of row values
  cg - median center features (rows)
  cd - median center datasets (columns)
  zd - convert columns to Z-scores
  pd - convert columns to percentile ranks
  L2 - convert values to log2
  n0 - convert nulls to 0.0
```
> A simple Cluster data text file is written (default file name  "<basename>.cdt"), but without the GWEIGHT column or EWEIGHT row. The  original file will not be rewritten.

> 
_rewrite_ (menu option _W_)


> Force the data file contents to be re-written. Useful if you want to  write an intermediate file during numerous interactive manipulations.  Consider this as a 'Save as...'.

> 
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
