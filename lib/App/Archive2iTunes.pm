package App::Archive2iTunes;

use strict;
use warnings;
use File::Spec;
use File::Copy qw(move);
use HTTP::Tiny;
use WWW::Mechanize;
use MP3::Tag;

our $VERSION = '0.01';

sub new {
    my ($class, %args) = @_;

    my $self = bless {}, $class;
    $self->{opts} = $args{opts};

    return $self;
}

sub run {
    my $self = shift;
    my $opt  = $self->{opts};

    my ( $files, $info ) = $self->fetch_tracks( $opt->{link} );
    $self->print_info( $info );
    $self->transfer_to_itunes( $files );
}

sub fetch_tracks {
    my $self = shift;
    my ($url) = @_;
    my $mech  = WWW::Mechanize->new();
    $mech->get($url);

    my @links = $mech->links();

    my $list;
    for my $link (@links) {
	if (defined $link->text && $link->text eq 'VBR' && $link->url =~ /\.m3u$/) {
	        #print "Description: ",v$link->text, "\n";
	        #print "URL: ", $link->url, "\n";
	    $list = $link->url();
	}
    }
    
    my $urlbase = 'https://archive.org';
    if (defined $list) {
	$urlbase .= $list;
    }
    else {
	my $show = basename($url);
	$urlbase .= "/download/$show/".$show.'_vbr.m3u';
    }

    my $response = HTTP::Tiny->new->get($urlbase);

    unless ($response->{success}) {
	die "Can't get url $url -- Status: ", $response->{status}, " -- Reason: ", $response->{reason};
    }

    print STDERR "=====> Fetching tracks, please be patient..";

    my (@files, $info);
    for my $track (sort split /\n/, $response->{content}) {
	print STDERR ".";
	my $track_file = $self->fetch_link($track);
	$info = $self->get_track_info($track_file, $info);
	push @files, $track_file;
    }
    print STDERR "Done fetching tracks.\n";

    return (\@files, $info);
}

sub transfer_to_itunes {
    my $self = shift;
    my ($files) = @_;

    my $user = `whoami`;
    chomp $user;
    my $itunes = File::Spec->catdir('/', 'Users', $user, 'Music', 'iTunes');
    my $add_to = File::Spec->catdir($itunes, 'iTunes Music', 'Automatically Add to iTunes');

    for my $file (@$files) {
	my $itunes_file = File::Spec->catfile($add_to, $file);
	move $file, $itunes_file or die $!;
    }
    print STDERR "=====> Complete. Now, fire up iTunes and enjoy!\n";
}

sub print_info {
    my $self = shift;
    my ($info) = @_;

    print STDERR "=====> Transferring the following information to iTunes:\n";
    print STDERR "--------------------------------------------------------\n";

    for my $artist (keys %$info) {
	print STDERR "Artist: $artist\n";
	for my $album (keys %{$info->{$artist}}) {
	    print STDERR "Show:   $album\n";
	    for my $track (sort { $a =~ /^(\d+)/ <=> $b =~ /^(\d+)/ } @{$info->{$artist}{$album}}) {
		my ($num, $desc) = split /\-/, $track;
		print STDERR "Track:  $num - $desc\n";
	    }
	}
    }

    print STDERR "--------------------------------------------------------\n";
}

sub fetch_link {
    my $self = shift;
    my ($link) = @_;

    my $file = basename($link);
    my $response = HTTP::Tiny->new->get($link);

    unless ($response->{success}) {
	die "Can't get url $link -- Status: ", $response->{status}, " -- Reason: ", $response->{reason};
    }
    
    open my $out, '>', $file;
    print $out $response->{content};
    close $out;

    return $file;
}

sub get_track_info {
    my $self = shift;
    my ($file, $info) = @_;
    my ($name, $path, $suffix) = fileparse($file, qr/\.[^.]*/);
    my $mp3 = MP3::Tag->new($file);

    my ($title, $track, $artist, $album, $comment, $year, $genre) = $mp3->autoinfo();
    push @{$info->{$artist}{$album}}, $track."-".$title;

    return $info;
}
