use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

if (eval ($ExtUtils::MakeMaker::VERSION) <= 6.55) {
    print "\n[ERROR]: ExtUtils::MakeMaker >= 6.5503 is required to build the package correctly.\n";
    print "The installed version is $ExtUtils::MakeMaker::VERSION.\n";
    print "Install the latest ExtUtils::MakeMaker and try again. Exiting.\n";
    exit(1);
}

BEGIN {
    system("chmod +x bin/archive2itunes");
}

WriteMakefile(
    NAME             => 'archive2itunes',
    AUTHOR           => q{S. Evan Staton <statonse@gmail.com>},
    VERSION_FROM     => 'bin/archive2itunes',
    LICENSE          => 'MIT',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.008,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 6.5503,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
	'HTTP::Tiny'      => 0,
	'WWW::Mechanize'  => 0,
	'MP3::Tag'        => 0,
	'autodie'         => 0,
    },
    INST_SCRIPT => 'blib/bin',
    EXE_FILES   => [ 'bin/archive2itunes' ],
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    test  => { TESTS => 't/*.t' },
);

