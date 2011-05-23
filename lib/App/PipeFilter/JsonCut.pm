package App::PipeFilter::JsonCut;

use Moose;
extends 'App::PipeFilter::Generic::Json';

has o => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -o flag" },
  lazy          => 1,
  documentation => 'output fields (a subset of the input)',
);

sub transform {
  my $self = shift();

  my @fields = @{$self->o()};

  return map {
    # TODO - Can this be done without a temporary variable?
    my %x;
    @x{@fields} = @{$_}{@fields};
    \%x;
  } @_;
}

1;

__END__

=head1 NAME

App::PipeFilter::JsonCut - return certain fields from a JSON stream,
like cut(1)

=head1 SYNOPSIS

Here is the implementation of the jcut(1) pipe filter.

  #!/usr/bin/perl
  use App::PipeFilter::JsonCut;
  exit App::PipeFilter::JsonCut->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonCut extracts named fields from a stream of simple
JSON objects.  It is modeled after the UNIX cut(1) pipeline filter.

JSON is relatively verbose compared to the whitespace-separated
formats that UNIX tools are meant to deal with.  It's often beneficial
to jcut(1) the fields you need early in a pipeline chain.

App::PipeFilter::JsonCut extends L<App::PipeFilter::Generic::Json>.
The column extraction logic is implemented in a custom transform()
method.

=head1 ATTRIBUTES

This filter defines one additional attribute.

=head2 o

The o attribute (set by the -o command line flag) names one or more
JSON fields to include in the output stream.  All others fields will
be discarded.

=head1 SEE ALSO

The jcut(1) pipeline filter.

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonCut

L<App::PipeFilter::JsonPath> is a similar pipeline filter that
understands JSON::Path expressions.  Evaluating JSON::Path expressions
incurs noticeable overhead for large data sets.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and binaries included in the project.

=head1 BUGS

L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-PipeFilter>

=head1 REPOSITORY

L<https://github.com/rcaputo/app-pipefilter>

=head1 COPYRIGHT AND LICENSE

App::PipeFilter::JsonCut
is Copyright 2011 by Rocco Caputo.
All rights are reserved.
App::PipeFilter::JsonCut
is released under the same terms as Perl itself.

=cut

# vim: ts=2 sw=2 expandtab
