archive2itunes
================

Fetch shows from archive.org and add them to your iTunes library from the command line

**ABOUT**

I love [archive.org](archive.org) for listening to live shows, and one thing that I've always wanted was a simple way to add a show to my iTunes library (without manually downloading the files, opening iTunes, etc.). That's what this script does, it takes a URL as an argument and adds that show to your iTunes library as an album.

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

Please consider [donating](https://archive.org/donate/) to support the maintenance of archive.org, and most importantly, support the bands!

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

**CAVEATS**

* Portability

This is only tested on a Mac and it will not work on a PC as currently written. It would be easy to add support for Windows machines, though I do not have a PC to test with. If someone is willing to add that feature I'd be happy to incorporate the changes.

* Speed

The tracks are fetched in a serial fashion, which can take a while if there are many songs (e.g., with a Grateful Dead show). I may add the option to fetch tracks asynchronously but this is not something that will be used often so it shouldn't really matter.

**LICENSE AND COPYRIGHT**

Copyright (C) 2015 S. Evan Staton

This program is distributed under the MIT (X11) License, which should be distributed with the package. 
If not, it can be found here: http://www.opensource.org/licenses/mit-license.php