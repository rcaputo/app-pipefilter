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

=pod

=head1 NAME

App::PipeFilter::JsonCut - return specified fields from a JSON stream

=head1 SYNOPSIS

Here is the jcut(1) pipeline filter.

  #!/usr/bin/perl
  use App::PipeFilter::JsonCut;
  exit App::PipeFilter::JsonCut->new_with_options()->run();

=head1 DESCRIPTION

App::PipeFilter::JsonCut implements the jcut(1) pipeline filter.  It's
modeled after the UNIX cut(1) utility.
Please see jcut(1) for usage instructions.

This class subclasses L<App::PipeFilter::Generic::Json>.

=head1 PUBLIC ATTRIBUTES

=head2 o

The o() attribute specifies one or more fields to extract from input
and write to output.  All other fields will be discarded.
MooseX::Getopt sets o() to the values of the -o options from the
command line.

=head1 PUBLIC METHODS

=head2 transform

The transform() method iterates over its input and returns new records
composed of only the fields named in the o() attribute.

=head1 SEE ALSO

The jcut(1) pipeline filter.

You may read this module's implementation in its entirety at

  perldoc -m App::PipeFilter::JsonCut

L<App::PipeFilter::JsonPath> is a similar pipeline filter that
understands JSON::Path expressions.  Evaluating JSON::Path expressions
incurs noticeable overhead for large data sets, so use jcut(1)
whenever possible.

L<App::PipeFilter> has top-level documentation including a table of
contents for all the libraries and utilities included in the project.

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
