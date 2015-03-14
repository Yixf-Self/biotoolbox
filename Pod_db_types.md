_This page was generated from POD using [pod2gcw](http://code.google.com/p/pod2gcw) and is not intended for editing._

## NAME ##
db\_types.pl

A script to print out the available feature types in a database.

## SYNOPSIS ##
db\_types.pl <database>

```
  Options:
  --db <database>
  --version
  --help
```
## OPTIONS ##
The command line flags and descriptions:

--db <database>


> Specify the name of a `Bio::DB::SeqFeature::Store` annotation database  from which gene or feature annotation may be derived. If not specified,  then a list of known databases in the BioToolBox configuration file  `.biotoolbox.cfg` will be presented as a list to the user.

> 
> For more information about using annotation databases,  see <https://code.google.com/p/biotoolbox/wiki/WorkingWithDatabases>.

> 
--version


> Print the version number.

> 
--help


> Display this POD documentation.

> 
## DESCRIPTION ##
This program will print a list of all of the known feature types present  in a Bio::DB::SeqFeature::Store database. The types are organized into  groups by their source tag.

BigWigSet databases, comprised of a directory of BigWig files and a  metadata file, are also supported.

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
