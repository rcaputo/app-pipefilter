package App::PipeFilter::JsonSort;

use Moose;
extends 'App::PipeFilter::Generic';
with qw(
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

sub BUILD {
  my $self = shift;

  my $sort = (
    'sort' .
    ($self->n() ? ' -n' : '') .
    ($self->r() ? ' -r' : '') .
    ' | cut -f ' . (scalar(@{$self->k()}) + 1) . '-'
  );

  open STDOUT, '|-', $sort or die "Can't pipe into sort: $!";
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

# vim: ts=2 sw=2 expandtab
