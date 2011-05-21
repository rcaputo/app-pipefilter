package App::PipeFilter::Role::Input::Json;

use Moose::Role;

use JSON::XS;

has _json => (
  is      => 'rw',
  isa     => 'JSON::XS',
  lazy    => 1,
  default => sub {
    my $self = shift;
    return JSON::XS->new();
  },
);

sub decode_input {
  my $self = shift();
  return map { $self->_json()->incr_parse($_) } @_;
}

1;

# vim: ts=2 sw=2 expandtab
