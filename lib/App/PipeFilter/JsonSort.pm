package App::PipeFilter::JsonSort;

use Moose;
extends 'App::PipeFilter::Generic';
with qw(
  App::PipeFilter::Role::Reader::Sysread
  App::PipeFilter::Role::Input::Json
  App::PipeFilter::Role::Transform::None
);

use JSON::XS;

has k => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -k flag" },
  lazy          => 1,
  documentation => 'key fields to sort on',
);

has n => (
  is            => 'rw',
  isa           => 'Bool',
  default       => 0,
  documentation => 'sort fields numerically',
);

has r => (
  is            => 'rw',
  isa           => 'Bool',
  default       => 0,
  documentation => 'reverse sort order',
);

sub open_output {
  my ($self, $filename) = @_;

  my $sort = (
    '/usr/bin/sort' .
    " -t '\t'" .
    ($self->n() ? ' -n' : '') .
    ($self->r() ? ' -r' : '') .
    ' | /usr/bin/cut -f ' . (scalar(@{$self->k()}) + 1) . '-' .
    (
      ($filename eq '-')
      ? ''
      : " > $filename"
    )
  );

  open my $fh, '|-', $sort or die "Can't pipe into sort: $!";

  return $fh;
}

sub encode_output {
  my $self = shift();

  my @fields = @{$self->k()};

  return map {
    my %sortable;
    @sortable{@fields} = @{$_}{@fields};
    join("\t", @sortable{@fields}, encode_json($_)) . "\n";
  } @_;
}

1;

__END__

=head1 NAME

App::PipeFilter::JsonSort - a sort(1)-like filter that understands
JSON fields

=head1 SYNOPSIS

Here is the jsort pipeline filter in its entirety:

  #!/usr/bin/perl
  use App::PipeFilter::JsonSort;
  exit App::PipeFilter::JsonSort->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonSort implements a pipeline filter similar to
sort(1), except that the -k flags describe JSON fields rather than
whitespace-separated columns.

This filter provides additional attributes to better emulate sort(1).
These attributes are populated from the command line by
MooseX::Getopt.

=head1 ATTRIBUTES

This filter uses sort(1) and cut(1) to do most of its work.

=head2 k

The k attribute (set by the -k command line flag) names one or more
key JSON fields to sort by.

=head2 n

The boolean n attribute (set by the -n command line flag) tells
App::PipeFilter::JsonSort to sort numerically.  It sorts
lexicographically by default.

If specified, -n is passed to sort(1).

=head2 r

The boolean r attribute (set by the -r command line flag) instructs
App::PipeFilter::JsonSort to reverse the sort.

If spedified, -r is passed to sort(1).

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonSort

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonSort
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonSort
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
