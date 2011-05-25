package App::PipeFilter::JsonPath;

use Moose;
extends 'App::PipeFilter::Generic::Json';

use JSON::Path;

has o => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -o flag" },
  lazy          => 1,
  documentation => 'output fields (a subset of the input)',
);

has _o => (
  is            => 'rw',
  isa           => 'ArrayRef[JSON::Path]',
  lazy          => 1,
  default       => sub {
    my $self = shift;
    return [ map { JSON::Path->new($_) } @{$self->o()} ];
  },
);

sub transform {
  my $self = shift();

  my @json_paths = @{$self->_o()};

  my @output;

  my $c = 0;
  foreach my $json_path (@json_paths) {
    my $r = 0;
    foreach my $json_value ($json_path->values($_[0])) {
      $output[$r++]{"col$c"} = $json_value;
    }
    ++$c;
  }

  return @output;
}

1;

__END__

=pod

=head1 NAME

App::PipeFilter::JsonPath - return JSON::Path-specified fields from a JSON stream

=head1 SYNOPSIS

Here is the jsonpath(1) pipeline filter.

  #!/usr/bin/perl
  use App::PipeFilter::JsonPath;
  exit App::PipeFilter::JsonPath->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonPath implements the jsonpath(1) pipeline filter.
It's modeled after the UNIX cut(1) utility, but output fields are
specified by JSON::Path expressions.

This class subclasses L<App::PipeFilter::Generic::Json>.

=head1 PUBLIC ATTRIBUTES

=head2 o

The o() attribute specifies one or more fields to extract from input
and write to output.  Members are JSON::Path expressions.  All other
fields will be discarded.  MooseX::Getopt sets o() to the values of
the -o options from the command line.

=head1 PUBLIC METHODS

=head2 transform

The transform() method iterates over its input and returns new records
composed of only the fields described by the JSON::Path expressions in
o().

=head1 SEE ALSO

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonPath

L<App::PipeFilter::JsonCut> is a similar, faster, and simpler
implementation that works best with flat JSON objects.  jcut(1) should
be used whenever possible.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonPath
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonPath
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
