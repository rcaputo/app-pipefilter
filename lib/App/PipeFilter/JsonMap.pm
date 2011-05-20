package App::PipeFilter::JsonMap;

use Moose;
extends 'App::PipeFilter::Generic::Json';

has i => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -i flag" },
  lazy          => 1,
  documentation => 'input fields (a subset of the input)',
);

has o => (
  is            => 'rw',
  isa           => 'ArrayRef',
  default       => sub { die "requires one or more -o flag" },
  lazy          => 1,
  documentation => 'output fields (a subset of the input)',
);

sub BUILD {
  my $self = shift;
  die "must have same number of -i fields as -o fields" if (
    @{$self->i()} != @{$self->o()}
  );
}

sub transform {
  my $self = shift();

  my %field_map;
  @field_map{@{$self->i()}} = @{$self->o()};

  return map {
    # TODO - Can this be done without a temporary variable?
    my %x = %$_;
    $x{$field_map{$_}} = delete $x{$_} foreach keys %field_map;
    \%x;
  } @_;
}

1;

# vim: ts=2 sw=2 expandtab
