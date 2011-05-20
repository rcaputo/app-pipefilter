package App::PipeFilter::Role::Input::Json;

use Moose::Role;

use JSON::XS;

sub decode_input {
  # Skips $self in $_[0].
  return decode_json($_[1]);
}

1;

# vim: ts=2 sw=2 expandtab
