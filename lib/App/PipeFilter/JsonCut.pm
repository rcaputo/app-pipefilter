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

# vim: ts=2 sw=2 expandtab
