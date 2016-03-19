use strict;
use warnings FATAL => 'all';
use File::Spec;
use Test::More tests => 2;

BEGIN {
      use_ok('App::Archive2iTunes') || print "[Error]: Could not load Archive2iTunes.\n";
}

my $cmd = File::Spec->catfile('blib', 'bin', 'archive2itunes');
ok(-x $cmd, 'Can execute archive2itunes');
