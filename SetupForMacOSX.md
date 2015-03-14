# Preparing a Mac OS X computer for bioinformatics analysis #

These are notes specific for Mac OS X computers. For general information about setting up BioToolBox, please either the [Quick Guide](QuickGuide.md) or the main [Set Up Guide](BioToolBoxSetUp.md).

## Contents ##
  1. [Prerequisites](SetupForMacOSX#Prerequisites.md)
  1. [Mac OS X Version Specific Notes](SetupForMacOSX#Mac_OS_X_Version_Specific_Notes.md)
    1. [Notes for OS X 10.6 Snow Leopard](SetupForMacOSX#Notes_for_OS_X_10.6_Snow_Leopard.md)
    1. [Notes for OS X 10.7 Lion](SetupForMacOSX#Notes_for_OS_X_10.7_Lion.md)
    1. [Notes for OS X 10.8 Mountain Lion](SetupForMacOSX#Notes_for_OS_X_10.8_Mountain_Lion.md)
    1. [Notes for OS X 10.9 Mavericks](SetupForMacOSX#Notes_for_OS_X_10.9_Mavericks.md)
  1. [A note about backups](SetupForMacOSX#A_note_about_backups.md)
  1. [Installing the Command Line Tools](SetupForMacOSX#Installing_the_Command_Line_Tools.md)
  1. [Using Fink or MacPorts](SetupForMacOSX#Using_Fink_or_MacPorts.md)
    1. [Setting up Fink](SetupForMacOSX#Setting_up_Fink.md)
      1. [Special notes for Mac OS X 10.6 only](SetupForMacOSX#Special_notes_for_Mac_OS_X_10.6_only.md)
    1. [Using Fink](SetupForMacOSX#Using_Fink.md)
    1. [Installing other programs with Fink](SetupForMacOSX#Installing_other_programs_with_Fink.md)
  1. [Installing a database](SetupForMacOSX#Installing_a_database.md)
    1. [Using Mac OS X Server MySQL](SetupForMacOSX#Using_Mac_OS_X_Server_MySQL.md)
    1. [Installing MySQL on a client system](SetupForMacOSX#Installing_MySQL_on_a_client_system.md)
  1. [Installing GD Libraries](SetupForMacOSX#Installing_GD_Libraries.md)
  1. [Installing Perl modules](SetupForMacOSX#Installing_Perl_modules.md)
    1. [Notes on machine architecture](SetupForMacOSX#Notes_on_machine_architecture.md)
    1. [Errors regarding GD](SetupForMacOSX#Errors_regarding_GD.md)
  1. [Installing GBrowse](SetupForMacOSX#Installing_GBrowse.md)
    1. [GBrowse Prerequisites](SetupForMacOSX#GBrowse_Prerequisites.md)
      1. [Start the Apache web server](SetupForMacOSX#Start_the_Apache_web_server.md)
    1. [Install GBrowse](SetupForMacOSX#Install_GBrowse.md)
    1. [Setting up FastCGI with GBrowse](SetupForMacOSX#Setting_up_FastCGI_with_GBrowse.md)
      1. [FastCGI on 10.6 Snow Leopard](SetupForMacOSX#FastCGI_on_10.6_Snow_Leopard.md)
      1. [FastCGI on 10.7 or later](SetupForMacOSX#FastCGI_on_10.7_or_later.md)
      1. [FastCGI Permissions](SetupForMacOSX#FastCGI_Permissions.md)
    1. [Setting up GBrowse user accounts](SetupForMacOSX#Setting_up_GBrowse_user_accounts.md)
      1. [Setting up PAM Authentication with OS X accounts](SetupForMacOSX#Setting_up_PAM_Authentication_with_OS_X_accounts.md)
    1. [Cleaning up after GBrowse](SetupForMacOSX#Cleaning_up_after_GBrowse.md)
  1. [Additional Tools](SetupForMacOSX#Additional_Tools.md)
    1. [Compiling a 64-bit liftOver tool on OS X](SetupForMacOSX#Compiling_a_64-bit_liftOver_tool_on_OS_X.md)
    1. [Installing Python via Fink](SetupForMacOSX#Installing_Python_via_Fink.md)
      1. [Installing MACS](SetupForMacOSX#Installing_MACS.md)
    1. [Installing mfold](SetupForMacOSX#Installing_mfold.md)

## Prerequisites ##
  1. A relative familiarity with command line usage in the terminal. Users should be able to move around and understand the file system directory, view and manipulate files, run programs, etc. There are both online and dead-tree resources available to learn this. You can access the command line from the Terminal.app located in `/Applications/Utilities`.
  1. You will need to install the Command Line Tools from Apple. You can obtain them one of three ways. See [SetupForMacOSX# ] below for more information.
  1. Access to an account with administrator privileges is recommended, especially if want to use Fink or MacPorts to install additional software (recommended). These package managers keep everything localized to a single directory (`/sw` for Fink, `/opt` for MacPorts) and never touches system directories.
  1. A good text editor. Microsoft Word will not do, and TextEdit is too limited. I prefer the free and quite capable [TextWrangler](http://www.barebones.com/products/textwrangler/), but several other competent editors also exist. For simple editing on the command line, try the `nano` editor.

## Mac OS X Version Specific Notes ##
This guide was initially written with 10.6 in mind, and subsequently updated with each new version. I usually tend to wait to the 10.x.2 release to upgrade, so that the initial bugs can be ironed out before sacrificing a work computer to the whims of Apple. Since we're dealing mostly with Unix stuff, there's not much change between the versions, so most of what is written here should be applicable. If not, Google is your friend.

### Notes for OS X 10.6 Snow Leopard ###
  1. Perl can be run as either a 32 or 64 bit executable, primarily dependent on your CPU. Running as 64-bit is preferred as it can speed some things up, but more importantly it allows for more memory usage (some of these data files can consume GB of RAM!). By default, on a 64-bit computer with 10.6, perl should automatically execute Perl 5.10.0 as a 64-bit executable and you shouldn't have to do anything. But you'll need to know this when installing Fink below.
  1. The Developer Tools can be found on the System Installation disk or from Apple's Developer website. Sorry, no XCode from the Mac App Store for you (some may consider that a good thing!).

### Notes for OS X 10.7 Lion ###
  1. The default Perl is now 5.12.3. The 5.10 version used in OS X 10.6 Snow Leopard is still there, but unfortunately the upgrade process removes all of your previously installed modules in the main root Library. You might as well use the default Perl 5.12, as you will have to reinstall all your Modules. You can view a list of your installed modules by entering "`perldoc perllocal`" in the terminal prior to upgrading.
  1. If you're updating from a 10.6 system, note that there is no official upgrade path and that you will have to destroy your Fink installation and re-install everything again. Read their [upgrade page](http://www.finkproject.org/download/10.7-upgrade.php) for more information on how to make this slightly less painful. Also note, Fink no longer maintains separate source trees (stable and unstable) under the 10.7 vesion as it did under previous OS X versions.
  1. The FastCGI module for the Apache web server is no longer included. See [Setting up FastCGI with GBrowse](SetupForMacOSX#Setting_up_FastCGI_with_GBrowse.md) for more information.

### Notes for OS X 10.8 Mountain Lion ###
  1. The default Perl is now 5.12.4. Yes, the 10.8 Installer will still wipe out your main /Library/Perl directories and all your installed modules from your previous version, so be prepared to spend some time in CPAN re-installing modules. You can view a list of your installed modules by entering "`perldoc perllocal`" in the terminal prior to upgrading.
  1. If you are upgrading to 10.8, it is possible to maintain your Fink installation. The Fink project web site has some notes on keeping your Fink installation during updating. Go to their [10.8 upgrade page](http://www.finkproject.org/download/10.8-upgrade.php) for more information.
  1. Since Fink uses Perl 5.12.3 and OS X 10.8 now has 5.12.4 installed, it looks like Fink will install its own Perl for its own use. They do not have a plain `perl` executable, so it shouldn't execute preferentially over the system perl.
  1. The graphical Web Sharing option was removed from the Sharing panel in System Preferences. You will need to start, stop, and restart Apache from the command line. See [Starting the Apache web server](SetupForMacOSX#Start_the_Apache_web_server.md) for more information.
  1. If you want to install FastCGI using mod\_fcgid, there is a bug with XCode when compiling code using apxs configuration detailed [here](http://apple.stackexchange.com/questions/58186/how-to-compile-mod-wsgi-mod-fastcgi-etc-on-mountain-lion-by-fixing-apxserror). Make the appropriate symbolic link described therein, and the build should work. See [Setting up FastCGI with GBrowse](SetupForMacOSX#Setting_up_FastCGI_with_GBrowse.md) for more information.

### Notes for OS X 10.9 Mavericks ###
  1. The default Perl is now 5.16.4. At least Apple is keeping up with Perl distributions, which is more than can be said about some linux distributions (looking at you, Red Hat). Local perl libraries should be mostly ok, although modules installed in the system directories will have to be re-installed again.
  1. As of this writing, there is no upgrade path for a Fink installation to 10.9, which means, you guessed it, you have to wipe and reinstall ... everything `<sigh>`. Head over to the [Fink upgrade](http://www.finkproject.org/download/10.9-upgrade.php) page for some guidance. I would recommend copying the `/sw/var/mysql` to a safe place before wiping, so that you can simply copy the tables back and get back up to speed quickly (only do this if your mysql was up to date in the first place). You can also copy `/sw/src` to save a little time with downloading packages.
  1. Most other stuff, including `/etc`, `/usr/local`, etc. should be safe.

## A note about backups ##
Macs have a very handy integrated backup solution called Time Machine. While Time Machine works well with typical user files contained within their home directory, it doesn't always work so well with other, Unix-y things. Be prepared when you find something has not been restored properly. A full restore should work reasonably well; however, migrating from a Time Machine disk to a new installation or computer is much less thorough. For example, Perl modules are not restored (just like an upgrade), unrecognized files in `/var/lib` and anything in `/var/tmp` (default locations for GBrowse installations) are skipped, and not everything under `/usr/` is included. When restoring or migrating, be prepared to re-install a few or a lot of things. While Time Machine certainly has its benefits, also consider full disk cloning software as an alternative that may be less headache-inducing.

## Installing the Command Line Tools ##
Many of the software packages we will be installing come only as source code. Therefore, it is **essential** to install the Command Line Tools for XCode. These include the necessary tools for compiling code into executable programs, including GNU make, a C compiler, and necessary libraries.

There are few different ways to install it.
  1. Download the Command Line Tools from the [Apple Developer](https://developer.apple.com/opensource/) website. This will require a free Developer account from Apple.
  1. On Mac OS X 10.9 Mavericks **only**, run the command "`xcode-select --install`" from the terminal. This should present a graphical prompt to install the Command Line Tools. Sweet!
  1. Install XCode from Mac App Store. It is currently free. Select this option only if you are interested in developing programs for Mac or iOS, as it is a hefty amount of disk space. Once it is installed, select the Command Line Tools from the Downloads tab in the XCode preferences.
  1. Mac OS X 10.6 Snow Leopard users will have to install the full XCode, available from the [Apple Developer](https://developer.apple.com/) site or maybe your install disc.

You will need to run a few commands to work with the Command Line Tools, particularly Fink (below). Enter this command, assuming XCode is in the default Applications folder.
<pre>
xcode-select -switch /Applications/Xcode.app/Contents/Developer<br>
</pre>

Next you must accept their license on the command line (yes, you already did this with the App version, but Apple feels compelled to put as many licenses in front of you as possible).
<pre>
sudo xcodebuild -license<br>
</pre>
Scroll to the bottom and accept it.

## Using Fink or MacPorts ##
[Fink](http://www.finkproject.org/) and [MacPorts](http://www.macports.org) are convenient package managers for installing numerous open source software packages on Mac OS X, usually by building them from source code. Using a package manager makes installation, upgrading, and removal of third party software much easier. This is particularly important when the software you want has a ton of dependencies, since these are automatically handled for you.

Deciding which one to use is up to you. Fink (I believe) has been around longer, but MacPorts appears to be a popular alternative. One thing to keep in mind is that Fink tries to reuse many of the default Mac OS X libraries and executables whenever possible, whereas MacPorts seems to bring in everything on its own, which can create duplicates in your system. This can be good in that you always get newer versions, but more complicated because you have to keep track of which version is executed.

There is a third alternative, [Homebrew](http://brew.sh), which seems to be much more bare bones compared to the fancy full-featured package managers of Fink and MacPorts.

For historical reasons, I will describe Fink, as that is what I use, but the concepts are similar with MacPorts.

### Setting up Fink ###
To install Fink, [download](http://www.finkproject.org/download/srcdist.php) the source file and follow their instructions. In general, run the following commands after downloading, extracting, and moving into the fink directory.
<pre>
sudo ./bootstrap<br>
/sw/bin/pathsetup.sh<br>
sudo fink selfupdate<br>
sudo fink index -f<br>
</pre>

Fink installs into the `/sw` directory by default. This makes it convenient by completely isolating Fink software from the system directories, preventing potential conflicts and overwrites. MacPorts accomplishes the same thing by installing in `/opt`.

For every user account on the computer, each user must run the following command just once to set up the Fink environment and use the programs installed through Fink.
<pre>
/sw/bin/pathsetup.sh<br>
</pre>

#### Special notes for Mac OS X 10.6 only ####
If you’ll be running 64-bit programs (e.g. default Perl 5.10 under Mac OS X 10.6), you must set up Fink to be 64-bit as well! In the source install, it will ask you this question at the beginning.

The various software packages available to Fink users under 10.6 only are primarily found in two different source trees, _stable_ and _unstable_. The versions in the stable tree are usually older, but in theory more reliable. Unfortunately, not everything I want is included in the stable tree, necessitating looking in the unstable tree. I find that many programs are only found under the unstable tree, which, despite the name, are often quite usable. These are always the latest versions.

To enable the unstable tree, edit the file `/sw/etc/fink.conf`. Find the line that begins with "Trees:" edit the line to look like the following.
<pre>
Trees: local/main stable/main stable/crypto unstable/main unstable/crypto<br>
</pre>

### Using Fink ###
To find a program to install, run the following command.
<pre>
fink list <program><br>
</pre>

To list installed programs, run
<pre>
fink list -i<br>
</pre>

To install the program you want, run the following command. Fink will identify necessary prerequisites and offer to install those as well. Always accept those.
<pre>
fink install <program><br>
</pre>

You can learn more by running "`fink --help`".

### Installing other programs with Fink ###
There are a number of cool programs you can obtain through Fink besides the ones listed elsewhere below. One tool that may be of interest to bioinformaticists is [EMBOSS](http://emboss.sourceforge.net/). This is an excellent collection of various useful tools for molecular biology. It can take a while to compile, as there are many dependencies and programs.

Another generally useful tool is `wget`, which can be used to download file(s) using http and ftp protocols from the commandline, without going through a browser.

## Installing a database ##
GBrowse as well as many of the BioToolBox programs require genome annotation to be put into a database. There are several choices.

SQLite is a lightweight database system that stores all of the database tables in a single file. It's reasonably fast and easy to manage - one file per database. This is by far the easiest solution to use.

MySQL is a commonly used open source database that can be used from small databases to large enterprise databases. It uses a daemon to handle multiple simultaneous connections and read/write transactions. Note that if you are using Mac OS X Server, MySQL comes pre-installed for you.

PostGreSQL is another alternative open source database with capabilities similar to MySQL. I don't personally have any experience with it, but it is supported by BioPerl. If you want to use PostGreSQL, you'll have to look elsewhere for help installing it (I'm sure it's not hard).

### Using Mac OS X Server MySQL ###
If you happen to be using the Server version (and not the normal client version installed on everyday consumer Macs), then MySQL should already be installed. There are couple things to note.

First, the standard socket location is different between Apple's Server MySQL and a typical install; you'll need to establish a symbolic link for `/var/mysql/mysql.sock` to the standard location of `/tmp/mysql.sock`. You may want to set up a simple startup bash script to do this for you at each restart.

Second, you'll need to install the MySQL development headers, which are not included by default. For Mac OS X Server 10.6, check out this Apple support [document](http://support.apple.com/kb/HT4006).

Note that I am not familiar with versions of Mac OS X Server later than 10.6, so this information may be limited or out of date.

### Installing MySQL on a client system ###
You can download an installation package from the main [MySQL](http://www.mysql.com) web site. While installing just the pre-compiled version is tempting, it probably won't work very well later on. The reason is that to install the Perl database driver modules you'll need some developer headers that are only included with the source install. So you will need to install from source and compile the executable for your machine. You can do this one of two ways; download the source files from the MySQL web site and follow their directions, or you can use Fink.

To install MySQL through Fink, enter the following:
<pre>
sudo fink install mysql-unified mysql-unified-client mysql-unified-dev mysql-unified-shlibs<br>
</pre>

To make things easier, I also like to install the [MySQL GUI Workbench](http://www.mysql.com/downloads/workbench/). This is especially helpful when you're not familiar with MySQL language and commands but need to set up databases, add users, and set permissions.

Once it's installed, start up MySQL by running the following command
<pre>
sudo mysqld_safe –u root &<br>
</pre>
The "`&`" symbol at the end forces the server process to run in the background, allowing you to exit your Terminal session and still keep it running. Make sure you have used `sudo` in the past minute or so and authenticate with your password; try running "`sudo ls`" prior to this command. Otherwise, by forcing it to background, you may never see the command prompt for `sudo`.

Set the MySQL root password.
<pre>
mysqladmin –u root -p password 'your_new_password'<br>
</pre>
Since this is a new install, you will not have an old password, so just push return when it prompts you for the old password.

An important note here. The MySQL server has its own notion of root that is separate from the computer's. So the above commands require two separate passwords (which could be the same word if you want): one for the Mac administrator's `sudo` or root access, and the other for MySQL root access.

Test by starting the client. The "`-p`" option causes it to prompt for the MySQL password for the user "root". Exit the client by typing "`exit`" at the prompt.
<pre>
mysql –u root –p<br>
</pre>

To have MySQL to start up automatically after every reboot, we use the daemonic utility, which should have been installed automatically by Fink along with MySQL (if not, you may have to install it by hand). Once the MySQL server is running, run this command:
<pre>
sudo daemonic enable mysql<br>
</pre>

There should now be a startup plist file in `/Library/StartupItems/`. Now the MySQL Server daemon should start everytime when you reboot your Mac, and saves you from running the `mysqld_safe` command everytime.

## Installing GD Libraries ##
These are needed primarily by Bio::Graphics and GBrowse, but some of my graphing programs also use it.

You can install GD from [source](https://bitbucket.org/pierrejoye/gd-libgd/overview), but note that you'll also have to install a number of other dependencies first.

Another alternative is to download Mac OS X binaries compiled by a member of the GMOD team, which you can find [here](http://sourceforge.net/projects/gmod/files/Generic%20Genome%20Browser/libgd-MacOSX/). This should work.

The third approach, and one that I favor, is to install them through Fink. Begin by running
<pre>
sudo fink install gd2 gd2-shlibs<br>
</pre>

It should also install `libjpeg` and `libpng`, along with the appropriate libraries.

## Installing Perl modules ##
For the most part, installing Perl modules on a Mac is not much different than any other unix-based computer. There are basically three different places where Perl modules may live.
  1. The system-installed Perl is located in `/System/Library/Perl`, which you basically cannot touch, nor should you ever.
  1. The site library is located at `/Library/Perl`, which is where modules will be installed when you use the `sudo` option. These libraries are specific to your version of Perl; upgrading the OS will likely upgrade the system Perl, hence all of these modules will have to be re-installed. If you plan on [installing GBrowse](SetupForMacOSX#Installing_GBrowse.md), or you have a multi-user lab Mac, you should install your modules here using admin rights.
  1. If you are single user on a personal Mac and don't plan on installing GBrowse, then the simplest and easiest option is to install your Perl modules in your home directory using `local::lib`. These libraries, for the most part, will be unaffected when you upgrade the OS. Please refer to the
  1. Technically, a fourth place to install modules is in a brand new Perl installation, either in your home directory, or someplace general, such as `/usr/local/`. You can use [Perlbrew](http://perlbrew.pl) to manage and install newer versions of Perl.

For more detailed information on [installing Perl modules](BioToolBoxSetUp#Installing_Perl_Modules.md), either in your [home directory](BioToolBoxSetUp#Installing_locally.md) or Site directory, or even [installing your own Perl](BioToolBoxSetUp#Using_PerlBrew_to_install_a_new_Perl.md), please refer to the main BioToolBox [setup guide](BioToolBoxSetUp.md).

#### Notes on machine architecture ####
Note that on Mac, many executables, including Perl oddly enough, are built with executable code for multiple machine architectures, including PowerPC (ppc), 32-bit Intel (i386), and 64-bit Intel (x86\_64). Typically, only one is executed; for modern Macs, that would be x86\_64. You may note occasional errors when compiling C code extensions that certain architectures are missing; these are mostly harmless and can be safely ignored.

#### Errors regarding GD ####
Note that on Mac OS X using libGD installed through Fink, I generally see test errors when installing the GD Perl module. I have been able to "`force install`" (ignoring the errors), and everything seems to still work. It seems to be just a bug with the test scripts, not with GD itself. Be forewarned.

## Installing GBrowse ##
[GBrowse](http://gmod.org/wiki/GBrowse) is a web-based generic genome browser that can display genome annotation and genomic data from microarray or next generation sequencing.

### GBrowse Prerequisites ###
Before you begin, you will likely need to install a few more Perl modules. You can install them through CPAN as above, or let the GBrowse installer let you do it for you (see below).
  * `CGI::Session`
  * `Text::ParseWords`
  * `JSON`
  * `Capture::Tiny`
  * `Bio::Graphics`
There may or may not be others, but the GBrowse installer will notify you of missing modules.

#### Start the Apache web server ####
**Important!** You will need to turn on the Apache web server. You can use the Sharing tab of System Preferences (only for OS X 10.6 or 10.7) or from the command line (required for OS X 10.8). Use the following commands to control Apache. These must be done as root (prepend with `sudo`).
  * start Apache: "`apachectl start`"
  * stop Apache: "`apachectl stop`"
  * restart Apache: "`apachectl restart`" or "`apachectl graceful`" (preferred)
  * check configuration: "`apachectl configtest`"

### Install GBrowse ###
GBrowse is now available through CPAN. However, I actually find it easier to install it from the command line, rather than through the CPAN Shell. The reason being is there is a configuration step that I simply find a little easier to use on the command line. Download the package from [here](http://search.cpan.org/dist/GBrowse/) and unpack it in a temporary directory. Move into the directory, and begin the build process
<pre>
perl Build.PL<br>
</pre>

Take note of any missing required Perl modules and remedy as necessary. You will undoubtedly have missing recommended prerequisites, most of which you can safely ignore. You can install manually through CPAN, or you can have the Build script install any missing dependencies by using this command.
<pre>
./Build installdeps<br>
</pre>

Next comes the configuration part. The configuration is automatically started when you run the `./Build` command, or you can start it by running
<pre>
./Build config<br>
</pre>
The script will ask a series of questions. It should be safe to accept the default locations for everything; however, feel free to change if you desire. One change you may want to note is the Apache user should be "`_www`" instead of the default "`www`".

Next, compile and build the browser. Run
<pre>
./Build<br>
./Build test<br>
</pre>
The second command will run a series of tests to make sure things are ok. When it finishes, you should see a "`Result: PASS`" statement. If it says "`FAIL`", then there are obviously issues that need to be rectified. Sometimes simply re-running the test may work. More often than not it's a missing or out of date prerequisite. One thing to note is that you may see lots of error messages go by, but still get a `PASS`. These are mostly harmless.

If you are satisfied with the test, install the browser.
<pre>
sudo ./Build install<br>
</pre>
There are a few things to keep in mind. First, the install script will ask to restart Apache. It usually doesn't succeed if you let it, so I always do it myself. Run "`sudo apachectl graceful`" to restart it from the command line.

Second, the permissions are rarely set correctly on the temp and library folders, so you may need to double check these. If you accepted the defaults, these should be `/var/lib/gbrowse2` and `/var/tmp/gbrowse2`. To set them manually, try this
<pre>
sudo chown -R _www:_www /var/lib/gbrowse2<br>
sudo chown -R _www:_www /var/tmp/gbrowse2<br>
</pre>

Third, verify that the Build install added a new Apache configuration file in `/etc/apache2/other/`, probably named `gbrowse2.conf` (not to be confused with a similarly named file in `/etc/gbrowse2/`). On Mac OS X Server, the file should be in `/etc/apache2/sites/` (I think). This file adds additional definitions, aliases, and permissions for the GBrowse CGI scripts. It will be loaded by an `Include` statement in the main Apache configuration file `/etc/apache2/httpd.conf`. If, for some reason, this file is missing, you can generate the file by running
<pre>
./Build apache_conf > gbrowse2.apache.conf<br>
</pre>
Copy the resulting file into the appropriate directory as described above.

### Setting up FastCGI with GBrowse ###
I recommend enabling FastCGI to speed up web rendering. This enables running the GBrowse Perl script to run as long-lived process, rather than executing the Perl script each and every time you do something in the browser. This should be a noticeable improvement in browsing.

#### FastCGI on 10.6 Snow Leopard ####
To enable on Mac OS X 10.6 Snow Leopard, you will have to edit the file `/etc/apache2/httpd.conf` as root. Find the following line in the file and un-comment it.
<pre>
# LoadModule fastcgi_module     libexec/apache2/mod_fastcgi.so<br>
</pre>

#### FastCGI on 10.7 or later ####
To enable FastCGI on OS X 10.7 Lion or later, you will need to install it, as Apple no longer includes it. Download Apache's updated [FastCGI](http://httpd.apache.org/mod_fcgid/) source package from their [mirror](http://httpd.apache.org/download.cgi#mod_fcgid). Unpack, and install using the following commands.
<pre>
./configure.apxs<br>
make<br>
sudo make install<br>
</pre>
It should install `mod_fcgid.so` into `/usr/libexec/apache2/` for you and automatically update `/etc/apache2/httpd.conf` to enable the FastCGI daemon.

Note that with XCode 4.x on 10.8, there is a bug with XCode when running the `./configure.apxs` step. You get an error from `libtool` saying that `cc` could not be found. The issue and solution is described  [here](http://apple.stackexchange.com/questions/58186/how-to-compile-mod-wsgi-mod-fastcgi-etc-on-mountain-lion-by-fixing-apxserror). You will need to make a symbolic link using the following command.
<pre>
sudo ln -s /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/ /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.9.xctoolchain<br>
</pre>
If you are on OS X 10.8, substitute "OSX10.8" in the last part of the command above. You should "`make clean`", then run "`./configure.apxs`" and "`make`" commands again; it should compile successfully.

#### FastCGI Permissions ####
Sometimes I have permissions problems executing the scripts, especially when using FastCGI. You will need to edit the file `/etc/apache2/other/gbrowse2.conf` (see above if it's not present). Find this entry in the file
<pre>
<Directory "/Library/Webserver/CGI-Executables/gb2"><br>
Options ExecCGI<br>
SetEnv GBROWSE_CONF   "/etc/gbrowse2"<br>
<br>
<br>
Unknown end tag for </Directory><br>
<br>
<br>
</pre>
and add the following lines to make this
<pre>
<Directory "/Library/Webserver/CGI-Executables/gb2"><br>
Options ExecCGI<br>
SetEnv GBROWSE_CONF   "/etc/gbrowse2"<br>
# extra permissions<br>
Order allow,deny<br>
Allow from all<br>
<br>
<br>
Unknown end tag for </Directory><br>
<br>
<br>
</pre>
Finally, restart the Apache server (you should see "fcgi" mentioned in the Apache log when restarting), and try the new link http://localhost/fgb2/gbrowse.

### Setting up GBrowse user accounts ###
One of the cool things about GBrowse is the ability to offer [user accounts](http://www.gmod.org/wiki/GBrowse_User_Database). This allows multiple users to store their file uploads and personal settings and, more importantly, have them persistently available across browser and platform sessions.

GBrowse can accept [OpenID](http://openid.net) authentications, Pluggable Authentication Modules (PAM), or handle its own user set up and authentications. More information about authenticating users can be found [here](http://www.gmod.org/wiki/GBrowse_Configuration/Authentication).

#### Setting up PAM Authentication with OS X accounts ####
For a small lab setting with a limited number of controlled users, I find it easy to set up the PAM authentication using the Mac OS X user accounts for authentication. For larger setups, you may want to investigate other options.

You will need to install some additional Perl modules before you begin.
  * `Authen::Simple`
  * `Authen::PAM`
  * `Authen::Simple::PAM`
These will likely require installing some other dependencies. CPAN should take care of that for you.

Next, create a new service definition file in `/etc/pam.d/` named `gbrowse` with the following content.
<pre>
# login: auth account password session<br>
auth       optional       pam_krb5.so use_kcminit<br>
account    required       pam_nologin.so<br>
</pre>
These should be the only services you need, empirically selected from those present in the `login` file.

Next you'll need to enable user accounts in GBrowse. Edit the main GBrowse configuration file, `/etc/gbrowse2/GBrowse.conf`. Find the line "`user_accounts`" and change the `0` to `1` to enable. Next, uncomment the following line:
<pre>
authentication plugin = PamAuthenticate<br>
</pre>
To add login hints and help text, find the `PamAuthenticate:plugin` stanza and edit the appropriate lines as necessary.

Save the file, restart the Apache web server, reload the GBrowse page, and you should now have login link in the upper right corner. Provide your Mac OS X user account credentials to login.

### Cleaning up after GBrowse ###
GBrowse creates a lot of small temporary image files. The built-in OS X scripts for cleaning your Mac won't touch these, and over time they will really pile up and eventually create havoc on your system. GBrowse comes with a script, `gbrowse_clean.pl` which will read the settings in the main `GBrowse.conf` configuration file and clean up old temporary files, expired sessions, and old untouched uploads. The trick is running it as the Apache user so that it will have ownership over the files and perform its duties. You can run it manually like so:
<pre>
sudo -u _www /usr/local/bin/gbrowse_clean.pl<br>
</pre>

An even better option is to have `launchd`, the OS X equivalent of `init.d` and `cron` in Linux, run it periodically for you. Create a new text file, `org.gmod.gbrowse_clean.plist`, and paste the following contents into it.
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>org.gmod.gbrowse_clean</string>
	<key>UserName</key>
	<string>_www</string>
	<key>Program</key>
	<string>/usr/local/bin/gbrowse_clean.pl</string>
	<key>StartCalendarInterval</key>
	<dict>
		<key>Hour</key>
		<integer>22</integer>
		<key>Minute</key>
		<integer>0</integer>
		<key>Weekday</key>
		<integer>0</integer>
	</dict>
</dict>
</plist>
```

Save the file in `/Library/LaunchDaemons/`, make it owned by root, and load it by running the following commands.
<pre>
sudo chown root:wheel /Library/LaunchDaemons/org.gmod.gbrowse_clean.plist<br>
sudo /bin/launchctl load /Library/LaunchDaemons/org.gmod.gbrowse_clean.plist<br>
</pre>

You can also simply reboot the computer to load the job. It should now automatically clean up your GBrowse files at 10:00 PM every Sunday. Messages concerning its execution will be reported in the system log.

## Additional Tools ##
There are additional tools that are useful for bioinformatics analysis but are not necessarily needed for BioPerl, GBrowse, or BioToolBox. These are simply programs that I have found to be helpful in my own work.
  * [GNU parallel](http://www.gnu.org/software/parallel/) is an incredible tool for running command-line programs in a parallel fashion. This is especially useful for running many single-threaded programs (most Perl scripts, **BioToolBox** included) in a timely fashion on a multi-core machine, particularly when running the same program over a series of parameters or files. Writing multi-level `for` loops in Bash are no longer necessary. It can be installed through Fink.
  * [Novocraft's](http://www.novocraft.com) novoalign alignment tool. This is quite useful in aligning short sequence tags, generated for example by Illumina next-generation sequencing, to the genome. While it's not a particularly fast aligner, it is quite thorough by tolerating mismatches and gaps, perfect for identifying SNPs and mutations. It handles paired-end, RNA sequencing, and bisulfite sequencing.
  * An alternative and fast aligner is [bowtie](http://bowtie-bio.sourceforge.net/). This is ideal for ChIP-Seq, where exact sequence alignments are not of the highest importance but rather identifying location.
  * [Cluster](http://bonsai.hgc.jp/~mdehoon/software/cluster/software.htm) is an extremely useful program to generate heirarchical and k-means clusters. This is useful in identifying groups of features or genes based on collected data, for example microarray or ChIP-Seq data. This is a Java GUI program capable of many different clustering algorithms. For simply k-means clustering, you can also check out my BioToolBox script [run\_cluster.pl](Pod_run_cluster.md).
  * [TreeView](http://jtreeview.sourceforge.net/) is a Java application perfect for displaying and visualizing the dendograms generated by the Cluster program. I have also used it to visualize the collected data mapped around a class of features generated with the BioToolBox script [map\_data.pl](Pod_map_data.md). The [manipulate\_datasets.pl](Pod_manipulate_datasets.md) script has a function to export a data file to a simple text file that may be imported into either Treeview or Cluster.
  * David Nix's [USeq](http://useq.sourceforge.net) and [T2](http://http://timat2.sourceforge.net/) suites of programs is an alternative suite of Java based programs for processing and analyzing next-generation sequencing and microarray data, respectively.

### Compiling a 64-bit liftOver tool on OS X ###
The UCSC source tree includes a number of other additional programs. One useful one is the [liftOver](http://genome.ucsc.edu/cgi-bin/hgLiftOver) tool for converting coordinates between genome versions. While they provide a 32-bit executable for [download](http://hgdownload.cse.ucsc.edu/admin/exe/) that is probably sufficient, if you want a 64-bit version you will need to compile one yourself. These instructions may also work with other tools (blat?).

This presumes you've followed the [instructions above](SetupForMacOSX#Installing_BigFile_Support.md) for installing the bigFile support (bigWig and bigBed). It also presumes you have installed MySQL and libpng (a prerequisite for the GD libraries) using Fink. While these are are not required for liftOver per se, they are required for the UCSC libraries that are needed by liftOver.

The liftOver tool is not included under `kent/src/utils/`, but rather a part of the browser. Therefore, we need to compile additional libraries. First, we need to set up some more environment variables. Adjust the paths as necessary if you did not use Fink.
<pre>
export PNGLIB=/sw/lib/libpng.a<br>
export MYSQLINC=/sw/include/mysql<br>
export MYSQLLIBS="/sw/lib/mysql/libmysqlclient.a -lz"<br>
</pre>

Next, we compile the additional libraries.
<pre>
cd kent/src/jkOwnLib<br>
make<br>
cd ../hg/lib<br>
make<br>
</pre>

You should now have `jkhgap.a` and `jkOwnLib.a` libraries located under `kent/lib/x86_64`, in addition to `jkweb.a` from before.

To compile liftOver, move into its directory and issue "`make`".
<pre>
cd kent/src/hg/liftOver<br>
make<br>
</pre>
You should now have a 64-bit liftOver executable in `~/bin/x86_64/`.

### Installing Python via Fink ###
There are an increasing number of useful programs written in the Python language. One of my favorites is the  tool for analyzing ChIPSeq data. Mac OS X includes a Python interpretor, which you could use use, or you can install your own. If you are using an older version of OS X (like 10.6) I would recommend installing your own. The consensus from several different web sources suggest it's genrally better to install your own interpretor, probably much like Perl.

Installing your own Python interpretor is easy with Fink. The nice thing about Finks is it takes care of all the dependencies for you and will install useful libraries, such as numpy and scipy.

Issue the following command. Provide your `sudo` password when requested. Note that this will take a while, considering that it must compile some 50 packages, including an updated Gnu C Compiler (sigh).
<pre>
fink install python python-py27 scipy-py27 numpy-py27 biopython-py27<br>
</pre>

You should now have python installed under `/sw/bin/`, which you can verify running the "`which python`" command.

#### Installing MACS ####
[MACS](http://liulab.dfci.harvard.edu/MACS/) is a popular tool for analyzing ChIP-Seq data. Currently, there are two versions available, the standard release 1.4, and the new, improved, beta version release 2.0. You can install both, or pick one. I recommend the version 2 release because of numerous improvements and because it is the preferred version going forward. You can obtain the version from the [GitHub repository](https://github.com/taoliu/MACS/downloads) or by searching the [Python Package Index](https://pypi.python.org/pypi?%3Aaction=search&term=macs2&submit=search).

To install MACS, download the package, unpack the archive, and move into the directory. Issue the following command to install.
<pre>
python setup.py install<br>
</pre>

If you are installing into either the python library you installed under Fink or the system library, you will want to prepend the command with "`sudo`".

If you using the system-installed Python, but don't have `sudo` access, you can install into your own home directory. Just add the option "`--prefix /Users/username/Library`" to the setup command.

### Installing mfold ###
[mfold](http://mfold.rna.albany.edu/?q=mfold/download-mfold) is a venerable software for predicting secondary structures of nucleic acid, typically RNA but also DNA. It has been superseded by another package which requires a license, but mfold is still freely available. This is my guide for getting it installed.

There are no listed prerequisites that I could find, but this is a best effort short list that I could elucidate.
  * XCode to obtain the GCC and Fortran compilers
  * GD libraries, which you can install through Fink. See [Installing GD Libraries](SetupForMacOSX#Installing_GD_Libraries.md).
  * Ghostscript, a command line postscript renderer, which you can also install using Fink. Try the command `fink install ghostscript-nox ghostscript-fonts`.

Download the source code from the link above. I used [version 3.5](http://mfold.rna.albany.edu/download/mfold-3.5.tar.gz). Expand the archive and move into the directory.

The trick to compiling is specifying the alternate locations of libraries, specifying 64 bit (assuming we're working with 64 bit), and the CPU architecture. These flags were determined empirically, and not all may be necessary.
<pre>
./configure CXXFLAGS=-m64 LDFLAGS=-L/sw/lib LIBS=-L/sw/lib CPPFLAGS=-I/sw/include CFLAGS=-m64 FFLAGS=-m64 CXXFLAGS="-arch x86_64"<br>
make<br>
sudo make install<br>
</pre>
This will install the executables into `/usr/local/bin/` and the data files into `/usr/local/share/mfold`. To install somewhere else, you can use the `--prefix=`, `--bindir=`, and `--datarootdir=` options to specify alternate locations. Running `./configure --help` will list more options.

On my installation, I still had some problems getting it to run correctly. Upon investigation, it turns out the data directory was not replaced properly in the main `mfold` script. Edit the file `/usr/local/bin/mfold` as root. Replace the following line at or around line 6
<pre>
export DATDIR=@PKGDATADIR@<br>
</pre>
to the following
<pre>
export DATDIR=/usr/local/share/mfold<br>
</pre>

It should now run properly.