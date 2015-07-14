archive2itunes
================

Fetch shows from archive.org and add them to your iTunes library from the command line

**ABOUT**

I love listening to live shows on [archive.org](archive.org), and one thing that I've always wanted was a simple way to add a show to my iTunes library. You can download the show and add them manually, but sometimes it would be nice to add a show without having to manually extract the files and open iTunes.

That's what this script does, it takes a URL as an argument and adds that show to your iTunes library as an album.

**USAGE**

Given no arguments, you will get a usage statement.

    $ archive2itunes

    archive2itunes version: 0.01

    USAGE: archive2itunes [-l] [-h] [-m]

     Required:
        -l|link     :    The URL to the show to transfer to iTunes.
    
     Options:
        -h|help     :    Print a usage statement.
        -m|man      :    Print the full documentation.

The only required option is a link to a show, which when given, will add that show to your iTunes library.

    $ archive2itunes -l https://archive.org/details/gd67-01-27.aud.hanno.16744.sbeok.shnf
    =====> Fetching tracks, please be patient........Done fetching tracks.
    =====> Transferring the following information to iTunes:
    --------------------------------------------------------
    Artist: Grateful Dead
    Show:   1967-01-27 - Avalon Ballroom
    Track:  1 - Morning Dew
    Track:  2 - New Potato Caboose
    Track:  3 - Viola Lee Blues
    Track:  4 - Cold Rain and Snow
    Track:  5 - Alligator
    Track:  6 - Caution
    --------------------------------------------------------
    =====> Complete. Now, fire up iTunes and enjoy!

This is free software that makes use of freely available archived concerts from the Internet Archive. Please consider [donating](https://archive.org/donate/) to support the maintenance of archive.org, and most importantly, support the bands!

**INSTALLATION**

    curl -sL cpanmin.us | perl - https://github.com/sestaton/archive2itunes

Note that the above command requires [git](http://git-scm.com/).

**SUPPORT AND DOCUMENTATION**

You can get basic usage information by typing the name of the program:

    archive2itunes

Or, specifying the help option (with `-h` or `--help`):

    archive2itunes -h

You can get more detailed usage information at the command line with the following command:

    perldoc archive2itunes

Or, by specifying the manual options with `-m` or `--man`.

**ISSUES**

Please report issues or feature requests at the issue tracker:

    https://github.com/sestaton/archive2itunes/issues

**CAVEATS**

* Portability

This is only tested on a Mac and it will not work on a PC as currently written. It would be easy to add support for Windows machines, though I do not have a PC to test with. If someone is willing to add that feature I'd be happy to incorporate the changes.

**LICENSE AND COPYRIGHT**

Copyright (C) 2015 S. Evan Staton

This program is distributed under the MIT (X11) License, which should be distributed with the package. 
If not, it can be found here: http://www.opensource.org/licenses/mit-license.php