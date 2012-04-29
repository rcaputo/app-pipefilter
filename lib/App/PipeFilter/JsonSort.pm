package App::PipeFilter::JsonSort;

use Moose;
extends 'App::PipeFilter::Generic';
with qw(
  App::PipeFilter::Role::Reader::Sysread
  App::PipeFilter::Role::Input::Json
  App::PipeFilter::Role::Writer::Print
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

my @preferred_path = qw(
  /bin
  /usr/bin
  /sbin
  /usr/sbin
);

has sort => (
  is            => 'rw',
  isa           => 'Str',
  lazy          => 1,
  documentation => 'sort(1) command to use',
  default       => sub {
    my $self = shift();
    foreach (@preferred_path) {
      return "$_/sort" if -e "$_/sort";
    }
    return "/usr/bin/env sort";
  },
);

has cut => (
  is            => 'rw',
  isa           => 'Str',
  lazy          => 1,
  documentation => 'cut(1) command to use',
  default       => sub {
    my $self = shift();
    foreach (@preferred_path) {
      return "$_/cut" if -e "$_/cut";
    }
    return "/usr/bin/env cut";
  },
);

sub open_output {
  my ($self, $filename) = @_;

  my $sort = (
    $self->sort() .
    " -t '\t'" .
    ($self->n() ? ' -n' : '') .
    ($self->r() ? ' -r' : '') .
    ' | ' . $self->cut() . ' -f ' . (scalar(@{$self->k()}) + 1) . '-' .
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

=pod

=head1 NAME

App::PipeFilter::JsonSort - a sort(1)-like filter that understands JSON fields

=head1 SYNOPSIS

Here is the jsort(1) pipeline filter.

  #!/usr/bin/perl
  use App::PipeFilter::JsonSort;
  exit App::PipeFilter::JsonSort->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonSort implements a pipeline filter similar to
sort(1), except that the -k flags describe JSON fields rather than
whitespace-separated columns.

This filter currently provides a small subset of the options that
sort(1) does.

=head1 PUBLIC ATTRIBUTES

This filter uses sort(1) and cut(1) to do most of its work.

=head2 k

The k() attribute names one or more key JSON fields to sort by.  It is
analogous to the -k flag for sort(1).  MooseX::Getopt sets k() to the
values of the -k options from the command line.

=head2 n

The boolean n() attribute (set by the -n command line flag) tells
App::PipeFilter::JsonSort to sort numerically.  It sorts
lexicographically by default.

If specified, -n is passed to sort(1).

=head2 r

The boolean r() attribute (set by the -r command line flag) instructs
App::PipeFilter::JsonSort to reverse the sort.

If spedified, -r is passed to sort(1).

=head1 PUBLIC METHODS

=head2 encode_output

encode_output() prepeands JSON records with the values of their key
fields in tab-separated form.  This output will be piped through
sort(1) to do the actual sorting, and through cut(1) to remove the
tab-separated sorting columns.

=head2 open_output

open_output() opens output through sort(1) and cut(1).  It's a huge
cheat, but it works for simple cases.

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonSort

This class subclasses L<App::PipeFilter::Generic::Generic>.  It is
customized with L<App::PipeFilter::Role::Reader::Sysread>,
L<App::PipeFilter::Role::Input::Json> and
L<App::PipeFilter::Role::Transform::None>.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

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
