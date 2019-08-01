# NAME

File::Stat::Ls - Perl class for converting stat to ls -l format 

# SYNOPSIS

    use File::Stat::Ls;

    my $obj = File::Stat::Ls->new;
    my $ls = $obj->ls_stat('/my/file/name.txt');

# DESCRIPTION

This class contains methods to convert stat elements into ls format.
It exports two methods: _format\_mode_ and _ls\_stat_. 
The _format\_mode_ is borrowed from _Stat::lsMode_ class by 
Mark\_Jason Dominus. The _ls\_stat_ will build a string formated as
the output of 'ls -l'.

## new ()

Input variables:

    None

Variables used or routines called:

    None

How to use:

    my $obj = new File::Stat::Ls;      # or
    my $obj = File::Stat::Ls->new;     # or

Return: new empty or initialized File::Stat::Ls object.

# METHODS

This class defines the following common methods, routines, and 
functions.

## Exported Tag: All 

The _:all_ tag includes all the methods or sub-rountines 
defined in this class. 

    use File::Stat::Ls qw(:all);

It includes the following sub-routines:

## format\_mode ($mode)

Input variables:

    $mode - the third element from stat

Variables used or routines called:

    None

How to use:

    my $md = $self->format_mode((stat $fn)[2]);

Return: string with permission bits such as -r-xr-xr-x.

## ls\_stat ($fn)

Input variables:

    $fn - file name
       ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks) = stat($fn);

Variables used or routines called:

    None

How to use:

    my $ls = $self->ls_stat($fn);

Return: the ls string such as one of the followings:

    -r-xr-xr-x   1 root     other         4523 Jul 12 09:49 uniq
    drwxr-xr-x   2 root     other       2048 Jul 12 09:50 bin
    lrwxrwxrwx   1 oracle7  dba           40 Jun 12  2002 linked.pl 
                 -> /opt/bin/linked2.pl

## stat\_attr ($fn, $typ)

Input variables:

    $fn - file name for getting stat attributes
       ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
        $atime,$mtime,$ctime,$blksize,$blocks) = stat($fn);
    $typ - what type of object that you want it to return.
      The default is to return a hash containing filename, longname,
      and a hash ref with all the element from stat.
      SFTP - to return a Net::SFTP::Attributes object 
      

Variables used or routines called:

    ls_stat

How to use:

    my $hr = $self->stat_attr($fn);  # get hash ref
    my %h  = $self->stat_attr($fn);  # get hash

Return: $hr or %h where the hash elements are depended on the type.
The default is to get a hash array with the following elements:

    filename - file name
    longname - the ls_stat string for the file
    a        - the attributes of the file with the following elements:
               dev,ino,mode,nlink,uid,gid,rdev,size,atime,mtime,
               ctime,blksize,blocks

If the type is SFTP, then it will only return a 
_Net::SFTP::Attributes_ object with the following elements: 

    flags,perm,uid,gid,size,atime,mtime

# SEE ALSO (some of docs that I check often)

Data::Describe, Oracle::Loader, CGI::Getopt, File::Xcopy, 
Oracle::Trigger, Debug::EchoMessage, CGI::Getopt, etc.

# AUTHOR

Copyright (c) 2005 Hanming Tu.  All rights reserved.
Portions Copyright (c) 2019 D3 Engineering, LLC.

This package is free software and is provided "as is" without express
or implied warranty.  It may be used, redistributed and/or modified
under the terms of the Perl Artistic License (see
http://www.perl.com/perl/misc/Artistic.html)
