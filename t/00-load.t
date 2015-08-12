use strict;
use warnings FATAL => 'all';
use File::Spec;
use File::Find;
use File::Basename;
use Test::More tests => 1;

my $cmd = File::Spec->catfile('blib', 'bin', 'archive2itunes');
ok(-x $cmd, 'Can execute archive2itunes');
